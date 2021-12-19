//
//  MainViewController.swift
//  clearscoretest
//
//  Created by Dillon Hoa on 19/12/2021.
//

import UIKit

class DashboardViewController: UIViewController {
    
    weak var coordinator: AppCoordinator?
    
    private lazy var dashboardScoreView: DashboardScoreView = {
        let d = DashboardScoreView()
        return d
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        dashboardScoreView.progressView.progress = 0.8
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
}
