//
//  Deatail.swift
//  CinemaForMe
//
//  Created by Sofi on 19.05.2021.
//

import SwiftUI
import SDWebImageSwiftUI
import YouTubePlayer
import AVKit
struct Detail: View {
    @Binding var transition:Int
    @StateObject var modelFilm = GetFilmConcretViewModel()
    @StateObject var episodModel = GetEpisode()
    @State var url = ""
    var body: some View {
        ZStack{
            Color("for")
            ScrollView(.vertical, showsIndicators: false, content: {
                VStack(spacing:0){
                    ZStack{
                        WebImage(url: URL(string: "http://cinema.areas.su/up/images/\(modelFilm.getFilm.first?.poster ?? "")")).resizable()
                    .frame(width: UIScreen.main.bounds.width
                                      , height: 400, alignment: .center)
                        VStack(alignment:.leading, spacing:0){
                            ZStack{
                                HStack(spacing:0){
                                    Button(action: {
                                        transition = 3
                                    }, label: {
                                        Image("arr")
                                    })
                                 .padding(.leading,10)
                                    Spacer()
                                  
                                    Spacer()
                                    Text("\(modelFilm.getFilm.first?.age ?? "")+").foregroundColor(Color("\(modelFilm.getFilm.first?.age ?? "")")).font(.custom("", size: 14)).padding(.trailing)
                                    Image("mes").padding(.trailing)
                                }
                                Text("\(modelFilm.getFilm.first?.name ?? "" )").foregroundColor(Color.white).font(.custom("", size: 14))
                            }.padding(.top,50)
                            Spacer()
                            TagsView(model: $modelFilm.tegss).padding()
                        }
                    }
                    HStack{
                        Text("Смотреть").foregroundColor(Color.white).font(.custom("", size: 24))
                        Spacer()
                        
                    }.padding(.top).frame(width: 343, alignment: .center).padding(.vertical)
//                    if let url = episodModel.episodeFilm.first?.preview {
//                    Video(urlString:$url ).frame(width: UIScreen.main.bounds.width, height: 210, alignment: .center)
//                    }
                    HStack{
                        Text("Описание").foregroundColor(Color.white).font(.custom("", size: 24))
                        Spacer()
                        
                    }.padding(.top).frame(width: 343, alignment: .center).padding(.vertical)
                    Text("\(modelFilm.getFilm.first?.description ?? "")").foregroundColor(Color.white).font(.custom("", size: 14)).frame(width: 343, alignment: .topLeading)
                    HStack{
                        Text("Кадры").foregroundColor(Color.white).font(.custom("", size: 24))
                        Spacer()
                        
                    }.padding(.top).frame(width: 343, alignment: .center).padding(.vertical)
                    ScrollView(.horizontal, showsIndicators: false, content: {
                        HStack(spacing:16){
                            ForEach(modelFilm.getFilm.first?.image ?? [""], id:\.self){ i in
                                WebImage(url: URL(string: "http://cinema.areas.su/up/images/\(i)")).resizable()
                                .frame(width: 128, height: 72, alignment: .center)
                            }
                        }
                    }).padding(.leading)
                    HStack{
                        Text("Эпизоды").foregroundColor(Color.white).font(.custom("", size: 24))
                        Spacer()
                        
                    }.padding(.top).frame(width: 343, alignment: .center).padding(.vertical)
                    ForEach(0..<episodModel.episodeFilm.count, id:\.self){ i in
                        HStack(alignment:.top){
                            ForEach(0..<episodModel.episodeFilm[i].image.count,id:\.self){ ii in
//                                if ii == i{
                                WebImage(url: URL(string: "http://cinema.areas.su/up/images/\(ii)")).resizable()
                                    .frame(width: 128, height: 72, alignment: .center).padding()
//                                }
                            }
                          
                            VStack(alignment:.leading,spacing:0){
                                Text("\(episodModel.episodeFilm[i].name)").foregroundColor(Color.white).font(.custom("", size: 14)).frame(width: 199, height: 14, alignment: .topLeading)
                                Text("\(episodModel.episodeFilm[i].description)").foregroundColor(Color("gr")).font(.custom("", size: 12)).frame(width: 199, height: 28, alignment: .topLeading).padding(.top,12)
                                Text("\(episodModel.episodeFilm[i].year)").foregroundColor(Color("gr")).font(.custom("", size: 12)).frame(width: 199, height: 28, alignment: .topLeading).padding(.top,6)
                            }
                        }
                    }
                
                
                }
                Rectangle().frame(width: 100, height: 50, alignment: .center   ).foregroundColor(Color("for"))
            })
        }.edgesIgnoringSafeArea(.all).onAppear{
            episodModel.getFilmPosterModelForMe()
            DispatchQueue.main.asyncAfter(deadline: .now()+2) {
                url = "http://cinema.areas.su/up/video/\(episodModel.episodeFilm.first?.preview ?? "")"
            }
        }
    }
}

