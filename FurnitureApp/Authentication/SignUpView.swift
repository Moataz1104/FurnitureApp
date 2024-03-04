//
//  SignUpView.swift
//  FurnitureApp
//
//  Created by Moataz Mohamed on 27/02/2024.
//

import SwiftUI

struct SignUpView: View {
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    
    
    @State private var isKeyboardPresented = false
    @State private var showingView = false
    @State private var name:String=""
    @State private var email:String=""
    @State private var passWord:String=""
    @State private var confirmPassWord:String=""
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
                    }
                    Text("WELCOME")
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
                                InnerSignUpView(width: screenWidth, height: screenHeight, name: $name, email: $email, passWord: $passWord, confirmPassWord: $confirmPassWord)
                            }
                            .frame(width:screenWidth*0.95,height:520)
                        Spacer()
                    }.transition(.move(edge: .trailing))
                }
                Spacer()
            }
            .frame(minHeight: screenHeight - 100)
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

#Preview {
    SignUpView()
}


struct InnerSignUpView : View {
    enum Field: Hashable {
        case password
    }

    let width : Double
    let height:Double
    
    @EnvironmentObject private var viewModel : AuthViewModel

    @Binding var name:String
    @Binding var email:String
    @Binding var passWord:String
    @Binding var confirmPassWord:String
    @State private var isSecure = true
    @FocusState private var focusedField: Field?

    @State private var isNameValid = true
    @State private var isEmailValid = true
    @State private var isPasswordValid = true
    @State private var isConfirmPWValid = true
    
    @State private var showValNameAlert = false
    @State private var showValEmailAlert = false
    @State private var showValPwAlert = false


    var body: some View {
        if viewModel.isLoading{
            ProgressView()
                .position(x:width/2,y:200)
                
        }

        VStack{
            VStack(spacing:width*0.045){
                VStack(alignment:.leading){
                    Text("Name")
                        .font(.system(size: 14))
                        .foregroundStyle(Color(hex: 0x909090))
                    TextField("", text: $name){isEditing in
                        if !isEditing{
                            isNameValid = !name.isEmpty
                        }
                    }
                    Rectangle()
                        .frame(maxWidth:.infinity)
                        .frame(height: 2)
                        .foregroundStyle(isNameValid ? Color(hex: 0xE0E0E0) : .red)
                }.padding(.bottom)
                VStack(alignment:.leading){
                    Text("Email")
                        .font(.system(size: 14))
                        .foregroundStyle(Color(hex: 0x909090))
                    TextField("", text: $email){ isEditing in
                        if !isEditing{
                            if !isEmailValid{
                                showValEmailAlert = true
                            }
                        }
                    }.onChange(of: email, { _, newValue in
                        isEmailValid = Validation.isValidEmail(newValue)

                    })
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
                        }.onChange(of: passWord, { _, newValue in
                            isPasswordValid = Validation.isPasswordValid(newValue)
                        })
                        .onChange(of: focusedField, { _, newValue in
                            if focusedField == nil {
                                if isPasswordValid == false {
                                    showValPwAlert = true
                                }
                            }
                        })

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
                }.padding(.bottom)
                VStack(alignment:.leading){
                    Text("Confirm Password")
                        .font(.system(size: 14))
                        .foregroundStyle(Color(hex: 0x909090))
                    HStack{
                        Group{
                            if isSecure{
                                SecureField("", text: $confirmPassWord)
                            }else{
                                TextField("", text: $confirmPassWord)
                            }
                        }.onChange(of:confirmPassWord){_ , newValue in
                            if newValue != passWord {
                                isConfirmPWValid = false
                            }else{
                                isConfirmPWValid = true

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
                        .foregroundStyle(isConfirmPWValid ? Color(hex: 0xE0E0E0) : .red)
                }
            }.padding([.leading,.top])
            
            Spacer()
            VStack(spacing:30){
                Button{
                    viewModel.signUp(emailAddress: email, password: confirmPassWord)
                }label: {
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: 290,height: 50)
                        .foregroundStyle(.main)
                        .shadow(radius: 10)
                        .overlay{
                            Text("SIGN UP")
                                .font(.system(size: 18,weight: .semibold))
                                .foregroundStyle(.white)
                        }
                }.alert("", isPresented: $viewModel.isError, actions: {}){
                    Text(viewModel.errorMessage ?? "")
                }

                HStack(spacing:3){
                    Text("Already Have Account?")
                        .foregroundStyle(.subTitle)
                    NavigationLink(destination: LogInView()) {
                        Text("SIGN IN")
                            .foregroundStyle(Color(hex: 0x303030))
                    }
                }
            }
            Spacer()
            
        }
    }
}
