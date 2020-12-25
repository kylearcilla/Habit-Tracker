//
//  CheckBox.swift
//  habit_tracker_03
//
//  Created by Kyle Arcilla on 12/23/20.
//

import SwiftUI

struct CheckBox: View {
    @Environment(\.managedObjectContext) var context
    @ObservedObject var task: Task
    @FetchRequest(entity: Category.entity(), sortDescriptors: [], animation: .spring())
    var results : FetchedResults<Category>
    
    @Binding var checked : Int
    @Binding var count : Int
    
    var body: some View {
            Button(action:{
                withAnimation(.spring()) {
                    task.isDone.toggle()
                    countDisplay()
                    print(task.isDone)
                    do {
                        if (context.hasChanges) {
                            try context.save()
                        }
                    
                    } catch {
                        print(error.localizedDescription)
                    }
                }
                
            }) {
                ZStack {
                    if (task.isDone == true) {
                        Circle()
                         .fill(Color.blue)
                            .frame(width: 14.5, height: 14.5)
                        Circle()
                         .fill(Color("categoryBoxView01"))
                            .frame(width: 13, height: 13)
                        Circle()
                         .fill(Color.blue)
                            .frame(width: 7.5, height: 7.5)
                    } else {
                        Circle()
                         .fill(Color.black.opacity(0.3))
                            .frame(width: 14.5, height: 14.5)
                        Circle()
                         .fill(Color("categoryBoxView01"))
                            .frame(width: 12.5, height: 12.5)
                    }
                }
            }
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

//struct CheckBox_Previews: PreviewProvider {
//    static var previews: some View {
//        CheckBox()
//    }
//}
