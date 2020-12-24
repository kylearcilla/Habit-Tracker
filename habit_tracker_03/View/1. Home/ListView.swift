//
//  ListView.swift
//  habit_tracker_03
//
//  Created by Kyle Arcilla on 12/23/20.
//

import SwiftUI

struct ListView: View {
    @ObservedObject var task: Task
    
    var body: some View {
        Text("\(task.name ?? "kknk")")
            .font(.system(size: 13, design: .rounded))
            .foregroundColor(Color("categoryCardText").opacity(task.isDone ? 0.3 : 1.0))
            .fontWeight(.regular)
            .padding(.leading, 3)
            .padding(.bottom, 0.60)
            .padding(.trailing, 15)
    }
}

