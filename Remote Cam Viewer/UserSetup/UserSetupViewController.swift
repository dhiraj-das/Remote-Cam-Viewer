//
//  UserSetupViewController.swift
//  Remote Cam Viewer
//
//  Created by Dhiraj Das on 5/13/18.
//  Copyright © 2018 Dhiraj Das. All rights reserved.
//

import UIKit

class UserSetupViewController: UIViewController {

    @IBOutlet var userSetupView: UserSetupView!
    
    lazy var authManager = AuthManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        userSetupView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        performSegueOperation()
    }

    private func performSegueOperation() {
        if AuthManager.isLoggedIn {
            guard let cameraListViewController = storyboard?.instantiateViewController(withIdentifier: "CameraListViewController") as? CameraListViewController else { return }
            navigationController?.setViewControllers([cameraListViewController], animated: true)
        }
    }
    
    private func showAuthScreen() {
        guard let authVC = authManager.authViewController else { return }
        present(authVC, animated: true, completion: nil)
    }
}

extension UserSetupViewController: UserSetupViewDelegate {
    
    func didTapProceedButton(sender: UIButton) {
        showAuthScreen()
    }
}
