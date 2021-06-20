//
//  LoginPage.swift
//  FinalProject
//
//  Created by User02 on 2021/5/4.
//


import SwiftUI
import FirebaseAuth
import FacebookLogin
import GoogleSignIn

struct LoginPage: View {
    
    @Binding var currentPage: Pages
    @Binding var playerProfile: Player
    @State var email:String = ""
    @State var password:String = ""
    @State var showAlert:Bool = false
    @State var alertSelect:Int = 0
    let GoogleSignedInNoti = NotificationCenter.default.publisher(for: Notification.Name("GoogleSignInSuccess"))
    
    func receiveResponse(user: GIDGoogleUser) {
        let userId = user.userID                  // For client-side use only!
        let idToken = user.authentication.idToken // Safe to send to the server
        let fullName = user.profile.name
        let email = user.profile.email
        print("Google SignIn in LoginPage:")
        print("userId:",userId ?? "No ID")
        print("idToken:",idToken ?? "No IDtoken")
        print("fullName:",fullName ?? "No full name")
        print("email:",email ?? "No email\n")
    }
    let UIscreenWidth = UIScreen.main.bounds.size.width
    let UIscreenHeight = UIScreen.main.bounds.size.height
    var screenWidth:CGFloat { UIscreenWidth < UIscreenHeight ? UIscreenWidth : UIscreenHeight }
    var body: some View{
        ZStack(alignment: .bottom){
            VStack{
                HStack{
                    Button(action: {
                        currentPage = lastPageStack.pop() ?? Pages.HomePage
                    }, label: {
                        Image(systemName: "arrow.left")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(.blue)
                            .frame(width:40,height:40)
                            .padding(.leading,15)
                    })
                    Spacer()
                }
                Spacer()
            }
            VStack(alignment: .center){
                VStack{
                    TextField("Your Email", text: $email,onCommit:emailLoginAction)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .frame(width:screenWidth/2)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    TextField("Your password", text: $password,onCommit:emailLoginAction)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .frame(width:screenWidth/2)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.bottom,screenWidth/16)
                    Button(action: {
                        emailLoginAction()
                    }, label: {
                        Text("Login")
                            .font(.system(size: 20,weight:.bold,design:.monospaced))
                            .foregroundColor(Color.blue)
                            .multilineTextAlignment(.center)
                            .frame(width:screenWidth / 4, height: 40)
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.blue, style: StrokeStyle(lineWidth: 3)))
                    })
                    .alert(isPresented: $showAlert)
                      { () -> Alert in alertSwitch() }
                    .padding(.bottom,screenWidth/20)
                }
                VStack{
                    Text("Login with...")
                        .font(.system(size: 20,weight:.bold,design:.monospaced))
                        .foregroundColor(Color.blue)
                    HStack{
                        Button(action: {
                            facebookLoginAction()
                        }, label: {
                            Image("facebook-logo")
                                .resizable()
                                .scaledToFit()
                                .frame(width:screenWidth/10,height: screenWidth/10)
                                .padding(.trailing)
                        })
                        Button(action: {
                            GIDSignIn.sharedInstance()?.presentingViewController = UIApplication.shared.windows.first?.rootViewController
                            GIDSignIn.sharedInstance().signIn()
                        }, label: {
                            Image("google-logo")
                                .resizable()
                                .scaledToFit()
                                .frame(width:screenWidth/10,height: screenWidth/10)
                                .padding(.leading)
                        })
                        .onReceive(GoogleSignedInNoti, perform: { _ in
                            if let user = Auth.auth().currentUser {
                                if user.providerData.count > 0 {
                                    let userInfo = user.providerData[0]
                                    playerProfile.email = user.email ?? "Google login"
                                    playerProfile.uid = user.uid
                                    playerProfile.name = userInfo.displayName ?? ""
                                    currentPage = Pages.ProfilePage
                                }
                            }
                        })
                    }
                    Text("OR")
                        .font(.system(size: 20,weight:.bold,design:.monospaced))
                        .foregroundColor(.purple)
                        .multilineTextAlignment(.center)
                        .padding(5)
                    Button(action: {
                        currentPage = Pages.SignUpPage
                    }, label: {
                        Text("SignUp")
                            .font(.system(size: 20,weight:.bold,design:.monospaced))
                            .foregroundColor(.purple)
                            .multilineTextAlignment(.center)
                            .frame(width:screenWidth / 4, height: 40)
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.purple, style: StrokeStyle(lineWidth: 3)))
                    })
                }
            }
        }
//        .onAppear{
//            print("UIscreenWidth:\(UIscreenWidth), UIscreenHeight:\(UIscreenHeight)")
//        }
    }
}

struct LoginPage_Previews: PreviewProvider {
    static var previews: some View {
        Landscape{
            LoginPage(currentPage: .constant(Pages.LoginPage),playerProfile: .constant(Player()))
        }
//        LoginPage(currentPage: .constant(Pages.LoginPage),playerProfile: .constant(Player()))
    }
}
