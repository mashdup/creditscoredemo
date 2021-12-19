//
//  DashboardService.swift
//  clearscoretest
//
//  Created by Dillon Hoa on 19/12/2021.
//

import Foundation

protocol DashboardServiceProtocol {
    func getDashboardValues(_ completion: @escaping ((Swift.Result<Dashboard, Error>) -> Void))
}

class DashboardService: DashboardServiceProtocol {
    
    private enum Path: String {
        case dashboard = "/prod/mockcredit/values"
    }
    
    func getDashboardValues(_ completion: @escaping ((Swift.Result<Dashboard, Error>) -> Void)) {
        NetworkManager.default.request(Dashboard.self, path: Path.dashboard.rawValue, completion: completion)
    }
}
