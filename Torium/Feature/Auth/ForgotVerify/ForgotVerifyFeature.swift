//
//  RegisterFeature.swift
//  Torium
//
//  Created by 최진모 on 1/1/26.
//

import ComposableArchitecture
import Foundation

@Reducer
struct ForgotVerifyFeature {
    @ObservableState
    struct State: Equatable {
        var email: String = ""
        var code: String = ""
        var timerDisplay: String = "00:00"
        var expiredAt: Date = .now
        var isLoading: Bool = false
        var isInvalidCode: Bool = false
        var isSuccessResend: Bool = false

        @Presents var alert: AlertState<Action.Alert>?
    }

    enum Action: BindableAction {
        case binding(BindingAction<State>)
        case onAppear
        case timerTick
        case nextTapped
        case nextResponse(Result<Void, Error>)
        case resendTapped
        case resendResponse(Result<Date, Error>)
        case resetResendState

        case alert(PresentationAction<Alert>)
        enum Alert: Equatable {}

        case delegate(Delegate)
        enum Delegate {
            case goRoot
            case goBack
            case goPassword(String)
        }
    }

    @Dependency(\.continuousClock) var clock
    @Dependency(\.authClient) var authClient
    
    nonisolated private enum CancelID {
        case timer
    }


    var body: some Reducer<State, Action> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .binding(\.code):
                state.isInvalidCode = false
                return .none

            case .binding:
                return .none
                
            case .onAppear:
                return .send(.timerTick)

            case .timerTick:
                let now = Date.now
                let remaining = max(
                    0,
                    Int(state.expiredAt.timeIntervalSince(now))
                )

                let minutes = remaining / 60
                let seconds = remaining % 60
                state.timerDisplay = String(
                    format: "%02d:%02d",
                    minutes,
                    seconds
                )

                if remaining <= 0 {
                    return .cancel(id: CancelID.timer)
                }

                return .run { send in
                    try await clock.sleep(for: .seconds(1))
                    await send(.timerTick)
                }
                .cancellable(id: CancelID.timer, cancelInFlight: true)

            case .nextTapped:
                state.isLoading = true
                return .run { [email = state.email, code = state.code] send in
                    await send(
                        .nextResponse(
                            Result {
                                try await authClient.verifyForgot(email, code)
                            }
                        )
                    )
                }

            case .nextResponse(.success):
                state.isLoading = false
                return .send(.delegate(.goPassword(state.email)))

            case .nextResponse(.failure(let error as VerificationError))
            where error == .verificationFailed:
                state.isLoading = false
                state.isInvalidCode = true
                return .none

            case .nextResponse(.failure(let error)):
                state.isLoading = false
                state.isInvalidCode = false
                state.alert = AlertState {
                    TextState("인증 실패")
                } actions: {
                    ButtonState { TextState("확인") }
                } message: {
                    TextState(error.localizedDescription)
                }
                return .none

            case .resendTapped:
                state.isLoading = true
                return .run {
                    [email = state.email] send in

                    await send(
                        .resendResponse(
                            Result { try await authClient.sendForgot(email) }
                        )
                    )
                }
                
            case .resendResponse(.success(let expiredAt)):
                state.isLoading = false
                state.isSuccessResend = true
                state.expiredAt = expiredAt
                return .merge(
                    .send(.timerTick),
                    .run { send in
                        try await clock.sleep(for: .seconds(2))
                        await send(.resetResendState)
                    }
                )

            case .resendResponse(.failure(let error)):
                state.isLoading = false
                state.alert = AlertState {
                    TextState("이메일 전송 실패")
                } actions: {
                    ButtonState { TextState("확인") }
                } message: {
                    TextState(error.localizedDescription)
                }
                return .none
                
            case .resetResendState:
                state.isSuccessResend = false
                return .none

            default: return .none
            }
        }
        .ifLet(\.$alert, action: \.alert)
    }
}
