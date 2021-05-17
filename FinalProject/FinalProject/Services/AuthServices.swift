//
//  login.swift
//  FinalProject
//
//  Created by 徐浩恩 on 2021/4/28.
//
import FirebaseAuth
import FacebookLogin
import GoogleSignIn
import UIKit
import SwiftUI

func registerUser(email:String,password:String,_ completion: @escaping (_ taken: User?) -> Void){
    print("registerUser begin")
    Auth.auth().createUser(withEmail: email, password: password) { result, error in
        guard let user = result?.user,error == nil else {
            print(error?.localizedDescription)
            completion(nil)
            return
        }
        completion(user)
        print(user.email, user.uid)
    }
    print("registerUser end")
}

func signInUser(email:String,password:String,_ completion: @escaping (_ taken: Bool) -> Void){
    print("sign in begin")
    var rtn = true
    Auth.auth().signIn(withEmail: email, password: password) { result, error in
         guard error == nil else {
            print(error?.localizedDescription)
            rtn = false
            completion(rtn)
            return
         }
        completion(rtn)
    }
    print("sign in end")
}


func FBLogOut(){
    let manager = LoginManager()
    manager.logOut()
}

func logOutUser(_ completion: @escaping (_ taken: Bool) -> Void){
    do {
        FBLogOut()
        GIDSignIn.sharedInstance().signOut()
       try Auth.auth().signOut()
    } catch {
        print(error)
        completion(false)
        return
    }
    completion(true)
}

func settingUserProfile(player:Player){
    let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
    changeRequest?.photoURL = URL(string: player.imageURL)
    changeRequest?.displayName = player.name
    changeRequest?.commitChanges(completion: { error in
       guard error == nil else {
           print(error?.localizedDescription)
           return
       }
    })
}
