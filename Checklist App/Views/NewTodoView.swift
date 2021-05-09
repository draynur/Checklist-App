//
//  NewTodoView.swift
//  Checklist App
//
//  Created by user931069 on 5/8/21.
//

import Foundation
import SwiftUI

struct NewTODOView: View {
    
    @State private var newTODO = ""
    
    @ObservedObject var session = ContentViewModel()
    
    @Environment(\.presentationMode) var presentationMode
    
    
    var body: some View {
        Group {
            VStack {
                HStack {
                    TextField("Enter TODO", text: $newTODO)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(20.0)
                }
                Button(action: {
                    self.addTODO()
                }) {
                    Text("Add")
                        .frame(width: 200, height: 50)
                        .foregroundColor(Color.white)
                        .background(
                            LinearGradient(gradient: Gradient(colors: [Color(.systemBlue), .purple]), startPoint: .top, endPoint: .bottom)
                                .edgesIgnoringSafeArea(.all)
                        )
                        .cornerRadius(20.0)
                        .padding()
                }
            }
        }
        .padding()
    }
    
    func addTODO() {
        if !newTODO.isEmpty {
            //Add TODO to Firebase
            session.uploadTODO(todo: newTODO)
            dismiss()
        }
    }
    
    func dismiss() {
        presentationMode.wrappedValue.dismiss()
    }
}

