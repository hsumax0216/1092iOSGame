//
//  Extension_SignUpPage.swift
//  FinalProject
//
//  Created by 徐浩哲 on 2021/5/19.
//

import SwiftUI
import FirebaseAuth
import FacebookLogin
import GoogleSignIn

extension SignUpPage{
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
        case 4:
            str = "Email Input Error"
            message = "此email已被註冊過"
        case 5:
            str = "User Exist"
            message = "您已被註冊過"
        default:
            str = "content error"
        }
        return Alert(title: Text(str), message: Text(message), dismissButton: .default(Text("OK"),action:{
            showAlert = false
        }))
    }
    
    func emailSignUpAction(){
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
        searchPlayerData(email: email){ unexist in
            guard let unexist = unexist else {
                    return // value is nil; there was an error—consider retrying
                }
                if unexist {
                    registerUser(email: email, password: password){ user in
                        if let user = user{
                            //lastPageStack.push(currentPage)
                            playerProfile.email = email
                            playerProfile.uid = user.uid
                            currentPage = Pages.CreateAvatarPage
                        }
                        else{
                            alertSelect = 3
                            showAlert = true
                            return
                        }
                    }
                }
                else {
                    alertSelect = 4
                    showAlert = true
                    return
                }
        }
    }
    
    func facebookSignUpAction(){
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
                            
                            searchPlayerData(uid: user.uid){ unexist in
                                guard let unexist = unexist else {
                                        return // value is nil; there was an error—consider retrying
                                    }
                                    if unexist {
                                        let userInfo = user.providerData[0]
                                        print(userInfo.providerID, userInfo.displayName, userInfo.photoURL)
                                        playerProfile.email = user.email ?? "FB login"
                                        playerProfile.uid = user.uid
                                        playerProfile.name = userInfo.displayName ?? ""
                                        currentPage = Pages.CreateAvatarPage
                                    }
                                    else {
                                        alertSelect = 5
                                        logOutUser(){ _ in }
                                        showAlert = true
                                        return
                                    }
                            }
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
