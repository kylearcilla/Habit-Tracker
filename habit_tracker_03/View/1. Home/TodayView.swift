//
//  TodayView.swift
//  habit_tracker_03
//
//  Created by Kyle Arcilla on 12/23/20.
//

import SwiftUI
import CoreData
import Grid

// Displays a Column of Habits
struct TodayView: View {
    @Environment(\.managedObjectContext) var context
    
    @FetchRequest(entity: Category.entity(), sortDescriptors: [], animation: .spring())
    var results : FetchedResults<Category>
    
    @Binding var checked : Int
    @Binding var count : Int
    
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .trailing, vertical: .bottom)) {
            VStack {
                if (results.count == 0) {
                    Text("Empty!")
                    Spacer()
                } else {
                    ScrollView {
                        Grid(results) { category in
                            TodayCard(category: category, checked: $checked, count: $count)
                        }
                    }
                    .gridStyle(StaggeredGridStyle(.vertical, tracks: 1, spacing: 20))
                    .padding()
                }
            }
        }
    }
}


