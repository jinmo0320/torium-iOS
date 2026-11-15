//
//  InvProfileDTO.swift
//  Torium
//
//  Created by 최진모 on 3/8/26.
//

struct InvProfileDTO {
   struct RiskType {
        let riskType: String
    }
    
    struct Plan {
        let plan: MTRF
        
        nonisolated struct MTRF {
        }
    }
}
