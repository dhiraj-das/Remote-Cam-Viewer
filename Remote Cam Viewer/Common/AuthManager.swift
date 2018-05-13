//
//  AuthManager.swift
//  Remote Cam Viewer
//
//  Created by Dhiraj Das on 5/13/18.
//  Copyright © 2018 Dhiraj Das. All rights reserved.
//

import Foundation
import FirebaseAuthUI

protocol AuthManagerDelegate: class {
    func didSignIn(withAuthDataResult result: AuthDataResult?, error: Error?)
}

class AuthManager: NSObject {
    
    static var isLoggedIn: Bool {
        return Auth.auth().currentUser != nil
    }
    
    static var currentUser: User? {
        return Auth.auth().currentUser
    }
    
    weak var delegate: AuthManagerDelegate?
    
    var authUI: FUIAuth?
    var authViewController: UINavigationController? {
        return authUI?.authViewController()
    }
    
    override init() {
        super.init()
        authUI = FUIAuth.defaultAuthUI()
        authUI?.delegate = self
    }
}

extension AuthManager: FUIAuthDelegate {
    
    func authUI(_ authUI: FUIAuth, didSignInWith authDataResult: AuthDataResult?, error: Error?) {
        delegate?.didSignIn(withAuthDataResult: authDataResult, error: error)
    }
    
}
