//
//  createAvatarPage.swift
//  FinalProject
//
//  Created by User02 on 2021/4/28.
//
import UIKit
import SwiftUI
struct createAvatarPage: View {
    var avatarView: some View{
        Image("body/Turtleneck")
            .resizable()
            .scaledToFit()
            .frame(width: 200, height: 300, alignment: .bottom)
            .overlay(Image("head/Bun 2")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, height: 150, alignment: .center)
                        .overlay(Image("face/Angry with Fang")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 80, height: 80, alignment: .center)
                                    .overlay(Image("accessories/Eyepatch")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 110, height: 110, alignment: .center)
                                                .offset(x:-18,y:-7))
                                    .offset(x:10,y:15))
                        .overlay(Image("facial-hair/Moustache 2")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 70, height: 70, alignment: .center)
                                    .offset(x:0,y:45))
                        .offset(x:10,y:-75))
    }
    var body: some View {
        VStack{//200
                //.padding(0)
            Spacer()
            avatarView
            Button(action:{
                let image = avatarView.snapshot()
                UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
            },label:{
                Text("snapshot")
            })
                //.padding(0)
            //ScrollView{
                HStack{
                    Spacer()
                    Text("body:")
                        .padding(.leading,5)
                    ScrollView(.horizontal){
                        HStack{
                            ForEach(body_filename, id: \.self) { name in
                                Image(name)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 50, height: 50)
                                    .border(Color.black, width: 1)
                                    .clipped()
                                }
                            }
                        }
                }
                HStack{
                    Spacer()
                    Text("pose standing:")
                        .padding(.leading,5)
                    ScrollView(.horizontal){
                        HStack{
                            ForEach(pose_standing_filename, id: \.self) { name in
                                Image(name)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 50, height: 50)
                                    .border(Color.black, width: 1)
                                    .clipped()
                                }
                            }
                        }
                }
                HStack{
                    Spacer()
                    Text("pose sitting:")
                        .padding(.leading,5)
                    ScrollView(.horizontal){
                        HStack{
                            ForEach(pose_sitting_filename, id: \.self) { name in
                                Image(name)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 50, height: 50)
                                    .border(Color.black, width: 1)
                                    .clipped()
                                }
                            }
                        }
                }
                HStack{
                    Spacer()
                    Text("head:")
                        .padding(.leading,5)
                    ScrollView(.horizontal){
                        HStack{
                            ForEach(head_filename, id: \.self) { name in
                                Image(name)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 50, height: 50)
                                    .border(Color.black, width: 1)
                                    .clipped()
                                }
                            }
                        }
                }
                HStack{
                    Spacer()
                    Text("face:")
                        .padding(.leading,5)
                    ScrollView(.horizontal){
                        HStack{
                            ForEach(face_filename, id: \.self) { name in
                                Image(name)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 50, height: 50)
                                    .border(Color.black, width: 1)
                                    .clipped()
                                }
                            }
                        }
                }
                HStack{
                    Spacer()
                    Text("facial hair:")
                        .padding(.leading,5)
                    ScrollView(.horizontal){
                        HStack{
                            ForEach(facial_hair_filename, id: \.self) { name in
                                Image(name)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 50, height: 50)
                                    .border(Color.black, width: 1)
                                    .clipped()
                                }
                            }
                        }
                }
                HStack{
                    Spacer()
                    Text("accessories:")
                        .padding(.leading,5)
                    ScrollView(.horizontal){
                        HStack{
                            ForEach(accessories_filename, id: \.self) { name in
                                Image(name)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 50, height: 50)
                                    .border(Color.black, width: 1)
                                    .clipped()
                                }
                            }
                        }
                }
            //}
        }
    }
}

struct createAvatarPage_Previews: PreviewProvider {
    static var previews: some View {
        createAvatarPage()
    }
}


/*
 Image("body/Blazer Black Tee")
     .resizable()
     .scaledToFit()
     .frame(width: 200, height: 200, alignment: .center)
     .offset(y:200)
 Image("head/Bun 2")
     .resizable()
     .scaledToFit()
     .frame(width: 150, height: 150, alignment: .center)
     .overlay(Image("face/Awe")
                 .resizable()
                 .scaledToFit()
                 .frame(width: 80, height: 80, alignment: .center)
                 .offset(x:10,y:15))
     .overlay(Image("facial-hair/Moustache 2")
                 .resizable()
                 .scaledToFit()
                 .frame(width: 70, height: 70, alignment: .center)
                 .offset(x:0,y:45))
     .offset(x:10,y:-110)
 */
