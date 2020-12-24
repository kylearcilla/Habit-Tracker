//
//  NavigationBar.swift
//  habit_tracker_03
//
//  Created by Kyle Arcilla on 11/11/20.
//

import SwiftUI

import SwiftUI

struct NavigationBar: View {
    var tabs = ["Home", "MyHobbies"]
    var edges = UIApplication.shared.windows.first?.safeAreaInsets
    
    init() {
        let tabColor = UIColor(red: 0.95, green: 0.95, blue: 0.98, alpha: 1.00)
        UITabBar.appearance().barTintColor = tabColor
    }
    
    @State var selectedTab = "Home"
    @Namespace var animation
    
    var body: some View {
        ZStack {
            TabView(selection: $selectedTab) {
                HomeView()
                    .tag("Home")
                
                MyHabbits()
                    .tag("MyHobbies")
                
            }
            .ignoresSafeArea(.all, edges: .bottom)
            .background(Color("tabBarBg"))
            
            
            VStack(spacing: 0) {
                
                Spacer()
                
                HStack(spacing: 70) {
                    ForEach(tabs, id: \.self) { tab in
                        TabButton(title: tab, selectedTab: $selectedTab, animation: animation)
                    }
                }
                .padding(.horizontal, 30)
        
                
                Color(.clear)
                    .ignoresSafeArea(.all, edges: .bottom)
                    .frame(height: 20)
                
            }
            .ignoresSafeArea(.all, edges: .bottom)
        }
        
        
    }
}

struct TabButton: View {
    var title : String
    @Binding var selectedTab : String
    var animation : Namespace.ID
    
    var body: some View {
        
        Button(action: {
            withAnimation { selectedTab = title }
        }) {
            
            VStack(spacing: 6) {
                ZStack{
                    CustomShape()
                        .fill(Color.clear)
                        .frame(width: 45, height: 6)
                    
                    if selectedTab == title {
                        CustomShape()
                            .fill(Color(.blue).opacity(0.30))
                            .frame(width: 45, height: 6)
                            .matchedGeometryEffect(id: "tabChange", in: animation)
                    }
                }
                .padding(.bottom, 10)
                
                Image(systemName: getImage(name: title))
                    .renderingMode(.template)
                    .resizable()
                    .foregroundColor(selectedTab == title ? Color("tabBarIconColor") : Color.black.opacity(0.2))
                    .frame(width: 20, height: 20)
                    .padding(.bottom, 3)
                
                Text(title)
                    .font(.system(size: 10))
                    .fontWeight(.regular)
                    .foregroundColor(Color.black.opacity(selectedTab == title ? 0.6 : 0.2))
            }
        }
    }
    
    func getImage(name: String) -> String {
        switch name {
        case "Home" :
            return "house.fill"
            
        case "MyStats" :
            return "chart.bar.xaxis"
            
        case "MyHobbies" :
            return "rectangle.fill.on.rectangle.angled.fill"
            
        default :
            return "gearshape.fill"
        }
    }
    
}

struct CustomShape: Shape {
    func path(in rect: CGRect) -> Path {
        
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [.bottomLeft, .bottomRight], cornerRadii: CGSize(width: 10, height: 10))
        
        return Path(path.cgPath)
    }
}


struct NavigationBar_Previews: PreviewProvider {
    static var previews: some View {
        NavigationBar()
    }
}
