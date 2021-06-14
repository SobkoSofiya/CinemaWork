//
//  test.swift
//  CinemaForMe
//
//  Created by Sofi on 19.05.2021.
//

import SwiftUI
import  SDWebImageSwiftUI
struct test: View {
    @StateObject var model = ViewModelGetTrend()
    @StateObject var episodModel = GetEpisode()
    @State var url = ""
    var body: some View {
//
        ZStack{
           
//            if let url = episodModel.episodeFilm.first?.preview {
                Text("Ect")
                              Video(urlString:$url).frame(width: UIScreen.main.bounds.width, height: 210, alignment: .center)
//            }else{
//                Text("Нету")
//            }
        }.onAppear{
        print("lala")
            DispatchQueue.main.asyncAfter(deadline: .now()+2) {
                self.url = "http://cinema.areas.su/up/video/\(episodModel.episodeFilm.first?.preview ?? "")"
            }
            
        }
//        } height: 400, alignment: .center)
    }
}

struct test_Previews: PreviewProvider {
    static var previews: some View {
        test()
    }
}
