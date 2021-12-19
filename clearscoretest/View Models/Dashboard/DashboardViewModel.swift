//
//  DashboardViewModel.swift
//  clearscoretest
//
//  Created by Dillon Hoa on 19/12/2021.
//

import Foundation
import Combine

class DashboardViewModel {
    
    @Published private (set) var dashboard: Dashboard?
    var subscribers: [AnyCancellable] = []
    
    private let service: DashboardServiceProtocol = DashboardService()
    
    func fetchDashboardValues(_ completion: @escaping ((Swift.Result<Dashboard, Error>) -> Void)) {
        service.getDashboardValues { [weak self] result in
            if case let .success(dashboard) = result {
                self?.dashboard = dashboard
            }
            completion(result)
        }
    }
}
