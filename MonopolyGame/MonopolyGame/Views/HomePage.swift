//
//  HomePage.swift
//  FinalProject
//
//  Created by  on 2021/5/2.
//

import SwiftUI
import FirebaseAuth

struct HomePage: View {
    @Binding var currentPage: Pages
    @Binding var playerProfile: Player
    @Binding var userImage:UIImage?
    @State private var signInState:Bool = false//true
    @State private var showLogoutAlert:Bool = false
    var body: some View{
        let screenWidth:CGFloat = UIScreen.main.bounds.size.width
        ZStack{
            VStack{
                HStack{
                    Spacer()
                    Button(action: {
                        showLogoutAlert = true
                    }, label: {
                        Image(systemName: "square.and.arrow.up")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(.purple)
                            .opacity(signInState ? 1 : 0.3)
                            .frame(width:40,height:40)
                            .rotationEffect(.degrees(90))
                            .padding(.trailing,15)
                    })
                    .disabled(!signInState)
                    .alert(isPresented: $showLogoutAlert)
                      { () -> Alert in
                        Alert(title: Text("Do you want to change account?"), message: Text("Press \"LogOut\" to logout and change account"), primaryButton: .default(Text("OK"),action:{
                            showLogoutAlert = false
                        }),secondaryButton: .default(Text("LogOut"), action: {
                            logOutUser(){ token in
                                if token{
                                    signInState = false
                                    playerProfile = Player()
                                    userImage = nil
                                }
                                else{
                                    print("logOutUser Error.")
                                }
                            }
                            showLogoutAlert = false
                        }))
                      }
                }
                Spacer()
            }
            VStack{
                Text("Avatar create")
                   .font(.system(size: 40,weight:.bold,design:.monospaced))
                   .foregroundColor(Color(red: 153/255, green: 0/255, blue: 255/255))
                   .multilineTextAlignment(.center)
                   .frame(width:screenWidth, height: 60)
                   .padding(.top,110)
                Button(action: {
                    lastPageStack.push(currentPage)
                    currentPage = Pages.SignUpPage
                }, label: {
                    Text("Sign up")
                        .font(.system(size: 20,weight:.bold,design:.monospaced))
                        .foregroundColor(Color(red: 153/255, green: 0/255, blue: 255/255))
                        .multilineTextAlignment(.center)
                        .frame(width:screenWidth * 0.75, height: 60)
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color(red: 153/255, green: 0/255, blue: 255/255), style: StrokeStyle(lineWidth: 5)))
                })
                .padding(.top,70)
                Button(action: {
                    if(signInState){
                        lastPageStack.push(currentPage)
                        currentPage = Pages.ProfilePage
                    }
                    else{
                        lastPageStack.push(currentPage)
                        currentPage = Pages.LoginPage
                    }
                        
                    
                }, label: {
                    Text(signInState ? "Profile" : "Sign in")
                        .font(.system(size: 20,weight:.bold,design:.monospaced))
                        .foregroundColor(Color(red: 153/255, green: 0/255, blue: 255/255))
                        .multilineTextAlignment(.center)
                        .frame(width:screenWidth * 0.75, height: 60)
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color(red: 153/255, green: 0/255, blue: 255/255), style: StrokeStyle(lineWidth: 5)))
                })
                .padding(.top,50)
            }
        }
        .onAppear{
            if let user = Auth.auth().currentUser {
                print("\(user.uid) login")
                signInState = true
                //lastPage = currentPage
                //currentPage = Pages.ProfilePage
            } else {
                print("not login")
            }
        }
    }
}

struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        HomePage(currentPage: .constant(Pages.HomePage),playerProfile: .constant(Player()),userImage: .constant(UIImage.init()))
    }
}