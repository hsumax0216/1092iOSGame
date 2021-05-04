//
//  ProfilePage.swift
//  FinalProject
//
//  Created by  on 2021/5/2.
//

import SwiftUI

struct ProfilePage: View {
    @Binding var currentPage: Pages
    @Binding var userImage: UIImage?
    @State private var email:String = ""
    @State private var name:String = ""
    @State private var money:String = ""
    let dateFormatter = DateFormatter()
    let date = Date.init(timeIntervalSince1970: 1)
    var body: some View {
        let screenWidth:CGFloat = UIScreen.main.bounds.size.width
        VStack {
            Form {
                HStack{
                    Spacer()
                    Image(uiImage: userImage ?? UIImage.init())
                        .resizable()
                        .scaledToFit()
                        .frame(width:200,height:310)
                        .padding(10)
                    Spacer()
                }
                Group{
                    HStack{
                        //Spacer()
                        Image(systemName: "person.fill")
                        Text("name:")
                        Text("\(name)")
                    }
                    HStack{
                        //Spacer()
                        Image(systemName: "envelope.circle.fill")
                        Text("email:")
                        Text("\(email)")
                    }
                    HStack{
                        //Spacer()
                        Image(systemName: "dollarsign.circle.fill")
                        Text("money:")
                        Text("\(money)")
                    }
                    HStack{
                        //Spacer()
                        Image(systemName: "doc.append")
                        Text("register Time:")
                        Spacer()
                        Text(dateFormatter.string(from: date))
                    }
                }
            }
        }
        .onAppear{
            dateFormatter.dateFormat  = "y MMM dd HH:mm"
            if userImage == nil{
                userImage = UIImage.init()
            }
        }
    }
}

struct ProfilePage_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePage(currentPage: .constant(Pages.ProfilePage),userImage: .constant(nil))
    }
}

