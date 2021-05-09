//
//  ContentView.swift
//  FinalProject
//
//  Created by 徐浩恩 on 2021/4/18.
//

import SwiftUI
import FirebaseAuth
import FacebookLogin
//struct ContentView: View {
//    var body: some View {
//        Button(action: {
//            /*FB 原始登入*/
////            let manager = LoginManager()
////            manager.logIn { (result) in
////                if case LoginResult.success(granted: _, declined: _, token: _) = result {
////                    print("login ok")
////                } else {
////                    print("login fail")
////                }
////            }
//            /*FB+Firebase登入*/
//            let manager = LoginManager()
//            manager.logIn { (result) in
//                if case LoginResult.success(granted: _, declined: _, token: _) = result {
//                    print("fb login ok")
//
//                    let credential =  FacebookAuthProvider.credential(withAccessToken: AccessToken.current!.tokenString)
//                        Auth.auth().signIn(with: credential) { (result, error) in
//                        guard error == nil else {
//                            print(error?.localizedDescription)
//                            return
//                        }
//                        print("login ok")
//                    }
//
//                } else {
//                    print("login fail")
//                }
//            }
//
//        }) {
//            Text("Login")
//        }
//
//    }
//}

//struct ContentView: View {
//    @State private var users = ["Paul", "Taylor", "Adele"]
//
//    var body: some View {
//        NavigationView {
//            Form {
//                ForEach(users, id: \.self) { user in
//                    Text(user)
//                }
//
//                .onDelete(perform: delete)
//            }
//            .toolbar {
//                EditButton()
//            }
//        }
//    }
//
//    func delete(at offsets: IndexSet) {
//        users.remove(atOffsets: offsets)
//    }
//}

struct ContentView: View {
    @State private var selectedStrength = "Mild"
    let strengths = ["Mild", "Medium", "Mature"]

    var body: some View {
        NavigationView {
            Form {
                //Section {
                    Picker("Strength", selection: $selectedStrength) {
                        ForEach(strengths, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(DefaultPickerStyle())
                //}
            }
            .navigationTitle("Select your cheese")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
