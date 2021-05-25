//
//  SignIn.swift
//  CinemaForMe
//
//  Created by Sofi on 19.05.2021.
//

import SwiftUI

struct SignIn: View {
    @Binding var transition:Int
    @State var email = ""
    @State var password = ""
    @State var message = ""
    @State var errorAlert = false
    @StateObject var model = ViewModel()
    var body: some View {
        ZStack{
            Color("for")
            VStack(spacing:0){
                Image("ic")
                Text("WorldCinema").foregroundColor(Color("re")).font(.custom("", size: 23)).padding(.top,16)
                ZStack{
                    RoundedRectangle(cornerRadius: 4).strokeBorder(Color("gr"),lineWidth: 1 ).frame(width: 343, height: 44, alignment: .center)
                    CustomText(text: $email, placeholder: Text("E-mail")).frame(width: 320, alignment: .center)
                }.padding(.top,104)
                ZStack{
                    RoundedRectangle(cornerRadius: 4).strokeBorder(Color("gr"),lineWidth: 1 ).frame(width: 343, height: 44, alignment: .center)
                    CustomSecureText(text: $password, placeholder: Text("Пароль")).frame(width: 320, alignment: .center)
                }.padding(.top,16)
                Button(action: {
                    if email != "" && password != ""{
                        if validate(email: email){
                            model.signIn(email: email, password: password){ result, error in
                                if result == "Success" || error == "nil"{
                                    transition = 3
                                }else{
                                    errorAlert.toggle()
                                    message = error
                                }
                            }
                        }else{
                            errorAlert.toggle()
                            message = "Incorrect email"
                        }
                    }else{
                        errorAlert.toggle()
                        message = "Enter all fields"
                    }
                }, label: {
                    ZStack{
                        RoundedRectangle(cornerRadius: 4).frame(width: 343, height: 44, alignment: .center).foregroundColor(Color("re"))
                        Text("Войти").foregroundColor(Color.white).font(.custom("", size: 14))
                    }
                }).padding(.top,170).alert(isPresented: $errorAlert, content: {
                    Alert(title: Text("Error"), message: Text("\(message)"), dismissButton: .default(Text("Ok")))
                })
                Button(action: {
                    transition = 2
                }, label: {
                    ZStack{
                        RoundedRectangle(cornerRadius: 4).strokeBorder(Color("gr"),lineWidth: 1 ).frame(width: 343, height: 44, alignment: .center).foregroundColor(Color("re"))
                        Text("Регистрация").foregroundColor(Color("re")).font(.custom("", size: 14))
                    }
                }).padding(.top,15)
                Spacer()
            }.offset( y: 120)
        }.edgesIgnoringSafeArea(.all).onAppear{
            email = "vasya@mail.com"
            password = "qwerty"
        }
    }
    func validate(email:String) -> Bool {
        var validate = "[a-z1-9]+@[a-z1-9]+.[a-z]{1,3}"
        var validateBool = NSPredicate(format: "SELF MATCHES %@", validate  )
        return validateBool.evaluate(with: email)
    }
}

struct SignIn_Previews: PreviewProvider {
    static var previews: some View {
        SignIn(transition: .constant(1))
    }
}


struct CustomText:View {
    @Binding var text:String
    @State var placeholder:Text
    var body: some View{
        ZStack(alignment:.leading   ){
            
            if text.isEmpty{
                placeholder.foregroundColor(Color("gr")).font(.custom("", size: 14))
            }
            TextField("", text: $text).foregroundColor(Color("gr")).font(.custom("", size: 14))
        }
    }
}
struct CustomSecureText:View {
    @Binding var text:String
    @State var placeholder:Text
    var body: some View{
        ZStack(alignment:.leading   ){
            
            if text.isEmpty{
                placeholder.foregroundColor(Color("gr")).font(.custom("", size: 14))
            }
            SecureField("", text: $text).foregroundColor(Color("gr")).font(.custom("", size: 14))
        }
    }
}
