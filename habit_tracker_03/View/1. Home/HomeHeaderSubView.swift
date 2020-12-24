//
//  HomeHeaderSubView.swift
//  habit_tracker_01
//
//  Created by Kyle Arcilla on 10/20/20.
//

import SwiftUI

// 1. Needs Custon name

struct HomeHeaderSubView: View {
    @State var currentDate = Date()
    
    var body: some View {

        ZStack() {
            VStack() {
                
                // 1. Date
                HStack() {
                    Text(stringDate(date: currentDate))
                        .font(.system(size: 14))
                        .fontWeight(.bold)
                        .foregroundColor(Color.black.opacity(0.90))
                    
                    Spacer()
                }
                
                // 2. Dashboard Title
                HStack() {
                    Text("Dashboard")
                        .font(.system(size: 32))
                        .fontWeight(.bold)
                    Spacer()
                }
                .padding(.top, 0.4)
                
                // 3. User Text
                HStack() {
                    Text("Hello! Here is today's agenda")
                        .font(.system(size: 13))
                        .fontWeight(.semibold)
                        .foregroundColor(Color.black.opacity(0.70))
                    
                    Spacer()
                }
                .padding(.top, 4)
                
            }
            
            HStack() {
                Spacer()
                
                UserEmblemView()
            }
        }

    }
}

func stringDate(date: Date) -> String {
    let format = DateFormatter()
    format.timeStyle = .none
    format.dateStyle = .long
    return format.string(from: date)
}




struct HomeHeaderSubView_Previews: PreviewProvider {
    static var previews: some View {
        HomeHeaderSubView()
    }
}
