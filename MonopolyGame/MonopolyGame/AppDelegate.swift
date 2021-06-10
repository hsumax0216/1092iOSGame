//
//  AppDelegate.swift
//  FinalProject
//
//  Created by 徐浩恩 on 2021/4/27.
//

import UIKit
import Firebase
import FacebookCore
import GoogleSignIn
//google client ID : 261234482563-id38fb7pmn7lh9v6rjumv7o39smn6vjj.apps.googleusercontent.com
class AppDelegate: NSObject, UIApplicationDelegate, GIDSignInDelegate {
    
    var window: UIWindow?
    
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!,
              withError error: Error!) {
      if let error = error {
        if (error as NSError).code == GIDSignInErrorCode.hasNoAuthInKeychain.rawValue {
          print("The user has not signed in before or they have since signed out.")
        } else {
          print("error:\(error.localizedDescription)")
        }
        return
      }
        
        
        
        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,accessToken: authentication.accessToken)
        Auth.auth().signIn(with: credential) { (result, error) in
            guard error == nil else {
                print(error?.localizedDescription)
                return
            }
            NotificationCenter.default.post(name: Notification.Name("GoogleSignInSuccess"),object: nil)
            print("google Sigin ok")
        }
    }
    //let googleDelegate = GoogleDelegate()
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        return GIDSignIn.sharedInstance().handle(url)
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        // Override point for customization after application launch.
        ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
        FirebaseApp.configure()
        
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID//"261234482563-id38fb7pmn7lh9v6rjumv7o39smn6vjj.apps.googleusercontent.com"
        GIDSignIn.sharedInstance().delegate = self
        //GIDSignIn.sharedInstance().scopes = Constants.GS.scopes
        
        
        return true
    }
}


//class GoogleDelegate: NSObject, GIDSignInDelegate, ObservableObject {
//
////    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
////
////    }
//    var delegate : GoogleManagerDelegate?
//
//    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!,
//              withError error: Error!) {
//      if let error = error {
//        if (error as NSError).code == GIDSignInErrorCode.hasNoAuthInKeychain.rawValue {
//          print("The user has not signed in before or they have since signed out.")
//        } else {
//          print("error:\(error.localizedDescription)")
//        }
//        return
//      }
//        self.delegate?.receiveResponse(user: user)
////        guard let authentication = user.authentication else { return }
////          let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
////                                                            accessToken: authentication.accessToken)
//        signedIn = true
//      // Perform any operations on signed in user here.
//      let userId = user.userID                  // For client-side use only!
//      let idToken = user.authentication.idToken // Safe to send to the server
//      let fullName = user.profile.name
//      let givenName = user.profile.givenName
//      let familyName = user.profile.familyName
//      let email = user.profile.email
//      // ...
//        print("Google SignIn:")
//        print("userId:",userId ?? "No ID")
//        print("idToken:",idToken ?? "No IDtoken")
//        print("fullName:",fullName ?? "No full name")
//        print("givenName:",givenName ?? "No given name")
//        print("familyName:",familyName ?? "No family name")
//        print("email:",email ?? "No email\n")
//    }
//
//
////    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
////        return GIDSignIn.sharedInstance().handle(url)
////    }
//
//    @Published var signedIn: Bool? = nil
//
//}
