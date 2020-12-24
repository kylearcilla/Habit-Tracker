//
//  EditCategoryForm.swift
//  habit_tracker_03
//
//  Created by Kyle Arcilla on 11/14/20.
//

import SwiftUI


struct EditCategoryForm: View {
    @Environment(\.managedObjectContext) var context
    @StateObject var categoryData : CategoryViewModel 
    
    @Environment(\.presentationMode) var presentationMode
    
    // category is alredy made
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
                            
                            // Add this new task to category's tasks

                            let newTask = Task(context: context)
                            newTask.name = categoryData.taskName
                            newTask.parentCategory = categoryData.updateCategory
                            
                            categoryData.taskName = ""
                        }) {
                            Text("Add")
                                .padding(.top, 7)
                                .padding(.bottom, 2)
                        }
                        .disabled(categoryData.taskName == "" ? true : false)
                        
                    }
                }.padding(.bottom, 10)
                
                // displaying the already premade tasks
                Section(header: Text("Current List").textCase(.none)) {
                    if (categoryData.updateCategory.tasks.isEmpty) {    
                        Text("No Tasks...")
                            .font(.system(size: 15))
                            .foregroundColor(Color(.black).opacity(0.30))
                            .padding(.top, 8)
                            .padding(.bottom, 3)
                    } else {
                        List {
                            ForEach(Array(categoryData.updateCategory.tasks)) { task in
                                Text("\(task.name ?? "untitled")")
                                    .font(.system(size: 14, design: .rounded))
                                    .foregroundColor(Color(.black).opacity(0.70))
                                    .fontWeight(.regular)
                                    .padding(.leading, 10)
                                    .padding(.top, 10)
                                    .contextMenu {
                                        Button(action: {
                                            categoryData.deleteTask(taskToDelete: task)
                                        }, label: {
                                            Text("Delete")
                                        })
                                    }
                                
                            }
                        }
                    }
                    
                    
                    
                }.padding(.bottom, 10)
                
            }
            .navigationBarItems(
                // when cancel is tapped
                leading: Button(action: {onCancelTapped()} ) { Text("Cancel")},
                
                // shen save is tapped
                trailing: Button(action: {
                    categoryData.saveData(context: context)
                    onCancelTapped()
                    
                } ) { Text("Save")}
            )
            .navigationBarTitle("Edit this Category", displayMode: .inline)
            
        }
        }
    }
    
    func onCancelTapped() {
        self.presentationMode.wrappedValue.dismiss()
    }
    
}

//struct EditCategoryForm_Previews: PreviewProvider {
//    static var previews: some View {
//        EditCategoryForm()
//    }
//}
