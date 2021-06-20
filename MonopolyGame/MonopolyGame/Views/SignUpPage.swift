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
    @State var email:String = ""
    @State var password:String = ""
    @State var showAlert:Bool = false
    @State var alertSelect:Int = 0
    let GoogleSignedInNoti = NotificationCenter.default.publisher(for: Notification.Name("GoogleSignInSuccess"))
    
    let UIscreenWidth = UIScreen.main.bounds.size.width
    let UIscreenHeight = UIScreen.main.bounds.size.height
    var screenWidth:CGFloat { UIscreenWidth < UIscreenHeight ? UIscreenWidth : UIscreenHeight }
    var body: some View{
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
            VStack(alignment:.center){
                VStack{
                    TextField("Your Email", text: $email,onCommit:emailSignUpAction)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .frame(width:screenWidth/2)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    TextField("Your password", text: $password,onCommit:emailSignUpAction)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .frame(width:screenWidth/2)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.bottom,screenWidth/16)
                    Button(action: {
                            emailSignUpAction()
                        }, label: {
                            Text("SignUp")
                                .font(.system(size: 20,weight:.bold,design:.monospaced))
                                .foregroundColor(.purple)
                                .multilineTextAlignment(.center)
                                .frame(width:screenWidth / 4, height: 40)
                                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.purple, style: StrokeStyle(lineWidth: 3)))
                        })
                        .alert(isPresented: $showAlert)
                          { () -> Alert in alertSwitch() }
                        .padding(.bottom,screenWidth/20)
                }
                VStack{
                    Text("SignUp with...")
                        .font(.system(size: 20,weight:.bold,design:.monospaced))
                        .foregroundColor(.purple)
                    HStack{
                        Button(action: {
                            facebookSignUpAction()
                        }, label: {
                            Image("facebook-logo")
                                .resizable()
                                .scaledToFit()
                                .frame(width:screenWidth/10,height: screenWidth/10)
                        })
                        .padding(.trailing)
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
                                    
                                    PlayerFirestore.shared.searchPlayerData(email: playerProfile.email){ unexist in
                                        guard let unexist = unexist else {
                                                return // value is nil; there was an error—consider retrying
                                            }
                                            if unexist {
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
        Landscape{
            SignUpPage(currentPage: .constant(Pages.SignUpPage),playerProfile: .constant(Player()))
        }
        //SignUpPage(currentPage: .constant(Pages.SignUpPage),playerProfile: .constant(Player()))
    }
}

