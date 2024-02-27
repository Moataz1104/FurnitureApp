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
                    }.padding(.vertical)
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
    let width : Double
    let height:Double
    @Binding var name:String
    @Binding var email:String
    @Binding var passWord:String
    @Binding var confirmPassWord:String
    var body: some View {
        VStack{
            VStack(spacing:width*0.045){
                VStack(alignment:.leading){
                    Text("Name")
                        .font(.system(size: 14))
                        .foregroundStyle(Color(hex: 0x909090))
                    TextField("", text: $email)
                    Rectangle()
                        .frame(maxWidth:.infinity)
                        .frame(height: 2)
                        .foregroundStyle(Color(hex: 0xE0E0E0))
                }.padding(.bottom)
                VStack(alignment:.leading){
                    Text("Email")
                        .font(.system(size: 14))
                        .foregroundStyle(Color(hex: 0x909090))
                    TextField("", text: $email)
                    Rectangle()
                        .frame(maxWidth:.infinity)
                        .frame(height: 2)
                        .foregroundStyle(Color(hex: 0xE0E0E0))
                }.padding(.bottom)
                VStack(alignment:.leading){
                    Text("Password")
                        .font(.system(size: 14))
                        .foregroundStyle(Color(hex: 0x909090))
                    TextField("", text: $passWord)
                    Rectangle()
                        .frame(maxWidth:.infinity)
                        .frame(height: 2)
                        .foregroundStyle(Color(hex: 0xE0E0E0))
                }.padding(.bottom)
                VStack(alignment:.leading){
                    Text("Confirm Password")
                        .font(.system(size: 14))
                        .foregroundStyle(Color(hex: 0x909090))
                    TextField("", text: $email)
                    Rectangle()
                        .frame(maxWidth:.infinity)
                        .frame(height: 2)
                        .foregroundStyle(Color(hex: 0xE0E0E0))
                }
            }.padding([.leading,.top])
            
            Spacer()
            VStack(spacing:30){
                Button{}label: {
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: 290,height: 50)
                        .foregroundStyle(.main)
                        .shadow(radius: 10)
                        .overlay{
                            Text("SIGN UP")
                                .font(.system(size: 18,weight: .semibold))
                                .foregroundStyle(.white)
                        }
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
