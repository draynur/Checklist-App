//
//  ContentView.swift
//  Checklist App
//
//  Created by Runyard, John on 5/7/21.
//

import SwiftUI
import Firebase

struct CheckBox: View, Identifiable {
    @EnvironmentObject var viewModel: ContentViewModel
    @State var isChecked:Bool
    let id = UUID()
    var todo: TODOS
    
    func toggle() {
        isChecked = !isChecked
        self.viewModel.updateTODO(key: todo.key, todo: todo.todo, isComplete: isChecked ? "true" : "false" )
    }
    var body: some View {
        Button (action:toggle) {
            HStack {
                Image(systemName: isChecked ? "checkmark.square" : "square").foregroundColor(.black)
                Text(todo.todo).foregroundColor(.black)

            }
        }
    }
}

struct ProfileView: View {
    @EnvironmentObject var viewModel: ContentViewModel
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Spacer()
            Text("Profile").font(.largeTitle)
            HStack(spacing: 10) {
                Text("Email: ").font(Font.callout.weight(.bold))
                Text(viewModel.session?.email ?? "").font(Font.callout.weight(.light))
            }
            Button(action: {viewModel.signOut()}, label: {
                    Text("Log out")
                        .frame(width: 200, height: 50)
                        .foregroundColor(Color.white)
                        .background(
                            LinearGradient(gradient: Gradient(colors: [Color(.systemBlue), .purple]), startPoint: .top, endPoint: .bottom)
                                .edgesIgnoringSafeArea(.all)
                        )
                        .cornerRadius(20.0)
                        .padding()
            })
            Spacer()
        }
        
    }
}

struct ContentView: View {
    
    @State private var loggedin = false
    @EnvironmentObject var viewModel: ContentViewModel
    
    func delete(at offsets: IndexSet) {
        print(offsets.first!)
        viewModel.removeTODO(index: offsets.first!)
    }
    
    var body: some View {
        Group {
            if viewModel.isSignedIn {
                TabView {
                    NavigationView {
                        VStack {
                            Text("Your checklist").font(.largeTitle)
                            NavigationLink(destination: NewTODOView()) {
                                Text("Add another item")
                            }
                            List { ForEach(viewModel.checklists, id:\.self) { item in
                                CheckBox(isChecked: item.isComplete == "true", todo: item)
                            }.onDelete(perform: delete)}
                            Spacer()
                        }
                        
                    }.tabItem {
                        Image(systemName: "archivebox.fill")
                        Text("All")
                    }
                    
                    ProfileView()
                    .tabItem {
                        Image(systemName: "person.circle.fill")
                        Text("Profile")
                    }.padding()
                    
                }
            } else {
                
                LoginScreen(loggedin: self.$loggedin).padding()
                
            }
        }
        .transition(.move(edge: .bottom))
        .onAppear{
            viewModel.signedIn = viewModel.isSignedIn
            viewModel.listen()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
