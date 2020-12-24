//
//  MyHabbits.swift
//  habit_tracker_03
//
//  Created by Kyle Arcilla on 11/7/20.
//

import SwiftUI
import CoreData
import Grid

struct MyHabbits: View {
    @StateObject var categoryData : CategoryViewModel = CategoryViewModel()
    @Environment(\.managedObjectContext) var context
    @State var style = StaggeredGridStyle(.vertical, tracks: 2, spacing: 10)
    
    @FetchRequest(entity: Category.entity(), sortDescriptors: [], animation: .spring())
    var results : FetchedResults<Category>
    
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .trailing, vertical: .bottom)) {
            VStack {
                MyHabitsHeader()
                    .padding(.bottom, 23)
                    .padding(.horizontal, 30)
                
                Divider()
                    .padding(.horizontal, 30)
                    .padding(.bottom, 10)
                
                if (results.count == 0) {
                    Text("Empty!")
                    
                    Spacer()
                } else {
                    ScrollView {
                        Grid(results) { category in
                            CategoryBoxView(category: category)
                                .contextMenu {
                                    Button(action: {context.delete(category)
                                        try! context.save()
                                    }, label: {
                                        Text("Delete")
                                    })
                                }
                            
                        }
                        .padding(.horizontal)
                        .animation(.easeInOut)
                        
                    }
                    .gridStyle(
                        StaggeredGridStyle(.vertical, tracks: 2, spacing: 15)
                    )
                    .padding()
                    
                }
                
            }
            
            HStack {
                Spacer()
                
                Button(action: {
                    categoryData.isNewData = true
                    print("hi")
                }, label: {
                    Image(systemName: "rectangle.fill.badge.plus")
                        .font(.largeTitle)
                        .padding(20)
                        .foregroundColor(Color("categoryCardText").opacity(0.80))
                })
                .padding(.bottom, 50)
                .padding(.horizontal, 20)
                .frame(alignment: .leading)
                .background(Color.white.opacity(0.0))
                .sheet(isPresented: $categoryData.isNewData, content: {
                    NewCategoryForm()
                })
            }
            .background(Color.white.opacity(0.0))

        }
        .navigationTitle("")
        .navigationBarHidden(true)
        .padding(.top, 40)
    }
}


struct MyHabbits_Previews: PreviewProvider {
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
        
        return MyHabbits()
    }
}


//                ScrollView(.vertical, showsIndicators: false) {
//                    LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 0), count: 2), spacing: 15) {
//
//                        if (results.count == 0) {
//                            Text("Nothing")
//                        } else {
//
//                            ForEach(results) { category in
//                                CategoryBoxView(category: category)
//                                    .contextMenu {
//
//                                        Button(action: {context.delete(category)
//                                            try! context.save()
//                                        }, label: {
//                                            Text("Delete")
//                                        })
//
//                                    }
//                            }
//                        }
//                    }
//                }
//                .padding(.horizontal, 20)


//func exampleCategories() -> [Category] {
//    let newCategory1 = Category(context: context)
//    newCategory1.title = "Health"
//
//    let newCategory2 = Category(context: context)
//    newCategory2.title = "LifeStyle"
//
//    let newCategory3 = Category(context: context)
//    newCategory3.title = "Art"
//
//    return [newCategory1, newCategory2, newCategory3]
//}
