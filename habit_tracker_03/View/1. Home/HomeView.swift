//
//  HomeView.swift
//  habit_tracker_01
//
//  Created by Kyle Arcilla on 10/20/20.
//

import SwiftUI

struct HomeView: View {
    @FetchRequest(entity: Category.entity(), sortDescriptors: [], animation: .spring())
    var results : FetchedResults<Category>
    
    @State var count = 0
    @State var checked = 0 
    
    var body: some View {
        NavigationView {
            VStack {
        
                // 1. Dashboard
                HomeHeaderSubView()
                    .padding(.bottom, 23)
                    .padding(.horizontal, 30)
                
                // 2. Divider
                Divider()
                    .padding(.horizontal, 30)
                    .padding(.bottom, 21)
                
                // 3. Today's Haabits
                HStack {
                    Text("Today's Habits")
                        .font(.system(size: 27, design: .rounded))
                        .foregroundColor(Color.black.opacity(0.80))
                        .fontWeight(.bold)
                        .padding(.horizontal, 30)
                    
                    Spacer()
                    
                    // 4. Counter
                    Text("\(checked) / \(count)")
                        .font(.system(size: 20, design: .rounded))
                        .foregroundColor(Color.black.opacity(0.70))
                        .fontWeight(.bold)
                        .padding(.horizontal, 40)
                }
                
                // 5. Hobbies Display
                if (results.count == 0) {
                    Text("Empty!")
                    
                    Spacer()
                } else {
                    // 4. Today View
                    TodayView(checked: $checked, count: $count)
                }
                
            }
            .navigationTitle("")
            .navigationBarHidden(true)
            .padding(.top, 30)
            
        }.onAppear(perform: {
            countDisplay()
        })
    }
    
    func countDisplay() {
        count = 0
        checked = 0
        
        for category in results {
            for task in category.tasks {
                count = count + 1
                if (task.isDone == true) {
                    checked = checked + 1
                }
            }
        }
    }

}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

