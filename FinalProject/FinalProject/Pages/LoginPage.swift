//
//  LoginPage.swift
//  FinalProject
//
//  Created by User02 on 2021/5/4.
//


import SwiftUI
import FirebaseAuth
import FacebookLogin

struct LoginPage: View {
    @Binding var currentPage: Pages
    @Binding var playerProfile: Player
    @State private var email:String = ""
    @State private var password:String = ""
    @State private var showAlert:Bool = false
    @State private var alertSelect:Int = 0
    
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
    var body: some View{
        let screenWidth:CGFloat = UIScreen.main.bounds.size.width
        ZStack{
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
                    signInUser(email: email, password: password){ taken in
                        if(taken){
                            //lastPageStack.push(currentPage)
                            playerProfile.email = email
                            currentPage = Pages.ProfilePage
                        }
                        else{
                            alertSelect = 3
                            showAlert = true
                            return
                        }
                        
                    }
                }, label: {
                    Text("Login")
                        .font(.system(size: 20,weight:.bold,design:.monospaced))
                        .foregroundColor(Color.blue)
                        .multilineTextAlignment(.center)
                        .frame(width:screenWidth / 2, height: 40)
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.blue, style: StrokeStyle(lineWidth: 3)))
                })
                .alert(isPresented: $showAlert)
                  { () -> Alert in alertSwitch() }
            }
            VStack{
                Spacer()
                Text("Login with...")
                    .font(.system(size: 20,weight:.bold,design:.monospaced))
                    .foregroundColor(Color.blue)
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
                                    currentPage = Pages.ProfilePage
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
                        
                    }, label: {
                        Image("google-logo")
                            .resizable()
                            .scaledToFit()
                            .frame(width:screenWidth/4,height: screenWidth/4)
                    })
                    .padding(.leading)
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
//        .onAppear{
//            if let user = Auth.auth().currentUser {
//                print("\(user.uid) login")
//                currentPage = Pages.ProfilePage
//            } else {
//                print("not login")
//            }
//        }
    }
}

struct LoginPage_Previews: PreviewProvider {
    static var previews: some View {
        LoginPage(currentPage: .constant(Pages.LoginPage),playerProfile: .constant(Player()))
    }
}
