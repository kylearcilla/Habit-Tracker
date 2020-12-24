//
//  NewCategoryForm.swift
//  habit_tracker_03
//
//  Created by Kyle Arcilla on 11/8/20.
//

import SwiftUI

public var daysOfTheWeek : [String] = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
public var defaultTasks : [String] = ["Task #1", "Task#2", "Task#3"]

struct NewCategoryForm: View {
    @Environment(\.managedObjectContext) var context
    @StateObject var categoryData : CategoryViewModel = CategoryViewModel()
    
    @Environment(\.presentationMode) var presentationMode
    
    
    var body: some View {
        NavigationView {
            VStack {
                
            Form {
                Section(header: Text("Category Properties").textCase(.none)) {
                    TextField("Category Name:", text: $categoryData.title)
                        .disableAutocorrection(true)
                    
                }.padding([.top, .bottom], 10)
                
                
                Section(header: Text("Add New Task to This Category").textCase(.none)) {
                    HStack {
                        TextField("Task Name", text: $categoryData.taskName)
                            .disableAutocorrection(true)
                            .padding(.top, 7)
                            .padding(.bottom, 2)
                        
                        // When "Add Task" is Pressed
                        Button(action: {
                            // Add this task to the the array
                            categoryData.addToTasks()
                            
                        }) {
                            Text("Add")
                                .padding(.top, 7)
                                .padding(.bottom, 2)
                        }
                        .disabled(categoryData.taskName == "" ? true : false)
                        
                    }
                }.padding(.bottom, 10)
                
                
                Section(header: Text("Current List").textCase(.none)) {
                    if (categoryData.newTasks.isEmpty) {
                        Text("Nothing Add Yet...")
                            .font(.system(size: 15))
                            .foregroundColor(Color(.black).opacity(0.30))
                            .padding(.top, 8)
                            .padding(.bottom, 3)
                    } else {
                        List {
                            ForEach(categoryData.newTasks , id: \.self) { task in
                                Text("\(task)")
                                    .font(.system(size: 14, design: .rounded))
                                    .foregroundColor(Color(.black).opacity(0.70))
                                    .fontWeight(.regular)
                                    .padding(.leading, 10)
                                    .padding(.top, 10)
                                
                            }.onDelete(perform: { indexSet in
                                categoryData.newTasks.remove(atOffsets: indexSet)
                            })
                        }
                    }
                    
                    
                    
                }.padding(.bottom, 10)
                
            }
            .navigationBarItems(
                // when cancel is tapped
                leading: Button(action: {onCancelTapped()} ) { Text("Cancel")},
                
                // shen save is tapped
                trailing: Button(action: {
                    categoryData.createData(context: context)
                    onCancelTapped()
                    
                } ) { Text("Save")}
            )
            .navigationBarTitle("Add a New Category", displayMode: .inline)
            
        }
        }
    }
    
    func onCancelTapped() {
        self.presentationMode.wrappedValue.dismiss()
    }
    
}

struct NewCategoryForm_Previews: PreviewProvider {
    static var previews: some View {
        NewCategoryForm()
    }
}
