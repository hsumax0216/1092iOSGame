//
//  charactorPage.swift
//  FinalProject
//
//  Created by 徐浩恩 on 2021/4/28.
//

import SwiftUI

struct charactorPage: View {
    @State private var email:String = ""
    @State private var name:String = ""
    @State private var money:String = ""
    var body: some View {
        let screenWidth:CGFloat = UIScreen.main.bounds.size.width
        VStack{
            Image("pepefog")
                .resizable()
                .scaledToFit()
                .border(Color.black, width: 1)
                .padding(10)
            HStack{
                Spacer()
                Text("name:")
                TextField("Your Name", text: $name)
                    .frame(width:screenWidth/2)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.trailing,screenWidth/5)
            }
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
                Text("money:")
                TextField("Your Money", text: $money)
                    .frame(width:screenWidth/2)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.numberPad)
                    .padding(.trailing,screenWidth/5)
            }
        }
    }
}

struct charactorPage_Previews: PreviewProvider {
    static var previews: some View {
        charactorPage()
    }
}

