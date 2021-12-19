//
//  AppCoordinator.swift
//  clearscoretest
//
//  Created by Dillon Hoa on 19/12/2021.
//

import Foundation
import UIKit

class AppCoordinator {
    weak var window: UIWindow?
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [ .foregroundColor: UIColor.white]
        
        self.navigationController.navigationBar.overrideUserInterfaceStyle = .dark
        self.navigationController.navigationBar.isTranslucent = false
        
        // For iOS 15
        self.navigationController.navigationBar.compactAppearance = appearance
        self.navigationController.navigationBar.standardAppearance = appearance
        self.navigationController.navigationBar.scrollEdgeAppearance = appearance
        
        self.navigationController.navigationBar.tintColor = appearance.backgroundColor
        self.navigationController.navigationBar.shadowImage = UIImage()
        self.navigationController.navigationBar.titleTextAttributes = appearance.titleTextAttributes
    }
    
    func start() {
        let vc = DashboardViewController()
        vc.coordinator = self
        vc.viewModel = DashboardViewModel()
        self.navigationController.pushViewController(vc, animated: false)
        self.navigationController.setViewControllers([vc], animated: false)
    }
}
