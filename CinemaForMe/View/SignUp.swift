//
//  SignUp.swift
//  CinemaForMe
//
//  Created by Sofi on 19.05.2021.
//

import SwiftUI

struct SignUp: View {
    @Binding var transition:Int
    @State var email = ""
    @State var password = ""
    @State var repassword = ""
    @State var firstName = ""
    @State var lastName = ""
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
                    CustomText(text: $firstName, placeholder: Text("Имя")).frame(width: 320, alignment: .center)
                }.padding(.top,64)
                ZStack{
                    RoundedRectangle(cornerRadius: 4).strokeBorder(Color("gr"),lineWidth: 1 ).frame(width: 343, height: 44, alignment: .center)
                    CustomText(text: $lastName, placeholder: Text("Фамилия")).frame(width: 320, alignment: .center)
                }.padding(.top,16)
                ZStack{
                    RoundedRectangle(cornerRadius: 4).strokeBorder(Color("gr"),lineWidth: 1 ).frame(width: 343, height: 44, alignment: .center)
                    CustomText(text: $email, placeholder: Text("E-mail")).frame(width: 320, alignment: .center)
                }.padding(.top,16)
                ZStack{
                    RoundedRectangle(cornerRadius: 4).strokeBorder(Color("gr"),lineWidth: 1 ).frame(width: 343, height: 44, alignment: .center)
                    CustomSecureText(text: $password, placeholder: Text("Пароль")).frame(width: 320, alignment: .center)
                }.padding(.top,16)
                ZStack{
                    RoundedRectangle(cornerRadius: 4).strokeBorder(Color("gr"),lineWidth: 1 ).frame(width: 343, height: 44, alignment: .center)
                    CustomSecureText(text: $repassword, placeholder: Text("Пароль")).frame(width: 320, alignment: .center)
                }.padding(.top,16)
                Button(action: {
                    if email != "" && password != ""{
                        if validate(email: email){
                            model.signUp(email: email, password: password, firstName: firstName, lastName: lastName)
                        { result, error in
                                if result == "Success" || error == "nil"{
                                    model.signIn(email: email, password: password){ result, errore in
                                        if result == "Success" || errore == "nil"{
                                            transition = 3
                                        }else{
                                            errorAlert.toggle()
                                            message = errore
                                        }
                                    }
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
                        Text("Зарегистрироваться").foregroundColor(Color.white).font(.custom("", size: 14))
                    }
                }).padding(.top,60).alert(isPresented: $errorAlert, content: {
                    Alert(title: Text("Error"), message: Text("\(message)"), dismissButton: .default(Text("Ok")))
                })
                Button(action: {
                    transition = 1
                }, label: {
                    ZStack{
                        RoundedRectangle(cornerRadius: 4).strokeBorder(Color("gr"),lineWidth: 1 ).frame(width: 343, height: 44, alignment: .center).foregroundColor(Color("re"))
                        Text("У меня уже есть аккаунт").foregroundColor(Color("re")).font(.custom("", size: 14))
                    }
                }).padding(.top,15)
                Spacer()
            }.offset( y: 70)
        }.edgesIgnoringSafeArea(.all).onAppear{
            DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
                UserDefaults.standard.set(true, forKey: "first")
            }
        }
    }
    func validate(email:String) -> Bool {
        var validate = "[a-z1-9]+@[a-z1-9]+.[a-z]{1,3}"
        var validateBool = NSPredicate(format: "SELF MATCHES %@", validate  )
        return validateBool.evaluate(with: email)
    }
}

struct SignUp_Previews: PreviewProvider {
    static var previews: some View {
        SignUp(transition: .constant(1))
    }
}
