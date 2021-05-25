//
//  Transition.swift
//  CinemaForMe
//
//  Created by Sofi on 19.05.2021.
//

import SwiftUI

struct Transition: View {
    @State var transition = 1
    var body: some View {
        ZStack{
        if transition == 1{
            SignIn(transition: $transition)
        }else if transition == 2{
            SignUp(transition: $transition)
        }
        else if transition == 3{
            BottomMenu(transition: $transition)
        }
        else if transition == 4{
            Detail(transition: $transition)
        }
        }.edgesIgnoringSafeArea(.all).onAppear{
            if  UserDefaults.standard.bool(forKey: "first"){
                transition = 1
            }else{
                transition = 2
            }
        }
    }
}

struct Transition_Previews: PreviewProvider {
    static var previews: some View {
        Transition()
    }
}
