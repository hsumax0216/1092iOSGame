//
//  CreateAvatarPage.swift
//  FinalProject
//
//  Created by User02 on 2021/4/28.
//
import UIKit
import SwiftUI

enum BodyPose{
    case body,standing,sitting
}

struct CreateAvatarPage: View {
    @Binding var currentPage: Pages
    @Binding var userImage:UIImage?
    let screenWidth:CGFloat = UIScreen.main.bounds.size.width
    @State var picWidth:CGFloat = 0
    @State private var bodyPoseSelect:BodyPose = BodyPose.body//0:body 1:pose-sitting 2:pose-standing
    @State private var avatarBody:String = "body/Blazer Black Tee"
    @State private var avatarHead:String = "head/Afro"
    @State private var avatarFace:String = "face/Blank"
    @State private var avatarAccessory:String = "accessories/* None"
    @State private var avatarFacialhair:String = "facial-hair/* None"
    func initalApp(){
       bodyPoseSelect = BodyPose.body
        avatarBody = "body/Blazer Black Tee"
        avatarHead = "head/Afro"
        avatarFace = "face/Blank"
        avatarAccessory = "accessories/* None"
        avatarFacialhair = "facial-hair/Full 2"
        
        bodyPoseSelect = BodyPose.standing
        avatarBody = "pose/standing/blazer-1"
        avatarHead = "head/Afro"
        avatarFace = "face/Awe"
        avatarAccessory = "accessories/Eyepatch"
        avatarFacialhair = "facial-hair/* None"

        bodyPoseSelect = BodyPose.sitting
        avatarBody = "pose/sitting/bike"
        avatarHead = "head/Afro"
        avatarFace = "face/Awe"
        avatarAccessory = "accessories/Eyepatch"
        avatarFacialhair = "facial-hair/* None"
        
        picWidth = (screenWidth-10*4)/3
    }
    var avatarView: some View{
        ZStack{
            switch bodyPoseSelect {
            case BodyPose.body:
                Image(avatarBody)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 310, alignment: .bottom)
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
                                            .frame(width: 80, height: 80, alignment: .center)
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
                                                        .frame(width: 60, height: 60, alignment: .center)
                                                        .offset(x:-9,y:-5))
                                            .overlay(Image(avatarFacialhair)
                                                        .resizable()
                                                        .scaledToFit()
                                                        .frame(width: 45, height: 45, alignment: .center)
                                                        .offset(x:-6,y:20))
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
                                                        .frame(width: 50, height: 50, alignment: .center)
                                                        .offset(x:-8.5,y:-5))
                                            .overlay(Image(avatarFacialhair)
                                                        .resizable()
                                                        .scaledToFit()
                                                        .frame(width: 40, height: 40, alignment: .center)
                                                        .offset(x:-7,y:17))
                                            .offset(x:5,y:5))
                                .offset(x:-5,y:-118))
            }
        }
        .frame(width: 200, height: 310, alignment: .center)
    }
    var body: some View {
        ZStack{
            VStack{
                HStack{
                    Button(action: {
                        currentPage = Pages.HomePage
                    }, label: {
                        Image(systemName: "arrow.left")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(.purple)
                            .frame(width:40,height:40)
                            .padding(.leading,15)
                    })
                    Spacer()
                    Button(action: {
                        currentPage = Pages.CharactorPage
                        userImage = avatarView.snapshot()
                    }, label: {
                        Image(systemName: "arrow.right")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(.purple)
                            .frame(width:45,height:45)
                            .padding(.trailing,15)
                    })
                }
                //.frame(height:40)
                Spacer()
            }
            VStack{//200
                    //.padding(0)
                Spacer()
                avatarView
                Button(action:{
                    let image = avatarView.snapshot()
                    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
//                    uploadPhoto(image: image) { result in
//                        switch result {
//                        case .success(let url):
//                           print(url)
//                        case .failure(let error):
//                           print(error)
//                        }
//                    }
                },label:{
                    Text("snapshot")
                })
                
                TabView{
                    avatarBodyView(screenWidth: .constant(screenWidth), picWidth: .constant(picWidth), itemsSet: .constant(body_filename), avatarItems: $avatarBody, selectConst: .constant(BodyPose.body), bodyPoseSelect: $bodyPoseSelect)
                    avatarBodyView(screenWidth: .constant(screenWidth), picWidth: .constant(picWidth), itemsSet: .constant(pose_sitting_filename), avatarItems: $avatarBody, selectConst: .constant(BodyPose.sitting), bodyPoseSelect: $bodyPoseSelect)
                    avatarBodyView(screenWidth: .constant(screenWidth), picWidth: .constant(picWidth), itemsSet: .constant(pose_standing_filename), avatarItems: $avatarBody, selectConst: .constant(BodyPose.standing), bodyPoseSelect: $bodyPoseSelect)
                    avatarItemView(screenWidth: .constant(screenWidth), picWidth: .constant(picWidth), itemsSet: .constant(head_filename), avatarItems: $avatarHead)
                    avatarItemView(screenWidth: .constant(screenWidth), picWidth: .constant(picWidth), itemsSet: .constant(face_filename), avatarItems: $avatarFace)
                    avatarItemView(screenWidth: .constant(screenWidth), picWidth: .constant(picWidth), itemsSet: .constant(facial_hair_filename), avatarItems: $avatarFacialhair)
                    avatarItemView(screenWidth: .constant(screenWidth), picWidth: .constant(picWidth), itemsSet: .constant(accessories_filename), avatarItems: $avatarAccessory)
                    
                }
                .tabViewStyle(PageTabViewStyle())
                .padding(5)
                .border(Color.black, width: 1)
                
            }
        }
        
        .onAppear{
            initalApp()
        }
    }
}

