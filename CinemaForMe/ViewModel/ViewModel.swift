//
//  ViewModel.swift
//  CinemaForMe
//
//  Created by Sofi on 19.05.2021.
//

import Foundation
import Alamofire
import SwiftUI
import SwiftyJSON

class ViewModel: ObservableObject {
    func signUp(email:String, password:String,firstName:String, lastName:String,con:((_ result:String, _ error:String) -> Void)? = nil) {
        let url = "http://cinema.areas.su/auth/register?email=\(email)&password=\(password)&firstName=\(firstName)&lastName=\(lastName)"
        AF.request(url, method: .post).validate().responseString { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                con!("Success","nil")
            case .failure(let error):
                con!("nil","Error")
                print(error)
            }
        }
    }
    func signIn(email:String, password:String,con:((_ result:String, _ error:String) -> Void)? = nil) {
        let url = "http://cinema.areas.su/auth/login?email=\(email)&password=\(password)"
        AF.request(url, method: .post).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                con!("Success","nil")
            case .failure(let error):
                con!("nil","Error")
                print(error)
            }
        }
    }
}
