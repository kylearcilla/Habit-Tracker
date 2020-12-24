//
//  CategoryViewModel.swift
//  habit_tracker_03
//
//  Created by Kyle Arcilla on 11/7/20.
//

import SwiftUI
import CoreData

class CategoryViewModel: ObservableObject {
    @Published var updateCategory : Category!
    @Published var isNewData = false
    @Published var isEditData = false
    
    // category
    @Published var title = ""
    @Published var date = "Monday"
    
    // task
    @Published var taskName = ""
    @Published var newTasks = [String]()
    
    func addToTasks() {
        newTasks.append(taskName)
        taskName = ""
    }
    
    func createData(context: NSManagedObjectContext) {
        // 1. make the category
        let newCategory = Category(context: context)
        newCategory.date = date
        
        newCategory.title = title.isEmpty ? "Untitled" : title
        
        // 2. initalize newCategory's tasks from newTasks array
        if !(newTasks.isEmpty) {
            for name in newTasks {
                let newTask = Task(context: context)
                newTask.name = name
                newTask.parentCategory = newCategory
            }
        }
        
        
        do {
            try context.save()
            
            // 3. reset data
            
            title = ""
            date = ""
            newTasks.removeAll()
            isNewData = false

        } catch {
            print(error.localizedDescription)
        }
    }
    
    // unloading category and its data
    func editCategory(category: Category) {
        updateCategory = category
        
        date = category.date ?? "Monday"
        title = category.title ?? "Untitled"
        isEditData = true
        print("hi")
    }
    
    func deleteTask(taskToDelete: Task) {
        updateCategory.removeFromTasks(taskToDelete)
    }
    
    func saveData(context: NSManagedObjectContext) {
        updateCategory.title = title
        updateCategory.date = date
        
        do {
            if (context.hasChanges) {
                try context.save()
            }
            
            title = ""
            date = ""
            taskName = ""
            isEditData = false
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
}

