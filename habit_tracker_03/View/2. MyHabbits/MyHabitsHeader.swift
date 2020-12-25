//
//  MyHabitsHeader.swift
//  habit_tracker_03
//
//  Created by Kyle Arcilla on 11/7/20.
//

import SwiftUI

struct MyHabitsHeader: View {
    var body: some View {
        ZStack() {
            VStack() {
                
                // 1. Dashboard Title
                HStack() {
                    Text("My Habits")
                        .font(.system(size: 32, design: .rounded))
                        .foregroundColor(Color.black.opacity(0.80))
                        .fontWeight(.bold)
                    
                    Spacer()
                }
                .padding(.top, 0.4)
            
                // 2. User Text
                HStack() {
                    Text("View, Edit, Add, and/or Delete Tasks")
                        .font(.system(size: 13))
                        .fontWeight(.semibold)
                        .foregroundColor(Color.black.opacity(0.70))
                    
                    Spacer()
                }
                .padding(.top, 4)
                
            }
            
        }
    }
}

struct MyHabitsSubView_Previews: PreviewProvider {
    static var previews: some View {
        MyHabitsHeader()
    }
}
