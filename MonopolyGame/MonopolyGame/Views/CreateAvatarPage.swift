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
    @Binding var userImage: UIImage?
    let screenWidth:CGFloat = UIScreen.main.bounds.size.width
    @State var picWidth:CGFloat = 0
    @State var bodyPoseSelect:BodyPose = BodyPose.body
    @State var bgColor = Color(.sRGB, red: 0, green: 0, blue: 0)
    @State var tabviewSelction:Int = 0
    @State var avatarBody:String = "body/Blazer Black Tee"
    @State var avatarHead:String = "head/Afro"
    @State var avatarFace:String = "face/Blank"
    @State var avatarAccessory:String = "accessories/* None"
    @State var avatarFacialhair:String = "facial-hair/* None"
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
                                                        .renderingMode(.template)
                                                        .resizable()
                                                        .scaledToFit()
                                                        .foregroundColor(bgColor)
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
                                                        .renderingMode(.template)
                                                        .resizable()
                                                        .scaledToFit()
                                                        .foregroundColor(bgColor)
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
                                                        .renderingMode(.template)
                                                        .resizable()
                                                        .scaledToFit()
                                                        .foregroundColor(bgColor)
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
                        randomAvatar()
                    }, label: {
                        Image("dice")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(.purple)
                            .frame(width:40,height:40)
                            .padding(.leading,15)
                    })
                    Spacer()
                    Button(action: {
                        lastPageStack.push(currentPage)
                        currentPage = Pages.CharactorPage
                        userImage = avatarView.snapshot()
                    }, label: {
                        Image(systemName: "arrow.right")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(.purple)
                            .frame(width:40,height:40)
                            .padding(.trailing,15)
                    })
                }
                Spacer()
            }
            VStack{
                Spacer()
                avatarView
                Button(action:{
                    let image = avatarView.snapshot()
                    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
                },label:{
                    Image(systemName: "camera")
                        .resizable()
                        .foregroundColor(.purple)
                        .scaledToFit()
                        .frame(width:50)
                })
                ColorPicker("Accessory Color select", selection: $bgColor)
                    .frame(width:screenWidth*0.75)
                TabView(selection:$tabviewSelction){
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
    }
}
