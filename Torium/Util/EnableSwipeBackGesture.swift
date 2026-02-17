//
//  EnableSwipeBackGesture.swift
//  Torium
//
//  Created by 최진모 on 2/16/26.
//


import SwiftUI

struct EnableSwipeBackGesture: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        let controller = UIViewController()
        DispatchQueue.main.async {
            if let navigationController = controller.navigationController {
                navigationController.interactivePopGestureRecognizer?.delegate = nil
                navigationController.interactivePopGestureRecognizer?.isEnabled = true
            }
        }
        return controller
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}

struct DisableSwipeBackGesture: UIViewControllerRepresentable {

    func makeUIViewController(context: Context) -> UIViewController {
        let controller = UIViewController()
        
        DispatchQueue.main.async {
            if let navigationController = controller.navigationController {
                navigationController.interactivePopGestureRecognizer?.isEnabled = false
            }
        }
        
        return controller
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}
