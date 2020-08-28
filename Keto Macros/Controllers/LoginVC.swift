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
        NSLayoutConstraint.activate([appleButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30),
                                     appleButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
                                     appleButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30)])
    }
    
    //Sends the user data to the NewHomeVC
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let newHomeVC = segue.destination as? NewHomeVC /*, let user = sender as? User*/ {
            newHomeVC.user = user
        } else {
            Utilities.errorMsg("LoginVC.prepare(): error code 21 -> issue with segue")
        }
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
        Utilities.errorMsg("LoginVC.authorizationController(): error code 22 -> issue with authorization for apple id")
    }
}

//Add-on to the LoginVC that sets up the presentation view
extension LoginVC: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return view.window!
    }
}
