//
//  Test.swift
//  FurnitureApp
//
//  Created by Moataz Mohamed on 25/02/2024.
//

import SwiftUI

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
                                InnerView(width: screenWidth, height: screenHeight , email: $email,passWord: $password)
                            }
                            .frame(width:screenWidth*0.95,height:screenHeight*0.58)
                        Spacer()
                    }.transition(.move(edge: .trailing))
                }
                Spacer()
            }
            .frame(minHeight:screenHeight - 100)
            .onAppear{
                NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { _ in
                    isKeyboardPresented = true
                }
                NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { _ in
                    isKeyboardPresented = false
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.32, execute: {
                    withAnimation(.easeIn(duration: 1)) {
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
    LogInView()
}


struct InnerView : View{
    let width : Double
    let height:Double
    @Binding var email:String
    @Binding var passWord:String
    
    var body:some View{
        VStack{
            VStack(spacing:width*0.045){
                VStack(alignment:.leading){
                    Text("Email")
                        .font(.system(size: 14))
                        .foregroundStyle(Color(hex: 0x909090))
                        .padding(.top,20)
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
                }
            }
            
            .padding()
            
            VStack(spacing:width*0.037){
                Spacer()
                Button{}label: {
                    Text("Forgot Password")
                        .font(.system(size: 18,weight: .semibold))
                        .foregroundStyle(Color(hex: 0x303030))
                }.padding( .bottom)
                Spacer()
                Button{}label: {
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: 290,height: 50)
                        .foregroundStyle(.main)
                        .overlay{
                            Text("Log In")
                                .font(.system(size: 18,weight: .semibold))
                                .foregroundStyle(.white)
                        }
                }
                
                Button{}label: {
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
