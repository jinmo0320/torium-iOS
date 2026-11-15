//
//  ProjectDTO.swift
//  Torium
//
//  Created by 최진모 on 5/20/26.
//
import Foundation

enum ProjectDTO {
    enum RES {
        struct Project: Decodable {
            let id: Int
            let name: String
            let status: ProjectStatus
            let createdAt: Date
            let updatedAt: Date
        }
        
        struct ProjectDetail: Decodable {
            let id: Int
            let name: String
            let status: ProjectStatus
            let createdAt: Date
            let updatedAt: Date
            let portfolio: PortfolioDTO.RES.Portfolio
            let plan: PlanDTO.RES.Plan
            let waringCode: ProjectWarningCode?
        }
    }
    
    enum REQ {
        struct Create: Encodable {
            let name: String
        }
    }
}

enum ProjectStatus: String, Codable {
    case PENDING = "PENDING"
    case STABLE = "STABLE"
    case WARNING = "WARNING"
    case DISABLED = "DISABLED"
}

enum ProjectWarningCode: String, Codable {
    case EMPTY_PLAN = "EMPTY_PLAN"
    case EMPTY_PORTFOLIO = "EMPTY_PORTFOLIO"
    case EMPTY_RISK_TYPE = "EMPTY_RISK_TYPE"
    case INVALID_PORTFOLIO = "INVALID_PORTFOLIO"
    case TYPE_PLAN_MISMATCH = "TYPE_PLAN_MISMATCH"
    case PLAN_PORTFOLIO_MISMATCH = "PLAN_PORTFOLIO_MISMATCH";
}
