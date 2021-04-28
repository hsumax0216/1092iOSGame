//
//  login.swift
//  FinalProject
//
//  Created by 徐浩恩 on 2021/4/28.
//
import FirebaseAuth
import UIKit
import SwiftUI

func registerUser(email:String,password:String){
    print("registerUser begin")
    Auth.auth().createUser(withEmail: email, password: password) { result, error in
         guard let user = result?.user,
               error == nil else {
             print(error?.localizedDescription)
             return
         }
         print(user.email, user.uid)
    }
    print("registerUser end")
}

func signInUser(email:String,password:String){
    print("sign in begin")
    Auth.auth().signIn(withEmail: email, password: password) { result, error in
         guard error == nil else {
            print(error?.localizedDescription)
            return
         }
    }
    print("sign in end")
}
