//
//  LoginVC.swift
//  Keto Macros
//
//  Created by Sena A on 8/24/20.
//  Copyright © 2020 Project X. All rights reserved.
//

import UIKit
import AuthenticationServices

class LoginVC: UIViewController {
    
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    //Sets up the initial view
    func setupView() {
        let appleButton = ASAuthorizationAppleIDButton()
        appleButton.addTarget(self, action: #selector(didTapAppleButton), for: .touchUpInside)
        appleButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(appleButton)
        
        appleButton.cornerRadius = 17
        appleButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        NSLayoutConstraint.activate([appleButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30),
                                     appleButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
                                     appleButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30)])
    }
    
    //Opens authorization controller for the apple id sign-in
    @objc func didTapAppleButton() {
        let provider = ASAuthorizationAppleIDProvider()
        let request = provider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let controller = ASAuthorizationController(authorizationRequests: [request])
        
        controller.delegate = self
        controller.presentationContextProvider = self
        
        controller.performRequests()
    
    }

}

//Add-on to the LoginVC that stores the user's credentials, if unable to, then stores no data
extension LoginVC: ASAuthorizationControllerDelegate {
    //#1
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        
        switch authorization.credential {
            
        case let credentials as ASAuthorizationAppleIDCredential:
            user = User(credentials: credentials)
            
            storeUserCredential(credential: user?.id, credentialString: "user id")
            storeUserCredential(credential: user?.firstName, credentialString: "user first name")
            storeUserCredential(credential: user?.lastName, credentialString: "user last name")
            storeUserCredential(credential: user?.email, credentialString: "user email")
            
            performSegue(withIdentifier: "genderVCSegue", sender: self)
            
        default:
            break
        }
    }
    
    func storeUserCredential(credential: String?, credentialString: String) {
        var error: String = "LoginVC.authorizationController() #1: error code"
        if credential != nil {
            if credentialString == "user id" {
                error.append(" 21.1 -> user id issue storing data")
            } else if credentialString == "user first name" {
                error.append(" 21.2 -> user first name issue storing data")
            } else if credentialString == "user last name" {
                error.append(" 21.3 -> user last name issue storing data")
            } else if credentialString == "user email" {
                error.append(" 21.4 -> user email issue storing data")
            }
            UserDefaults.standard.set(credential, forKey: credentialString)
        } else {
            Utilities.errorMsg(error)
        }
    }
    
    //#2
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        Utilities.errorMsg("LoginVC.authorizationController(): error code 22 -> issue with authorization for apple id")
    }
}

//Add-on to the LoginVC that sets up the presentation view
extension LoginVC: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return view.window!
    }
}
