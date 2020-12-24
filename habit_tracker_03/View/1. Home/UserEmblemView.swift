//
//  HomeHeaderEmblemSubView.swift
//  habit_tracker_01
//
//  Created by Kyle Arcilla on 10/20/20.
//

import SwiftUI

struct UserEmblemView: View {
    var body: some View {
        
        Text("KA")
            .font(.system(size: 23))
            .foregroundColor(.white)
            .fontWeight(.bold)
            .padding(19)
            .background(Color("emblemColor"))
            .clipShape(Circle())
        
    }
}

struct HomeHeaderEmblemSubView_Previews: PreviewProvider {
    static var previews: some View {
        UserEmblemView()
    }
}