struct Deatail_Previews: PreviewProvider {
    static var previews: some View {
        Detail(transition: .constant(1))
    }
}
struct Video:UIViewControllerRepresentable {
    @Binding var urlString:String
    func makeUIViewController(context: Context) -> AVPlayerViewController {
        
        print(urlString)
        let url = URL(string: urlString)
        let controller = AVPlayerViewController()
        
        let VideoConreoller = AVPlayer(url: url!)
        
        controller.player = VideoConreoller
        
        return controller
    }
    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {
        
    }
}


//struct Video:UIViewControllerRepresentable {
//    @State var urlString:String
//    func makeUIViewController(context: Context) -> AVPlayerViewController {
//        
//        print(urlString)
//        let url = URL(string: urlString)
//        let controller = AVPlayerViewController()
//        
//        let VideoConreoller = AVPlayer(url: url!)
//        
//        controller.player = VideoConreoller
//        
//        return controller
//    }
//    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {
//        
//    }
//}


struct TagsView:View {
    @Binding var model:[Tags]
    let colums = [
        GridItem(.flexible()),
        GridItem(.flexible())
      
      
    ]
    var body: some View{
        ZStack{
//            LazyHGrid(rows: colums, spacing:10, content: {
            VStack(alignment:.leading){
            HStack{
                if model.count > 0{
                    ForEach(model, id:\.self) { i in
                        if model.index(of: i)! >= 0 && model.index(of: i)! <= 2{
                            ZStack{
                                RoundedRectangle(cornerRadius: 4).frame(width:CGFloat(i.tagName.count)*10, height: 24, alignment: .center).foregroundColor(Color("re"))
                                Text(i.tagName).foregroundColor(.white).font(.custom("", size: 14))
                              
                            }
                        }
                        
                    }
                }
                }
                HStack{
                    if model.count > 3{
                        ForEach(model, id:\.self) { i in
                            if model.index(of: i)! >= 3 &&  model.index(of: i)! <= 6{
                                ZStack{
                                    RoundedRectangle(cornerRadius: 4).frame(width:CGFloat(i.tagName.count)*10, height: 24, alignment: .center).foregroundColor(Color("re"))
                                    Text(i.tagName).foregroundColor(.white).font(.custom("", size: 14))
                                  
                                }
                            }
                            
                        }
                    }
                    }
                HStack{
                    if model.count > 7{
                        ForEach(model, id:\.self) { i in
                            if model.index(of: i)! >= 7 {
                                ZStack{
                                    RoundedRectangle(cornerRadius: 4).frame(width:CGFloat(i.tagName.count)*10, height: 24, alignment: .center).foregroundColor(Color("re"))
                                    Text(i.tagName).foregroundColor(.white).font(.custom("", size: 14))
                                  
                                }
                            }
                            
                        }
                    }
                    }
            }
                
//            }).frame(width: 300, height: 100, alignment: .leading)
           
        }
    }
}
