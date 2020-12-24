//
//  TodayCard.swift
//  habit_tracker_03
//
//  Created by Kyle Arcilla on 12/23/20.
//

import SwiftUI
import CoreData

// this is for a single category
struct TodayCard: View {
    @Environment(\.managedObjectContext)
    var context: NSManagedObjectContext
    var category : Category
    
    @Binding var checked : Int
    @Binding var count : Int
    
    var body: some View {
        ZStack {
            
            // Title + Tasks for Each Card
            VStack {
                HStack() {
                    VStack(alignment: .leading) {
                        
                        Text(category.title!)
                            .font(.system(size: 17, design: .rounded))
                            .fontWeight(.semibold)
                            .foregroundColor(Color("categoryCardText"))
                            .padding(.bottom, 1.5)
                            .padding(.top, 14)
                            .padding(.trailing, 20)
                                   
                        ForEach(Array(category.tasks)) { task in
                            HStack() {
                                CheckBox(task: task, checked: $checked, count: $count)
                                ListView(task: task)
                            }
                        }
                    }
                    .padding(.bottom, 20)
                    Spacer(minLength: 0)
                }
                .padding(.leading, 20)
                .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
                    // store the date whenever you go into background
                    print("---> storing: \(Date())")
                    UserDefaults.standard.set(Date(), forKey: "lastDay")
            }
                
            }
            
        }
        .background(Color("categoryBoxView01"))
        .cornerRadius(10)
        .frame(width: (screenWidth - 70))
        .padding(.horizontal, 0)
    }
    
}

//struct TodayCard_Previews: PreviewProvider {
//    static var previews: some View {
//
//    }
//}
