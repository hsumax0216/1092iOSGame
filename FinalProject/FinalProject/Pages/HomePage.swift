//
//  HomePage.swift
//  FinalProject
//
//  Created by  on 2021/5/2.
//

import SwiftUI

struct HomePage: View {
    @Binding var currentPage: Pages
    var body: some View{
        ZStack{
            
        }
    }
}

struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        HomePage(currentPage: .constant(Pages.HomePage))
    }
}
