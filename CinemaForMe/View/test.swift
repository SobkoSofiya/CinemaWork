//
//  test.swift
//  CinemaForMe
//
//  Created by Sofi on 19.05.2021.
//

import SwiftUI
import  SDWebImageSwiftUI
struct test: View {
//    @State
    @StateObject var modelPoster = ViewModelGetPoster()
    var body: some View {
        WebImage(url: URL(string: "http://cinema.areas.su/up/images/\(modelPoster.model.first?.backgroundImage ?? "")")).resizable().frame(width: UIScreen.main.bounds.width
                                                                                                                                           , height: 400, alignment: .center)
    }
}

struct test_Previews: PreviewProvider {
    static var previews: some View {
        test()
    }
}
