//
//  PlayPage.swift
//  gesture-alphabetGame
//
//  Created by 徐浩恩 on 2021/4/9.
//

import SwiftUI

struct GamePage:View {
    @Binding var currentPage:Pages
    let color: [Color] = [.gray,.red,.orange,.yellow,.green,.purple,.pink]
    @State private var arr = [Int]()
    @State private var fgColor: Color = .gray
    @State private var offset = [CGSize]()
    @State private var newPosition = [CGSize]()
//    var dragGesture: some Gesture {
//            DragGesture(coordinateSpace: .global)
//                .onChanged({ value in
//                   print(value.location)
//                   offset.width = newPosition.width + value.translation.width
//                   offset.height = newPosition.height + value.translation.height
//              })
//                .onEnded({ value in
//                    newPosition = offset
//                })
//        }
    func initialGame(){
        for _ in 1...10{
            arr.append(1)
            offset.append(CGSize.init())
            newPosition.append(CGSize.init())
        }
    }
    var body: some View{
        //let screenWidth:CGFloat = UIScreen.main.bounds.size.width
        ZStack{
            VStack{
                Button(action: {currentPage = Pages.HomePage}, label: {
                    Text("Button")
                })
                Spacer()
                HStack(alignment: .center,spacing:15){
                    Group{
                        ForEach(arr.indices,id:\.self){
                            (index) in
                            Text("")//alphabet background
                                .font(.system(size:35,design: .monospaced))
                                .foregroundColor(.blue)
                                .frame(width: 60, height: 60)
                                .background(Color.black)
                                .cornerRadius(100)
                                .overlay(RoundedRectangle(cornerRadius: 100)
                                            .stroke(Color.red,lineWidth: 5))
                        }
                    }
                }
                .padding(.bottom)
            }
            VStack{
                HStack(alignment: .center,spacing:15){
                    Group{
                        ForEach(arr.indices,id:\.self){
                            (index) in
                            Text("ä")
                                .font(.system(size:35,design: .monospaced))
                                .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                                .frame(width: 50, height: 50)
                                .background(fgColor)
                                .cornerRadius(100)
                                .overlay(RoundedRectangle(cornerRadius: 100)
                                            .stroke(Color.blue,lineWidth: 5))
                                .offset(/*x:100,y:100*/offset[index])
                                .onTapGesture {
                                    fgColor = color.randomElement()!
                                }
                                .gesture(DragGesture()
                                    .onChanged({value in
                                       offset[index].width = newPosition[index].width + value.translation.width
                                       offset[index].height = newPosition[index].height + value.translation.height
                                    })
                                    .onEnded({ value in
                                        newPosition[index] = offset[index]
                                    })
                                )
                        }
                    }
                }
                .padding(.top,25)
                Spacer()
            }
        //            Text("ä")
        //                .font(.system(size:35,design: .monospaced))
        //                .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
        //                .frame(width: 50, height: 50)
        //                .background(fgColor)
        //                .cornerRadius(100)
        //                .overlay(RoundedRectangle(cornerRadius: 100)
        //                            .stroke(Color.blue,lineWidth: 5))
        //                .offset(/*x:100,y:100*/offset)
        //                .onTapGesture {
        //                    fgColor = color.randomElement()!
        //                }
        //                .gesture(dragGesture)

                //.offset(x:10.0,y:10.0)
            //Spacer()
        }
        .onAppear{
            initialGame()
        }
//        .onAppear(perform:{initialGame()})
    }
}

struct GamePage_Previews: PreviewProvider {
    static var previews: some View {
        Landscape{
            GamePage(currentPage: .constant(Pages.GamePage))
        }
    }
}


