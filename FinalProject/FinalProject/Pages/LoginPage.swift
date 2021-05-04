//
//  LoginPage.swift
//  FinalProject
//
//  Created by User02 on 2021/5/4.
//


import SwiftUI

struct LoginPage: View {
    @Binding var currentPage: Pages
    @State private var email:String = ""
    @State private var password:String = ""
    var body: some View{
        let screenWidth:CGFloat = UIScreen.main.bounds.size.width
        ZStack{
            VStack{
                HStack{
                    Spacer()
                    Text("email:")
                    TextField("Your Email", text: $email)
                        .frame(width:screenWidth/2)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.trailing,screenWidth/5)
                }
                HStack{
                    Spacer()
                    Text("password:")
                    TextField("Your password", text: $password)
                        .frame(width:screenWidth/2)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.trailing,screenWidth/5)
                }
                Text("Login")
                    .font(.system(size: 20,weight:.bold,design:.monospaced))
                    .foregroundColor(Color.blue)
                    .multilineTextAlignment(.center)
                    .frame(width:screenWidth / 2, height: 40)
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.blue, style: StrokeStyle(lineWidth: 3)))
            }
            VStack{
                Spacer()
                Text("Login with...")
                    .font(.system(size: 20,weight:.bold,design:.monospaced))
                    .foregroundColor(Color.blue)
                HStack{
                    Button(action: {
                        
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
            }
        }
    }
}

struct LoginPage_Previews: PreviewProvider {
    static var previews: some View {
        LoginPage(currentPage: .constant(Pages.LoginPage))
    }
}
