//
//  GoogleSignInPage.swift
//  FinalProject
//
//  Created by  on 2021/5/7.
//

import UIKit
import SwiftUI
import GoogleSignIn

class ViewController : UIViewController{
    var signInButton:GIDSignInButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance()?.signIn()
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.receiveToggleAuthUINotification(_:)), name: NSNotification.Name(rawValue: "ToggleAuthUINotification"), object: nil)
    }
    
    @IBAction func googleLogin(_ sender: UIButton) {
        //GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance()?.signIn()
    }
    
    @objc func receiveToggleAuthUINotification(_ notification: NSNotification){
        if notification.name.rawValue == "ToggleAuthUINotification"{
            guard let userInfo = notification.userInfo as? [String:String] else{return}
            print("google userInfo:\(userInfo["statusText"]!)")
        }
    }
}

struct GoogleSignInPage : UIViewControllerRepresentable{
    @Binding var currentPage:Pages
    func makeUIViewController(context: Context) -> ViewController{
        return ViewController()
    }
    
    func updateUIViewController(_ uiViewController: ViewController, context: Context) {
        
    }
    
    typealias UIViewControllerType = ViewController
    
}


struct GoogleSignInPage_Previews: PreviewProvider {
    static var previews: some View {
        GoogleSignInPage(currentPage: .constant(Pages.GoogleSignInPage))
    }
}
