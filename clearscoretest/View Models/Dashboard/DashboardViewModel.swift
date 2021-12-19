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
    
    func fetchDashboardValues() {
        service.getDashboardValues { [weak self] result in
            switch result {
            case .success(let dashboard):
                self?.dashboard = dashboard
            case .failure(let error):
                print(error)
            }
        }
    }
}
