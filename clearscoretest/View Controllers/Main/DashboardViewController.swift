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
    
    private lazy var backgroundImageView: UIImageView = {
        let i = UIImageView(image: UIImage(named: "dashboardBackground"))
        i.translatesAutoresizingMaskIntoConstraints = false
        i.contentMode = .scaleAspectFill
        return i
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
        view.addSubview(backgroundImageView)
        view.addSubview(dashboardScoreView)
        
        backgroundImageView.pinToParentView()
        dashboardScoreView.pinToParentCenter()
        let widthConstraint = dashboardScoreView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8)
        widthConstraint.priority = .defaultLow
        let heightConstraint = dashboardScoreView.widthAnchor.constraint(lessThanOrEqualTo: view.heightAnchor, multiplier: 0.8)
        NSLayoutConstraint.activate([
            widthConstraint,
            heightConstraint
        ])
    }
    
    func bindViewModel() {
        guard let viewModel = viewModel else { return }

        dashboardScoreView.viewModel = viewModel
        
        viewModel.fetchDashboardValues { [weak self] result in
            if case let .failure(error) = result {
                self?.coordinator?.handleError(error)
            }
        }
    }
}
