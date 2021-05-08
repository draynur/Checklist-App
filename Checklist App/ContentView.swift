//
//  ContentView.swift
//  Checklist App
//
//  Created by Runyard, John on 5/7/21.
//

import SwiftUI

struct CheckBox: View, Identifiable {
    @State var isChecked:Bool = false
    let id = UUID()
    var title:String
    func toggle() {isChecked = !isChecked}
    var body: some View {
        Button (action:toggle) {
            HStack {
                Image(systemName: isChecked ? "checkmark.square" : "square").foregroundColor(.black)
                Text(title).foregroundColor(.black)

            }
        }
    }
}

struct LoginScreen: View {
    @State var pass: String = ""
    @State var email: String = ""
    @Binding var loggedin: Bool
    var body: some View {
        VStack {
            Text("Login").font(.title)
            Image(systemName: "lock.fill")
            TextField("Email", text: self.$email)
            TextField("Password", text: self.$pass)
            Button(action: {loggedin = true}, label: {Text("Log in")})
        }
    }
}

struct ProfileView: View {
    @Binding var loggedin: Bool
    var body: some View {
        VStack {
            Text("Profile").font(.largeTitle)
            Button(action: {loggedin = false}, label: {Text("Log out")})
        }
        
    }
}

struct CheckList: View {
    var list: Array<String> = ["Something funny", "Something sad", "Something big", "Something small", "This one is very very very very very very very long"]
    
    var title: String
    
    var body: some View {
        VStack {
            Text(title).font(.largeTitle)
            List(list, id:\.self) { item in
                CheckBox(title: item)
            }
        }
    }
}

struct CheckListData: Hashable {
    var title: String
    var list: Array<String> = ["Something funny", "Something sad", "Something big", "Something small", "This one is very very very very very very very long"]
}



struct ContentView: View {
    
    @State var checklists: Array<CheckListData> = [CheckListData(title: "First list"), CheckListData(title: "Second list")]
    @State private var loggedin = false
    
    var body: some View {
        if loggedin {
            TabView {
                NavigationView {
                    VStack {
                        Text("Your checklists").font(.largeTitle)
                        
                        List(checklists, id:\.self) { c in
                            NavigationLink(destination: CheckList(list: c.list, title: c.title)) {
                                Text(c.title)
                            }
                        }
                    }
                }.tabItem {
                    Image(systemName: "archivebox.fill")
                    Text("All")
                }
                
                ProfileView(loggedin: $loggedin)
                .tabItem {
                    Image(systemName: "person.circle.fill")
                    Text("Profile")
                }.padding()
                
            }
        } else {
            
            LoginScreen(loggedin: self.$loggedin).padding()
            
        }


        
        
    }
        
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
