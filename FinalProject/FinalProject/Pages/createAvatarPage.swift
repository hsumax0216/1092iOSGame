//
//  createAvatarPage.swift
//  FinalProject
//
//  Created by User02 on 2021/4/28.
//
import UIKit
import SwiftUI

enum BodyPose{
    case body,standing,sitting
}

struct createAvatarPage: View {
    @State private var bodyPoseSelect:BodyPose = BodyPose.body//0:body 1:pose-sitting 2:pose-standing
    @State private var avatarBody:String = ""
    @State private var avatarHead:String = ""
    @State private var avatarFace:String = ""
    @State private var avatarAccessory:String = ""
    @State private var avatarFacialhair:String = ""
    func initalApp(){
        bodyPoseSelect = BodyPose.body
        avatarBody = "body/Blazer Black Tee"
        avatarHead = "head/Afro"
        avatarFace = "face/Blank"
        avatarAccessory = "accessories/* None"
        avatarFacialhair = "facial-hair/* None"      
        
    }
    var avatarView: some View{
        ZStack{
            switch bodyPoseSelect {
            case BodyPose.body:
                Image(avatarBody)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 300, alignment: .bottom)
                    .overlay(Image(avatarHead)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 150, height: 150, alignment: .center)
                                .overlay(Image(avatarFace)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 80, height: 80, alignment: .center)
                                            .overlay(Image(avatarAccessory)
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 110, height: 110, alignment: .center)
                                                        .offset(x:-18,y:-7))
                                            .offset(x:10,y:15))
                                .overlay(Image(avatarFacialhair)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 70, height: 70, alignment: .center)
                                            .offset(x:0,y:45))
                                .offset(x:10,y:-75))
            case BodyPose.sitting:
                Image(avatarBody)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 310, alignment: .bottom)
                    .overlay(Image(avatarHead)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 80, height: 80, alignment: .center)
                                .overlay(Image(avatarFace)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 50, height: 50, alignment: .center)
                                            .overlay(Image(avatarAccessory)
                                                        .resizable()
                                                        .scaledToFit()
                                                        .frame(width: 45, height: 45, alignment: .center)
                                                        .offset(x:10,y:-5))
                                            .overlay(Image(avatarFacialhair)
                                                        .resizable()
                                                        .scaledToFit()
                                                        .frame(width: 45, height: 45, alignment: .center)
                                                        .offset(x:-7,y:20))
                                            .offset(x:5,y:5))
                                .offset(x:-20,y:-115))
            case BodyPose.standing:
                Image(avatarBody)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 160, height: 300, alignment: .bottom)
                    .overlay(Image(avatarHead)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 70, height: 70, alignment: .center)
                                .overlay(Image(avatarFace)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 45, height: 45, alignment: .center)
                                            .overlay(Image(avatarAccessory)
                                                        .resizable()
                                                        .scaledToFit()
                                                        .frame(width: 38, height: 38, alignment: .center)
                                                        .offset(x:10,y:-5))
                                            .overlay(Image(avatarFacialhair)
                                                        .resizable()
                                                        .scaledToFit()
                                                        .frame(width: 40, height: 40, alignment: .center)
                                                        .offset(x:-5,y:17))
                                            .offset(x:5,y:5))
                                .offset(x:-5,y:-118))
            }
        }
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
                                Button(action: {
                                    bodyPoseSelect = BodyPose.body
                                    avatarBody = name
                                }, label: {
                                    Image(name)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 50, height: 50)
                                        .border(Color.black, width: 1)
                                        .clipped()
                                })
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
                                Button(action: {
                                    bodyPoseSelect = BodyPose.standing
                                    avatarBody = name
                                }, label: {
                                    Image(name)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 50, height: 50)
                                        .border(Color.black, width: 1)
                                        .clipped()
                                })
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
                                Button(action: {
                                    bodyPoseSelect = BodyPose.sitting
                                    avatarBody = name
                                }, label: {
                                    Image(name)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 50, height: 50)
                                        .border(Color.black, width: 1)
                                        .clipped()
                                })
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
                                Button(action: {
                                    avatarHead = name
                                }, label: {
                                    Image(name)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 50, height: 50)
                                        .border(Color.black, width: 1)
                                        .clipped()
                                })
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
                                Button(action: {
                                    avatarFace = name
                                }, label: {
                                    Image(name)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 50, height: 50)
                                        .border(Color.black, width: 1)
                                        .clipped()
                                })
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
                                Button(action: {
                                    avatarFacialhair = name
                                }, label: {
                                    Image(name)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 50, height: 50)
                                        .border(Color.black, width: 1)
                                        .clipped()
                                })
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
                                Button(action: {
                                    avatarAccessory = name
                                }, label: {
                                    Image(name)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 50, height: 50)
                                        .border(Color.black, width: 1)
                                        .clipped()
                                })
                                }
                            }
                        }
                }
            //}
        }
        .onAppear{
            initalApp()
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
