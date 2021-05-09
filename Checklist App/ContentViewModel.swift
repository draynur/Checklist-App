//
//  ContentViewModel.swift
//  Checklist App
//
//  Created by user931069 on 5/8/21.
//

import Foundation
import Firebase

class ContentViewModel: ObservableObject {
    let auth = Auth.auth()
    var ref: DatabaseReference = Database.database().reference(withPath: "\(String(describing: Auth.auth().currentUser?.uid ?? "Error"))")
    @Published var signedIn = false
    @Published var errorMessage: String = ""
    @Published var error: Bool = false
    @Published var session: User?
    @Published var checklists: Array<TODOS> = []
    
    var isSignedIn: Bool {
        return auth.currentUser != nil
    }
    
    func listen() {
        _ = Auth.auth().addStateDidChangeListener { (auth, user) in
            print("State did change, lol")
            if let user = user {
                self.session = User(uid: user.uid, displayName: user.displayName, email: user.email)
                self.ref = Database.database().reference(withPath: user.uid	)
                self.signedIn = true
                self.getChecklist()
            } else {
                self.signedIn = false
                self.session = nil
            }
        }
    }
    
    func signIn(email: String, password: String) {
        auth.signIn(withEmail: email, password: password) { [weak self] result, error in
            print(error, result)
            
            if error != nil {
                self?.errorMessage = error?.localizedDescription ?? ""
                self?.error = true
            }
            
            guard result != nil, error == nil else {
                return
            }
            
            self?.errorMessage = ""
            self?.error = false
            DispatchQueue.main.async {
                self?.signedIn = true
            }
            
            //            Signed-in
        }
    }
    
    func getChecklist() {
        ref.observe(DataEventType.value) { (snapshot) in
            self.checklists = []
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot,
                    let toDo = TODOS(snapshot: snapshot) {
                    self.checklists.append(toDo)
                }
            }
        }
        
    }
    
    func removeTODO(index: Int) {
        let key = self.checklists[index].key
        ref.child(key).removeValue()
    }
    
    func uploadTODO(todo: String) {
        //Generates number going up as time goes on, sets order of TODO's by how old they are.
        let number = Int(Date.timeIntervalSinceReferenceDate * 1000)
        
        let postRef = ref.child(String(number))
        let post = TODOS(todo: todo, isComplete: "false")
        postRef.setValue(post.toAnyObject())
    }
    
    func updateTODO(key: String, todo: String, isComplete: String) {
        print("Updating TODO: \(todo)\nIs Complete? \(isComplete)\nWhere to? \(ref.description())")
        let update = ["todo": todo, "isComplete": isComplete]
        let childUpdate = ["\(key)": update]
        ref.updateChildValues(childUpdate)
    }
    
    func signUp(email: String, password: String) {
        auth.createUser(withEmail: email, password: password) { [weak self] result, error in
            print(error, result)
            
            if error != nil {
                self?.errorMessage = error?.localizedDescription ?? ""
                self?.error = true
            }
            
            guard result != nil, error == nil else {
                return
            }
            
            self?.errorMessage = ""
            self?.error = false
            DispatchQueue.main.async {
                self?.signedIn = true
            }
            //            Signed-in
        }
    }
    
    func signOut() {
        try? auth.signOut()
        self.session = nil
        self.signedIn = false
        self.checklists = []
    }
}
