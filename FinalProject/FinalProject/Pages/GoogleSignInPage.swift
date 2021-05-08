//
//  GoogleSignInPage.swift
//  FinalProject
//
//  Created by  on 2021/5/7.
//

import UIKit
import SwiftUI
import GoogleSignIn

//class ViewController : UIViewController{
//    var signInButton:GIDSignInButton!
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        GIDSignIn.sharedInstance()?.presentingViewController = self
//        GIDSignIn.sharedInstance()?.signIn()
//        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.receiveToggleAuthUINotification(_:)), name: NSNotification.Name(rawValue: "ToggleAuthUINotification"), object: nil)
//    }
//
//    @IBAction func googleLogin(_ sender: UIButton) {
//        //GIDSignIn.sharedInstance()?.presentingViewController = self
//        GIDSignIn.sharedInstance()?.signIn()
//    }
//
//    @objc func receiveToggleAuthUINotification(_ notification: NSNotification){
//        if notification.name.rawValue == "ToggleAuthUINotification"{
//            guard let userInfo = notification.userInfo as? [String:String] else{return}
//            print("google userInfo:\(userInfo["statusText"]!)")
//        }
//    }
//}

struct GoogleSignInButton : UIViewRepresentable{
    func makeUIView(context: Context) -> GIDSignInButton{
        GIDSignIn.sharedInstance()?.presentingViewController = UIApplication.shared.windows.first?.rootViewController
        let button = GIDSignInButton()
        button.colorScheme = .light
        return button
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
    
    typealias UIViewControllerType = UIView
    
}

struct contentview:View{
    @EnvironmentObject var googleDelegate: GoogleDelegate
    
    var body: some View{
        GoogleSignInButton()
    }
}


struct GoogleSignInPage_Previews: PreviewProvider {
    static var previews: some View {
        contentview()
    }
}