struct CreateAvatarPage_Previews: PreviewProvider {
    static var previews: some View {
        CreateAvatarPage(currentPage: .constant(Pages.CreateAvatarPage),userImage: .constant(nil))
    }
}

struct avatarBodyView: View {
    @Binding var screenWidth: CGFloat
    @Binding var picWidth: CGFloat
    @Binding var itemsSet:[String]
    @Binding var avatarItems: String
    @Binding var selectConst: BodyPose
    @Binding var bodyPoseSelect: BodyPose
    var body: some View {
        VStack{
            ScrollView(.vertical){
                let columns = [GridItem(spacing:10),GridItem(),GridItem(spacing:10)]
                LazyVGrid(columns:columns,spacing:10){
                    ForEach(itemsSet, id: \.self) { name in
                        Button(action: {
                            bodyPoseSelect = selectConst
                            avatarItems = name
                        }, label: {
                            Image(name)
                                .resizable()
                                .scaledToFill()
                                .frame(width:picWidth,height: picWidth, alignment: .top)
                                .border(Color.black, width: 3)
                                .clipped()
                        })
                    }
                }
            }
        }
        //.frame(height:350)
        //.clipped()
    }
}

struct avatarItemView: View {
    @Binding var screenWidth: CGFloat
    @Binding var picWidth: CGFloat
    @Binding var itemsSet:[String]
    @Binding var avatarItems: String
    var body: some View {
        ScrollView(.vertical){
            let columns = [GridItem(spacing:10),GridItem(),GridItem(spacing:10)]
            LazyVGrid(columns:columns){
                ForEach(itemsSet, id: \.self) { name in
                    Button(action: {
                        avatarItems = name
                    }, label: {
                        Image(name)
                            .resizable()
                            .scaledToFill()
                            .frame(width:picWidth,height: picWidth, alignment: .top)
                            .border(Color.black, width: 3)
                            .clipped()
                    })
                }
            }
        }
        //.frame(width:screenWidth)
        //.clipped()
    }
}
