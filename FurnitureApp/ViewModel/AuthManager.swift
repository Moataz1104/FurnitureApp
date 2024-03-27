//
//  AuthViewModel.swift
//  FurnitureApp
//
//  Created by Moataz Mohamed on 29/02/2024.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore






final class AuthManager:ObservableObject {
    
    @Published var user : User?
    
    @Published var isLoading = false
    @Published var errorMessage : String?
    @Published var isError = false
    @Published var userName : String = ""
    
    func listenToAuthState(){
        DispatchQueue.main.async {
            Auth.auth().addStateDidChangeListener {[weak self] _, user in
                guard let self = self else{return}
                self.user = user
            }
        }
    }
    
    func signIn(emailAddress:String,password:String){
        isLoading = true
        Auth.auth().signIn(withEmail: emailAddress, password: password){result , error in
            if let error = error{
                self.isError = true
                self.errorMessage = error.localizedDescription
                print("Sign In Error \(error.localizedDescription)")
                self.isLoading = false
                return
            }
            print("Log in Success")
            self.isLoading = false
            
        }
    }
    
    func signUp(emailAddress:String,password:String){
        isLoading = true
        Auth.auth().createUser(withEmail: emailAddress, password: password){[weak self] result , error in
            guard let self = self else {return}
            if let error = error {
                self.isError = true
                self.errorMessage = error.localizedDescription
                print(error.localizedDescription)
                self.isLoading = false
                return
            }
            print("Success")
            self.storeUsername(userName)
            
            self.isLoading = false

        }
    }
    func storeUsername(_ username: String) {
        let userID = Auth.auth().currentUser?.uid
        guard let userID = userID else {
            print("Error: User ID is nil")
            return
        }
        
        let userRef = Firestore.firestore().collection("users").document(userID)
        userRef.setData(["username": username]) { error in
            if let error = error {
                print("Error storing username: \(error.localizedDescription)")
            } else {
                print("Username stored successfully")
            }
        }
    }
    
    func getUsername(forUserID userID: String, completion: @escaping (String?) -> Void) {
        let db = Firestore.firestore()
        let userRef = db.collection("users").document(userID)

        userRef.getDocument { document, error in
            if let error = error {
                print("Error getting user document: \(error.localizedDescription)")
                completion(nil)
            } else if let document = document, document.exists {
                if let username = document.data()?["username"] as? String {
                    completion(username)
                } else {
                    print("Username not found in document data")
                    completion(nil)
                }
            } else {
                print("User document not found")
                completion(nil)
            }
        }
    }


    
    
    
    func signOut(){
        do{
            try Auth.auth().signOut()
            
        }catch let signOutError as NSError{
            print("Error signing out: %@", signOutError)
        }
    }
    func resetPassword(emailAddress:String){
        Auth.auth().sendPasswordReset(withEmail: emailAddress){error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
}
