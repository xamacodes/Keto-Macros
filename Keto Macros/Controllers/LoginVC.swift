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
    
    func setupView() {
        let appleButton = ASAuthorizationAppleIDButton()
        appleButton.addTarget(self, action: #selector(didTapAppleButton), for: .touchUpInside)
        appleButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(appleButton)
        NSLayoutConstraint.activate([appleButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                                     appleButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
                                     appleButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30)])
    }
    
    @objc func didTapAppleButton() {
        let provider = ASAuthorizationAppleIDProvider()
        let request = provider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let controller = ASAuthorizationController(authorizationRequests: [request])
        
        controller.delegate = self
        controller.presentationContextProvider = self
        
        controller.performRequests()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let newHomeVC = segue.destination as? NewHomeVC /*, let user = sender as? User*/ {
            newHomeVC.user = user
        } else {
            print("error with segue.")
        }
    }

}

extension LoginVC: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        
        switch authorization.credential {
            
        case let credentials as ASAuthorizationAppleIDCredential:
            user = User(credentials: credentials)
            performSegue(withIdentifier: "newHomeVCSegue", sender: self)
            
        default:
            break
            
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("Apple sign-in error: ", error)
    }
}

extension LoginVC: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return view.window!
    }
    
}
