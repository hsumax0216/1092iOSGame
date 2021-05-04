//
//  ContentView.swift
//  FinalProject
//
//  Created by 徐浩恩 on 2021/4/18.
//

import SwiftUI
import FirebaseAuth
import FacebookLogin
struct ContentView: View {
    var body: some View {
        Button(action: {
            /*FB 原始登入*/
//            let manager = LoginManager()
//            manager.logIn { (result) in
//                if case LoginResult.success(granted: _, declined: _, token: _) = result {
//                    print("login ok")
//                } else {
//                    print("login fail")
//                }
//            }
            /*FB+Firebase登入*/
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
                        print("login ok")
                    }
                    
                } else {
                    print("login fail")
                }
            }
            
        }) {
            Text("Login")
        }
        
    }
}
//import FirebaseStorage
//import FirebaseStorageSwift
//import SwiftUI
//import UIKit
//
//struct ContentView: View {
//    var body: some View {
//
//        VStack{
//            Button(action: {
//                registerUser(email:"00657013@email.ntou.edu.tw",password: "123456")
//            }, label: {
//                Text("register")
//            })
//            Button(action: {
//                signInUser(email:"b2626235@gmail.com",password: "123456")
//            }, label: {
//                Text("sign in")
//            })
//            Button(action: {
//                //createPlayerData()
//            }, label: {
//                Text("player data create")
//            })
//            Button(action: {
//                uploadPhoto(image: UIImage(named: "pose/sitting/closed_legs-2")!) { result in
//                    switch result {
//                    case .success(let url):
//                       print(url)
//                    case .failure(let error):
//                       print(error)
//                    }
//                }
//            }, label: {
//                Image("pose/sitting/closed_legs-2")
//                    .resizable()
//                    .scaledToFit()
//            })
//
//        }
//    }
//}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
