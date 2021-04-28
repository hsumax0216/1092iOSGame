//
//  ContentView.swift
//  FinalProject
//
//  Created by 徐浩恩 on 2021/4/18.
//
import FirebaseStorage
import FirebaseStorageSwift
import SwiftUI
import UIKit

struct ContentView: View {
    var body: some View {
        
        VStack{
            Button(action: {
                registerUser(email:"00657013@email.ntou.edu.tw",password: "123456")
            }, label: {
                Text("register")
            })
            Button(action: {
                signInUser(email:"b2626235@gmail.com",password: "123456")
            }, label: {
                Text("sign in")
            })
            Button(action: {
                createPlayerData()
            }, label: {
                Text("player data create")
            })
            Button(action: {
//                uploadPhoto(image: UIImage(named: "pepefog")!) { result in
//                    switch result {
//                    case .success(let url):
//                       print(url)
//                    case .failure(let error):
//                       print(error)
//                    }
//                }
                filenameReader()
            }, label: {
                Image("pose/sitting/closed_legs-2")
                    .resizable()
                    .scaledToFit()
            })
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
