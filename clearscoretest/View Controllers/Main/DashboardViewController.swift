//
//  MainViewController.swift
//  clearscoretest
//
//  Created by Dillon Hoa on 19/12/2021.
//

import UIKit
import Combine

class DashboardViewController: UIViewController {
    
    weak var coordinator: AppCoordinator?
    
    var viewModel: DashboardViewModel? {
        didSet {
            bindViewModel()
        }
    }
    
    private lazy var dashboardScoreView: DashboardScoreView = {
        let d = DashboardScoreView()
        return d
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupViews()
    }
    
    func setup() {
        title = "DASHBOARD".localised()
        view.backgroundColor = .primaryBackground
    }
    
    func setupViews() {
        view.addSubview(dashboardScoreView)
        dashboardScoreView.pinToParentCenter()
        
        NSLayoutConstraint.activate([
            dashboardScoreView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8)
        ])
    }
    
    func bindViewModel() {
        guard let viewModel = viewModel else { return }

        dashboardScoreView.viewModel = viewModel
//        viewModel.$dashboard.sink(receiveValue: { [weak self] updatedDateboard in
////            print("RETURNED WITH COMBINE")
////            print(updatedDateboard)
//        }).store(in: &viewModel.subscribers)
        viewModel.fetchDashboardValues()
    }
}
