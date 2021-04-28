//
//  createAvatarPage.swift
//  FinalProject
//
//  Created by User02 on 2021/4/28.
//

import SwiftUI
struct createAvatarPage: View {
    var body: some View {
        VStack{
            HStack{
                Text("face:")
                ScrollView(.horizontal){
                    HStack{
//                        ForEach(names, id: \.self) { name in
//                            Image(name)
//                                .resizable()
//                                .scaledToFill()
//                                .frame(width: 50, height: 50)
//                                .clipped()
//                            }
                        }
                    }
            }
            
        }
    }
}

struct createAvatarPage_Previews: PreviewProvider {
    static var previews: some View {
        createAvatarPage()
    }
}
