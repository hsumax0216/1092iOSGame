//
//  SignUpPage.swift
//  FinalProject
//
//  Created by User02 on 2021/5/4.
//

import SwiftUI
import FirebaseAuth
import FacebookLogin
import GoogleSignIn

struct SignUpPage: View {
    @Binding var currentPage: Pages
    @Binding var playerProfile: Player
    @State private var email:String = ""
    @State private var password:String = ""
    @State private var showAlert:Bool = false
    @State private var alertSelect:Int = 0
    let GoogleSignedInNoti = NotificationCenter.default.publisher(for: Notification.Name("GoogleSignInSuccess"))
    
    //@EnvironmentObject var googleDelegate: GoogleDelegate
    
//    func googleSigIn(_ completion: @escaping (_ taken: Bool?) -> Void){
//        GIDSignIn.sharedInstance()?.presentingViewController = UIApplication.shared.windows.first?.rootViewController
//        GIDSignIn.sharedInstance().signIn()
//        completion(AppDelegate.googleDelegate.signedIn)
//    }
    
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
        default:
            str = "content error"
        }
        return Alert(title: Text(str), message: Text(message), dismissButton: .default(Text("OK"),action:{
            showAlert = false
        }))
    }
    var body: some View{
        let screenWidth:CGFloat = UIScreen.main.bounds.size.width
        ZStack(alignment:.bottom){
            VStack{
                HStack{
                    Button(action: {
                        currentPage = lastPageStack.pop() ?? Pages.HomePage
                    }, label: {
                        Image(systemName: "arrow.left")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(.purple)
                            .frame(width:40,height:40)
                            .padding(.leading,15)
                    })
                    Spacer()
                }
                Spacer()
            }
            VStack{
                VStack{
                    HStack{
                        Spacer()
                        Text("email:")
                        TextField("Your Email", text: $email)
                            .disableAutocorrection(true)
                            .autocapitalization(.none)
                            .frame(width:screenWidth/2)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.trailing,screenWidth/5)
                    }
                    HStack{
                        Spacer()
                        Text("password:")
                        TextField("Your password", text: $password)
                            .disableAutocorrection(true)
                            .autocapitalization(.none)
                            .frame(width:screenWidth/2)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.trailing,screenWidth/5)
                    }
                    Button(action: {
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
                    }, label: {
                        Text("SignUp")
                            .font(.system(size: 20,weight:.bold,design:.monospaced))
                            .foregroundColor(.purple)
                            .multilineTextAlignment(.center)
                            .frame(width:screenWidth / 2, height: 40)
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.purple, style: StrokeStyle(lineWidth: 3)))
                    })
                    .alert(isPresented: $showAlert)
                      { () -> Alert in alertSwitch() }
                    
                }
                .padding(.bottom,100)
                VStack{
                    Text("SignUp with...")
                        .font(.system(size: 20,weight:.bold,design:.monospaced))
                        .foregroundColor(.purple)
                    HStack{
                        Button(action: {
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
                                                currentPage = Pages.CreateAvatarPage
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
                        }, label: {
                            Image("facebook-logo")
                                .resizable()
                                .scaledToFit()
                                .frame(width:screenWidth/4,height: screenWidth/4)
                        })
                        .padding(.trailing)
                        Button(action: {
                            GIDSignIn.sharedInstance()?.presentingViewController = UIApplication.shared.windows.first?.rootViewController
                            GIDSignIn.sharedInstance().signIn()
                        }, label: {
                            Image("google-logo")
                                .resizable()
                                .scaledToFit()
                                .frame(width:screenWidth/4,height: screenWidth/4)
                                .padding(.leading)
                        })
                        .onReceive(GoogleSignedInNoti, perform: { _ in
                            if let user = Auth.auth().currentUser {
                                if user.providerData.count > 0 {
                                    let userInfo = user.providerData[0]
                                    playerProfile.email = user.email ?? "Google login"
                                    playerProfile.uid = user.uid
                                    playerProfile.name = userInfo.displayName ?? ""
                                    
                                    searchPlayerData(email: playerProfile.email){ unexist in
                                        guard let unexist = unexist else {
                                                return // value is nil; there was an error—consider retrying
                                            }
                                            if unexist {
                                                currentPage = Pages.CreateAvatarPage
                                            }
                                            else {
                                                alertSelect = 4
                                                showAlert = true
                                                return
                                            }
                                    }
                                }
                            }
                            
                            
                        })
                    }
                    Text("OR")
                        .font(.system(size: 20,weight:.bold,design:.monospaced))
                        .foregroundColor(.blue)
                        .multilineTextAlignment(.center)
                        .padding(5)
                    Button(action: {
                        currentPage = Pages.LoginPage
                    }, label: {
                        Text("SignIn")
                            .font(.system(size: 20,weight:.bold,design:.monospaced))
                            .foregroundColor(.blue)
                            .multilineTextAlignment(.center)
                            .frame(width:screenWidth / 4, height: 40)
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.blue, style: StrokeStyle(lineWidth: 3)))
                    })
                }
            }
        }
        .onAppear{
            if let user = Auth.auth().currentUser {
                print("\(user.uid) login")
                currentPage = lastPageStack.pop() ?? Pages.HomePage
            } else {
                print("not login")
            }
        }
    }
}

struct SignUpPage_Previews: PreviewProvider {
    static var previews: some View {
        SignUpPage(currentPage: .constant(Pages.LoginPage),playerProfile: .constant(Player()))
    }
}

