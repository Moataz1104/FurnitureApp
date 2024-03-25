//
//  Test.swift
//  FurnitureApp
//
//  Created by Moataz Mohamed on 25/02/2024.
//

import SwiftUI
import Combine
struct LogInView: View {
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    @State private var isKeyboardPresented = false
    @State private var email = ""
    @State private var password = ""
    @State private var showingView = false
    
    var body: some View {
        ScrollView(showsIndicators:false){
            VStack{
                VStack(alignment:.leading){
                    HStack(spacing:20){
                        Rectangle()
                            .frame(width: screenWidth*0.3,height: 2)
                            .foregroundStyle(Color(hex: 0x909090))
                        Image(.authLogo)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 70,height: 70)
                        Rectangle()
                            .frame(width: screenWidth*0.3,height: 2)
                            .foregroundStyle(Color(hex: 0x909090))
                    }.padding(.vertical)
                    
                    Text("Hello !")
                        .font(.custom("Gelasio-Regular", size: 30))
                        .foregroundStyle(.subMain)
                    Text("WELCOME BACK")
                        .font(.custom("Gelasio-Bold", size: 26))
                        .foregroundStyle(.main)
                }
                .frame(maxWidth: .infinity)
                
                
                Spacer()
                
                if showingView{
                    HStack{
                        Rectangle()
                            .foregroundStyle(.white)
                            .shadow(color:Color(hex: 0x8A959E).opacity(0.5),radius: 7)
                            .overlay(alignment:.topLeading) {
                                InnerLogInView(width: screenWidth, height: screenHeight , email: $email,passWord: $password)
                            }
                            .frame(width:screenWidth*0.95,height:screenHeight*0.58)
                        Spacer()
                    }.transition(.move(edge: .trailing))
                }
                Spacer()
            }
            .frame(minHeight:screenHeight - 100)
            .onTapGesture {
                UIApplication.shared.endEditing()
            }
            .onAppear{
                NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { _ in
                    isKeyboardPresented = true
                }
                NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { _ in
                    isKeyboardPresented = false
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.12, execute: {
                    withAnimation(.easeIn(duration: 0.4)) {
                        self.showingView=true
                    }
                })
            }
            .onDisappear{
                NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
                NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
            }
        }
        .toolbar(.hidden)
        .scrollDisabled(isKeyboardPresented ? false : true)
    }
}

//#Preview {
//    LogInView()
//}


struct InnerLogInView : View{
    enum Field: Hashable {
        case password
    }
    let width : Double
    let height:Double
    
    @EnvironmentObject private var viewModel : AuthViewModel
    
    @Binding var email:String
    @Binding var passWord:String
    @State private var isSecure = true
    @State private var isEmailValid = true
    @State private var isPasswordValid = true
    @State private var showValEmailAlert = false
    @State private var showValPwAlert = false
    @FocusState private var focusedField: Field?
    
    var body:some View{
        if viewModel.isLoading{
            ProgressView()
                .position(x:width/2,y:200)
                
        }
        
        VStack{
            VStack(spacing:width*0.045){
                VStack(alignment:.leading){
                    Text("Email")
                        .font(.system(size: 14))
                        .foregroundStyle(Color(hex: 0x909090))
                        .padding(.top,20)
                    TextField("", text: $email)
                        .textContentType(.emailAddress)
                    
                    Rectangle()
                        .frame(maxWidth:.infinity)
                        .frame(height: 2)
                        .foregroundStyle(isEmailValid ? Color(hex: 0xE0E0E0) : .red)
                }.padding(.bottom)
                
                VStack(alignment:.leading){
                    Text("Password")
                        .font(.system(size: 14))
                        .foregroundStyle(Color(hex: 0x909090))
                    HStack{
                        Group{
                            if isSecure{
                                SecureField("", text: $passWord)
                                    .focused($focusedField,equals: .password)

                            }else{
                                TextField("", text: $passWord)
                                    .focused($focusedField,equals: .password)
                            }
                        }
                        Image(systemName: isSecure ? "eye.slash" : "eye")
                            .tint(.gray)
                            .padding(.trailing , 5)
                            .onTapGesture {
                                self.isSecure.toggle()
                            }
                    }
                    Rectangle()
                        .frame(maxWidth:.infinity)
                        .frame(height: 2)
                        .foregroundStyle(isPasswordValid ? Color(hex: 0xE0E0E0) : .red)
                }
            }.padding([.leading,.top])
            VStack(spacing:width*0.037){
                Spacer()
                Button{}label: {
                    Text("Forgot Password")
                        .font(.system(size: 18,weight: .semibold))
                        .foregroundStyle(Color(hex: 0x303030))
                }.padding( .bottom)
                Spacer()
                Button{
                    viewModel.signIn(emailAddress: email, password: passWord)
                }label: {
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: 290,height: 50)
                        .foregroundStyle(.main)
                        .shadow(radius: 10)
                        .overlay{
                            Text("Log In")
                                .font(.system(size: 18,weight: .semibold))
                                .foregroundStyle(.white)
                        }
                }
                .alert("", isPresented: $viewModel.isError, actions: {}){
                    Text(viewModel.errorMessage ?? "")
                }
                .disabled(isEmailValid && isPasswordValid ? false : true)
                
                
                NavigationLink(destination: SignUpView()) {
                    Text("Sign Up")
                        .font(.system(size: 18,weight: .semibold))
                        .foregroundStyle(Color(hex: 0x303030))
                    
                }
                Spacer()
                Spacer()
            }
            
        }
        .frame(width:width*0.95,height:height*0.58)
    }
}
