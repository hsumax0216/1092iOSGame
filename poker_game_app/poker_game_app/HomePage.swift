//
//  HomePage.swift
//  poker_game_app
//
//  Created by 徐浩恩 on 2021/3/23.
//
import SwiftUI

struct HomePage: View {
    var body: some View {
        GeometryReader{
            geometry in
            NavigationView{
                ZStack{
                    Image("poker_cover")
                        .resizable()
                        .opacity(0.6)
                        .scaledToFill()
                        .frame(minWidth: 0,maxWidth: .infinity)
                        .edgesIgnoringSafeArea(.all)
                    //Spacer()
                    VStack{
                        Spacer()
                        NavigationLink(destination: GamePage())
                        {
                            Text("Play")
                                .font(.system(size: 30,weight: .bold,design:.monospaced))
                            //.fontWeight(.bold)
                            .foregroundColor(Color(red: 100/255, green: 149/255, blue: 230/255))
                            .multilineTextAlignment(.center)
                            .frame(width:geometry.size.width * 1 / 3, height: 45)
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color(red: 100/255, green: 149/255, blue: 230/255), style: StrokeStyle(lineWidth: 2)))
                        }
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing:0))
                        Spacer()
                        Link(destination: URL(string: "https://zh.wikipedia.org/wiki/鋤大弟".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")!, label:
                        {
                            Text("Rule")
                                .font(.system(size: 30,weight: .bold,design:.monospaced))
                            .foregroundColor(Color(red: 233/255, green: 150/255, blue: 122/255))
                            .multilineTextAlignment(.center)
                            .frame(width:geometry.size.width * 1 / 3, height: 45)
                            .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color(red: 233/255, green: 150/255, blue: 122/255), style: StrokeStyle(lineWidth: 2)))
                        })
                    }
                    
                    
//                    Button(action:{
//                        showGamePage=true
//                    },label:{
//                        Text("button")
//                    })
        //            .sheet(isPresented: $showGamePage, content: {
        //                GamePage()
        //            })
                }
                .navigationBarTitle("navigationBarTitle")
                .navigationBarHidden(true)
                .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
}

struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HomePage()
        }
    }
}
//for test func
// struct HomePage: View {
//    @State private var showSecondPage=false
//     var body: some View {
//         VStack{
//             Text("Hello, world!")
//                 .padding()
//             Button( action:{
//                showSecondPage=true
//                 },label:{
//                     Text("button")
//                 }
//             ).fullScreenCover(isPresented: $showSecondPage, content: {
//                secondpage(showSecondPage: $showSecondPage)
//             })
//         }
//     }
// }
//struct secondpage: View {
//    @Binding var showSecondPage:Bool
//    var body: some View {
//        ZStack {
//        Color.yellow
//        .edgesIgnoringSafeArea(.all)
//        Text("Second View")
//        }
//        .overlay(
//        Button(action: {
//        showSecondPage = false
//        }, label: {
//        Image(systemName: "xmark.circle.fill")
//        .resizable()
//        .frame(width: 50, height: 50)
//        .padding(20)
//        }), alignment: .topTrailing)
//    }
//
//}
