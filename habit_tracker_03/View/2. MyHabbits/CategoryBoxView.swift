//
//  CategoryBoxView.swift
//  habit_tracker_03
//
//  Created by Kyle Arcilla on 11/7/20.
//

import SwiftUI
import CoreData

public let screenWidth = UIScreen.main.bounds.size.width

struct CategoryBoxView: View {
    @StateObject var categoryData : CategoryViewModel = CategoryViewModel()
    @Environment(\.managedObjectContext)
    var context: NSManagedObjectContext
    
    var category : Category
    @State var flag = false;
    
    var body: some View {
        ZStack {
            
            // Title + Tasks Loop
            VStack {
                HStack() {
                    VStack(alignment: .leading) {
                        
                        Text(category.title!)
                            .font(.system(size: 16, design: .rounded))
                            .fontWeight(.semibold)
                            .foregroundColor(Color("categoryCardText"))
                            .padding(.bottom, 1)
                            .padding(.top, 14)
                            .padding(.trailing, 20)
                            
                        
                        ForEach(Array(category.tasks)) { task in
                            Text("\(task.name ?? "kknk")")
                                .font(.system(size: 11.2, design: .rounded))
                                .foregroundColor(Color("categoryCardText"))
                                .fontWeight(.regular)
                                .padding(.leading, 3)
                                .padding(.bottom, 0.60)
                                .padding(.trailing, 15)
                        }
                    }
                    .padding(.bottom, 0)
                    Spacer(minLength: 0)
                }
                .padding(.leading, 20)
                
                // 2. Button
                HStack {
                    Spacer()
                    
                    // pencil button
                    Button(action: {
                        categoryData.editCategory(category: category)
                        categoryData.isEditData = true
                        print("hi")
                 
                    }, label: {
                        Text(". . .")
                            .font(.system(size: 11.2, design: .rounded))
                            .foregroundColor(Color("categoryCardText"))
                            .fontWeight(.black)
                            .padding(0)
                    })
                    .padding(.horizontal, 23)
                    .padding(.bottom, 18)
                    .sheet(isPresented: $categoryData.isEditData, content: {
                        EditCategoryForm(categoryData: categoryData)
                    })
                }
                
            }
        }
        .background(Color("categoryBoxView01"))
        .cornerRadius(10)
        .frame(width: (screenWidth / 2) - 37)
        .padding(.horizontal, 0)
    }
    
}

struct CategoryBoxView_Previews: PreviewProvider {
    static var previews: some View {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let category = Category(context: context)
        category.title = "Health"
        
        let taskA = Task(context: context)
        taskA.name = "Exercise in the Morning"
        taskA.parentCategory = category
        
        let taskB = Task(context: context)
        taskB.name = "Exercise in the Morning"
        taskB.parentCategory = category
        
        return CategoryBoxView(category: category)
    }
}
