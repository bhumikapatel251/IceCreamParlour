//
//  LoginScreen.swift
//  IceCreamParlour
//
//  Created by Bhumika Patel on 15/09/22.
//

import SwiftUI

struct LoginScreen: View {
    @State var email = ""
    @State var pass = ""
    
    @State var visible = false
    
    @State var color = Color.black.opacity(0.7)
    @State var alert = false
    @State var error = ""
//   @Binding var show : Bool
    var body: some View {
        ZStack{
            
            backgroundLogin.ignoresSafeArea()
            VStack(alignment: .leading, spacing: 8) {
                Text(attributedTitle)
                    .font(.largeTitle).bold()
                    .padding()
                    .padding(.vertical,-10)
                Text(attributedSubTitle)
                    .font(.title2)
                    .padding()
                    .padding(.vertical,-20)
                VStack{
                    Form()
                }
                .padding(.bottom,-190)
            }
            
        }
            
    }
    @ViewBuilder
    func Form()->some View{
        VStack(spacing: -40){
            VStack(spacing: 10){
                ZStack{
                    VStack(alignment:.leading, spacing: 10){
                        
//                        Text("Log In")
//                            .font(.system(size: 22).bold())
//                        .padding(.top,100)
//                        .multilineTextAlignment(.center)
//                        Text("Log in your Account")
//                            .font(.callout)
                        
                        Text(self.error).foregroundColor(.red).font(.system(size: 16))
                            .padding(.top,50)
                        Text("Email")
                            .padding(.top,60)
                        TextField("Email", text: $email)
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 4).stroke(self.email != "" ? Color.blue : self.color,lineWidth: 2))
                            .padding(.top, 1)
                       // Text(emailObj.error).foregroundColor(.red).font(.system(size: 13))
                        Text("Password")
                            .padding(.top,20)
                        HStack{
                            
                            VStack{
                                
                                if self.visible{
                                    TextField("Password", text: self.$pass)
                                        .autocapitalization(.none)
                                } else{
                                    SecureField("Password", text: self.$pass)
                                        .autocapitalization(.none)
                                
                                }
                            }
                            Button(action: {
                                self.visible.toggle()
                            }) {
                                Image(systemName: self.visible ? "eye.slash.fill" : "eye.fill")
                                    .foregroundColor(self.color)
                            }
                        }
                        .padding()
                        
                        .background(RoundedRectangle(cornerRadius: 4).stroke(self.pass != "" ? Color.blue : self.color,lineWidth: 2))
                        .padding(.top, 1)
                       // Text(passObj.error).foregroundColor(.red).font(.system(size: 13))
                        HStack{
                            Button{
                               // self.reset()
                                } label: {
                                    Text("ForgotPassword?")
                                        .foregroundColor(Color("G2"))
                                        .fontWeight(.semibold)
                                                            
                                                            
                                }
                                .padding(.leading, 20)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                           
                                
                    
                                
                    
                            Button {
                                
                                // check email and password empty
                               //self.verify()
                               
                            } label: {
                                
                            Text("Login")
                            .foregroundColor(.white)
                            .fontWeight(.semibold)
                            .frame(width: 150, height: 40)
                            .background(Color("G2"))
                            .cornerRadius(10)
            //
                               
                            }
                        }.padding(.vertical,30)
                    }
                    .padding(.bottom,40)
                    .padding(.horizontal, 17)
                }
                .padding(.vertical,50)
                    .background{
                        CustomArcShape()
                            .fill(Color.white)
                            .scaleEffect(1, anchor: .bottomLeading)
                            .padding(.top,40)
                            .ignoresSafeArea()
                }
            }
        }
        .background{
            CustomArcShape()
                .fill(Color("G2"))
        }
    }
    var attributedTitle: AttributedString{
        var attString = AttributedString(stringLiteral: "LogIn")
        if let rang = attString.range(of: "LogIn"){
            attString[rang].foregroundColor = .black
        }
        return attString
    }
    var attributedSubTitle: AttributedString{
        var attString = AttributedString(stringLiteral: "Log in your Account")
        if let rang = attString.range(of: "Log in your Account"){
            attString[rang].foregroundColor = .white
        }
        return attString
    }
    var backgroundLogin: some View {
        ZStack{
            AngularGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.5928403806, green: 0.6960029987, blue: 0.5323166828, alpha: 1)),Color(#colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)),Color(#colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)),Color(#colorLiteral(red: 0.6082496155, green: 0.6862257828, blue: 0.4985613901, alpha: 1)),Color(#colorLiteral(red: 0.6082496155, green: 0.6862257828, blue: 0.4985613901, alpha: 1))]), center: .center, angle: .degrees(120))
            
            LinearGradient(gradient: Gradient(colors: [Color.white.opacity(0.5), Color.white.opacity(0.7)]), startPoint: .bottom, endPoint: .top)
           
           
        }
    }
}

struct LoginScreen_Previews: PreviewProvider {
    static var previews: some View {
        LoginScreen()
    }
}
