//
//  WelcomeVC.swift
//  Keto Macros
//
//  Created by Sena A on 7/31/20.
//  Copyright © 2020 Project X. All rights reserved.
//

import UIKit
import WebKit
import MessageUI

class WelcomeVC: UIViewController, MFMailComposeViewControllerDelegate {
    
    @IBOutlet weak var viewResultsBtn: BorderButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // UserDefaults.standard.set(false, forKey: "results VC reached") //Here for testing purposes

        setupView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //Sets up the initial view
    func setupView() {
        viewResultsBtn.isHidden = true
        checkIfTakenQuiz()
    }
    
    //To determine if the view results button should be shown; only after they take the quiz once
    func checkIfTakenQuiz() {
        if let haveTakenQuiz = UserDefaults.standard.object(forKey: "results VC reached") as? Bool {
            if haveTakenQuiz {
                viewResultsBtn.isHidden = false
            }
        } else {
            Utilities.errorMsg("WelcomeVC.checkIfTakenQuiz(): error code 0 -> nil value")
        }
    }
    
    //Setting template for the email
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        let mailComposeVC = MFMailComposeViewController()
        mailComposeVC.mailComposeDelegate = self
        
        mailComposeVC.setToRecipients(["ketomacros@gmail.com"])
        mailComposeVC.setMessageBody("Thank you for contacting us. Your feedback means the world! Typically, we reply within 2 business days. Happy Keto eating!", isHTML: false)
        
        return mailComposeVC
    }
    
    //Handling any errors with sending the email
    func showSendMailErrorAlert() {
        let message = "Oops! Problem on our end. Email us at: ketomacros@gmail.com."
        let alertController = UIAlertController(title: "Email Error", message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "Dismiss", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        present(alertController, animated: true, completion: nil)
    }
    
    //Handling any errors with the email backend processes
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        switch result {
            case MFMailComposeResult.cancelled:
                self.dismiss(animated: true, completion: nil)
                Utilities.errorMsg("WelcomeVC.mailComposeController(): error code 1.1 -> mail compose cancelled")
            case MFMailComposeResult.failed:
                self.showSendMailErrorAlert()
                self.dismiss(animated: true, completion: nil)
                Utilities.errorMsg("WelcomeVC.mailComposeController(): error code 1.2 -> mail compose failed")
            case MFMailComposeResult.sent:
                self.dismiss(animated: true, completion: nil)
            default:
                break
        }
    }
    
    //Creates .pdf to display
    func showPDF(nameOfPDF: String, desiredTitle: String) {
        let pdf = nameOfPDF
        if let url = Bundle.main.url(forResource: pdf, withExtension: "pdf") {
            let webView = WKWebView(frame: self.view.frame)
            let urlRequest = URLRequest(url: url)
            webView.load(urlRequest as URLRequest)
            
            let pdfVC = UIViewController()
            pdfVC.view.addSubview(webView)
            pdfVC.title = desiredTitle
            self.navigationController?.pushViewController(pdfVC, animated: true)
        } else {
            Utilities.errorMsg("WelcomeVC.showPDF(): error code 2 -> unable to load PDF")
        }
    }
    
    
    //Transition to the view results page
    @IBAction func viewResultsBtnTapped(_ sender: Any) {
       performSegue(withIdentifier: "oldResultsVCSegue", sender: self)
    }
    
    //Show disclosures
    @IBAction func discBtnTapped(_ sender: Any) {
        showPDF(nameOfPDF: "Keto Disclosures", desiredTitle: "Disclosures")
    }
    
    //Show privacy policy
    @IBAction func privacyBtnTapped(_ sender: Any) {
       showPDF(nameOfPDF: "Keto Privacy Policy", desiredTitle: "Privacy Policy")
    }
    
    //Display new email to ketomacros@gmail.com //TODO Need to create this
    @IBAction func helpBtnTapped(_ sender: Any) {
        let mailComposeViewController = configuredMailComposeViewController()
        if MFMailComposeViewController.canSendMail() {
            self.present(mailComposeViewController, animated: true)
        } else {
            self.showSendMailErrorAlert()
            Utilities.errorMsg("WelcomeVC.helpBtnTapped(): error code 3 -> cannot send mail")
        }
    }

}

