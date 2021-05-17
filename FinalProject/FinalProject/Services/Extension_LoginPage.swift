//
//  Extension_LoginPage.swift
//  FinalProject
//
//  Created by 徐浩哲 on 2021/5/17.
//

import SwiftUI
import FirebaseAuth
import FacebookLogin
import GoogleSignIn

extension LoginPage{
    func alertSwitch() -> Alert{
        var str = "content error"
        var message = "請正確填入資料"
        switch alertSelect {
        case 0:
            str = "Email Input Error"
        case 2:
            str = "Password Input Error"
        case 3:
            str = "Login Error"
            message = "Email 或 Password 輸入錯誤"
        default:
            str = "content error"
        }
        return Alert(title: Text(str), message: Text(message), dismissButton: .default(Text("OK"),action:{
            showAlert = false
        }))
    }
    
    func emailLoginAction(){
        if email.count <= 0{
            alertSelect = 0
            showAlert = true
            return
        }
        if password.count <= 0{
            alertSelect = 1
            showAlert = true
            return
        }
        signInUser(email: email, password: password){ taken in
            if(taken){
                playerProfile.email = email
                if let user = Auth.auth().currentUser{
                    playerProfile.uid = user.uid
                    playerProfile.name = user.displayName ?? ""
                    currentPage = Pages.ProfilePage
                }
            }
            else{
                alertSelect = 3
                showAlert = true
                return
            }
        }
    }
    
    func facebookLoginAction(){
        let manager = LoginManager()
        manager.logIn { (result) in
            if case LoginResult.success(granted: _, declined: _, token: _) = result {
                print("fb login ok")
                
                let credential =  FacebookAuthProvider.credential(withAccessToken: AccessToken.current!.tokenString)
                    Auth.auth().signIn(with: credential) { (result, error) in
                    guard error == nil else {
                        print(error?.localizedDescription)
                        return
                    }
                    if let user = Auth.auth().currentUser {
                        print("\(user.providerID) login")
                        if user.providerData.count > 0 {
                            let userInfo = user.providerData[0]
                            print(userInfo.providerID, userInfo.displayName, userInfo.photoURL)
                            playerProfile.email = user.email ?? "FB login"
                            playerProfile.uid = user.uid
                            playerProfile.name = userInfo.displayName ?? ""
                            currentPage = Pages.ProfilePage
                        }
                    }
                    else {
                        print("fb login getdata fail.")
                    }
                    print("login ok")
                }
                
            } else {
                print("login fail")
            }
        }
    }
}
