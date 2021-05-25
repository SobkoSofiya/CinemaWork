//
//  Main.swift
//  CinemaForMe
//
//  Created by Sofi on 19.05.2021.
//

import SwiftUI
import SDWebImageSwiftUI
struct BottomMenu:View {
    @State var selection = 1
    @Binding var transition:Int
    var body: some View{
        TabView(selection: $selection,
                content:  {
                    Main(transition: $transition).tag(1).tabItem {
                       
                        Image(selection == 1 ? "rete" : "te")
                        Text("Главное")
                    }
                    Main(transition: $transition).tag(2).tabItem {
                       
                        Image(selection == 2 ? "rebox" : "box")
                        Text("Подборка")
                    }
                    Main(transition: $transition).tag(3).tabItem {
                       
                        Image(selection == 3 ? "restar" : "star")
                        Text("Коллекции")
                    }
                    Main(transition: $transition).tag(4).tabItem {
                       
                        Image(selection == 4 ? "repro" : "pro")
                        Text("Профиль")
                    }
                
                }).edgesIgnoringSafeArea(.all).onAppear{
                    UITabBar.appearance().tintColor = UIColor(Color("re"))
                    UITabBar.appearance().tintColor = UIColor(Color("re"))
                    UITabBar.appearance().backgroundColor = UIColor(Color.init(#colorLiteral(red: 0.1098039216, green: 0.1019607843, blue: 0.09803921569, alpha: 1)))
                    UITabBar.appearance().barTintColor = UIColor(Color.init(#colorLiteral(red: 0.1098039216, green: 0.1019607843, blue: 0.09803921569, alpha: 1)))
                }
    }
}

struct Main: View {
    @Binding var transition:Int
    @StateObject var modelPoster = ViewModelGetPoster()
    @StateObject var modelFilmsNew = ViewModelGetNew()
    @StateObject var modelFilmsTrend = ViewModelGetTrend()
    @StateObject var modelFilmsForMe = ViewModelGetForMe()
    var body: some View {
        ZStack{
            Color("for")
            ScrollView(.vertical, showsIndicators: false, content: {
                VStack(spacing:0){
                    ZStack{
                        WebImage(url: URL(string: "http://cinema.areas.su/up/images/\(modelPoster.model.first?.backgroundImage ?? "")")).resizable().frame(width: UIScreen.main.bounds.width
                                                                                                                                                           , height: 400, alignment: .center)
                        WebImage(url: URL(string: "http://cinema.areas.su/up/images/\(modelPoster.model.first?.foregroundImage ?? "")")).resizable().frame(width: UIScreen.main.bounds.width
                                                                                                                                                           , height: 400, alignment: .center)
//                        Rectangle().frame(width: UIScreen.main.bounds.width
//                                          , height: 400, alignment: .center)
                        Button(action: {}, label: {
                            ZStack{
                                RoundedRectangle(cornerRadius: 4).frame(width: 134, height: 44, alignment: .center).foregroundColor(Color("re"))
                                Text("Смотреть").foregroundColor(.white).font(.custom("", size: 14))
                            }
                        }).padding(.top,270)
                    }
                    HStack{
                        Text("В тренде").foregroundColor(Color("re")).font(.custom("", size: 24))
                        Spacer()
                        
                    }.frame(width: 343, alignment: .center).padding(.vertical)
                    ScrollView(.horizontal, showsIndicators: false, content: {
                        HStack(spacing:16){
                            ForEach(0..<modelFilmsTrend.model.count,id:\.self){ i in
                               
                                    Button(action: {
                                        UserDefaults.standard.setValue(modelFilmsTrend.model[i].movieId, forKey: "idFilm")
                                        transition = 4
                                    }, label: {
                                        ZStack{
                                            Text("heellow")
                                        WebImage(url: URL(string: "http://cinema.areas.su/up/images/\(modelFilmsTrend.model[i].poster)")).resizable()
                                        .frame(width: 100, height: 144, alignment: .center)
                                            
                                        }
                                    })
                            }
                        }
                    }).padding(.leading)
                    HStack{
                        Text("Вы смотрели").foregroundColor(Color("re")).font(.custom("", size: 24))
                        Spacer()
                        
                    }.frame(width: 343, alignment: .center).padding(.vertical).padding(.top)
                    ZStack{
                        Rectangle().frame(width: UIScreen.main.bounds.width, height: 240, alignment: .center)
                        Image("play")
                        Text("Altered Carbon").foregroundColor(Color.white).font(.custom("", size: 14)).offset(x: -120, y: 90)
                    }
                    HStack{
                        Text("Новое").foregroundColor(Color("re")).font(.custom("", size: 24))
                        Spacer()
                        
                    }.padding(.top).frame(width: 343, alignment: .center).padding(.vertical)
                    ScrollView(.horizontal, showsIndicators: false, content: {
                        HStack(spacing:16){
                            ForEach(0..<modelFilmsNew.model.count,id:\.self){ i in
                                Button(action: {
                                    UserDefaults.standard.setValue(modelFilmsNew.model[i].movieId, forKey: "idFilm")
                                    transition = 4
                                }, label: {
                                    WebImage(url: URL(string: "http://cinema.areas.su/up/images/\(modelFilmsNew.model[i].poster)")).resizable()
                                    .frame(width: 240, height: 144, alignment: .center)
                                })
                           
                            }
                        }
                    }).padding(.leading)
                    HStack{
                        Text("Для вас").foregroundColor(Color("re")).font(.custom("", size: 24))
                        Spacer()
                        
                    }.padding(.top).frame(width: 343, alignment: .center).padding(.vertical)
                    ScrollView(.horizontal, showsIndicators: false, content: {
                        HStack(spacing:16){
                            ForEach(0..<modelFilmsForMe.model.count,id:\.self){ i in
                                Button(action: {
                                    UserDefaults.standard.setValue(modelFilmsForMe.model[i].movieId, forKey: "idFilm")
                                    transition = 4
                                }, label: {
                                    WebImage(url: URL(string: "http://cinema.areas.su/up/images/\(modelFilmsForMe.model[i].poster)")).resizable()
                                   .frame(width: 100, height: 144, alignment: .center)
                                })
                             
                            }
                        }
                    }).padding(.leading)
                    Button(action: {}
                           , label: {
                            ZStack{
                                RoundedRectangle(cornerRadius: 4).frame(width: 343, height: 44, alignment: .center).foregroundColor(Color("re"))
                                Text("Указать интересы").foregroundColor(Color.white).font(.custom("", size: 14))
                            }
                           }).padding(.top,50)
                }
                Rectangle().foregroundColor(Color("for")).frame(width: 100, height: 120, alignment: .center)
            })
        }.edgesIgnoringSafeArea(.all)
    }
}

struct Main_Previews: PreviewProvider {
    static var previews: some View {
        BottomMenu(transition: .constant(1))
    }
}

