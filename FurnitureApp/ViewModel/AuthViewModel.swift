//
//  AuthViewModel.swift
//  FurnitureApp
//
//  Created by Moataz Mohamed on 29/02/2024.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore


protocol AuthViewModelProtocol {
    var user: User? { get }
    var isLoading: Bool { get }
    var errorMessage: String? { get }
    var isError: Bool { get }
    
    func listenToAuthState()
    func signIn(emailAddress: String, password: String)
    func signUp(emailAddress: String, password: String)
    func signOut()
    func resetPassword(emailAddress: String)
}




final class AuthViewModel:ObservableObject , AuthViewModelProtocol{
    
    @Published var user : User?
    
    @Published var isLoading = false
    @Published var errorMessage : String?
    @Published var isError = false
    
    func listenToAuthState(){
        Auth.auth().addStateDidChangeListener {[weak self] _, user in
            guard let self = self else{return}
            self.user = user
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
        Auth.auth().createUser(withEmail: emailAddress, password: password){ result , error in
            if let error = error {
                self.isError = true
                self.errorMessage = error.localizedDescription
                print(error.localizedDescription)
                self.isLoading = false
                return
            }
            print("Success")
            self.isLoading = false

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
