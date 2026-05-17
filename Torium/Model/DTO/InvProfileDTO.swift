//
//  InvProfileDTO.swift
//  Torium
//
//  Created by 최진모 on 3/8/26.
//

nonisolated struct InvProfileDTO {
    nonisolated struct RiskType {
        let riskType: String
    }
    
    nonisolated struct Plan {
        let plan: MTRF
        
        nonisolated struct MTRF {
        }
    }
}
