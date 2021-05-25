//
//  ViewModelGetPoster.swift
//  CinemaForMe
//
//  Created by Sofi on 19.05.2021.
//

import Foundation
import Alamofire
import SwiftUI
import SwiftyJSON

class ViewModelGetPoster: ObservableObject {
    @Published var model :[GetPosterModel] = []
    init() {
        getPoster()
    }
    func getPoster() {
        let url = "http://cinema.areas.su/movies/cover"
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
//                print("JSON: \(json)")
                self.model.append(GetPosterModel(movieId: json["movieId"].stringValue, backgroundImage: json["backgroundImage"].stringValue, foregroundImage: json["foregroundImage"].stringValue))
            case .failure(let error):
               
                print(error)
            }
        }
    }
}

class ViewModelGetNew: ObservableObject {
    @Published var model :[FilmsNewModel] = []
    init() {
        getPoster()
    }
    func getPoster() {
        let url = "http://cinema.areas.su/movies?filter=new"
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
//                print("JSON: \(json)")
                for i in 0..<json.count{
                self.model.append(FilmsNewModel(movieId: json[i]["movieId"].stringValue, poster: json[i]["movieId"].stringValue))
                }
            case .failure(let error):
               
                print(error)
            }
        }
    }
}

class ViewModelGetTrend: ObservableObject {
    @Published var model :[FilmsTrendModel] = []
    init() {
        getPoster()
    }
    func getPoster() {
        let url = "http://cinema.areas.su/movies?filter=inTrend"
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
//                print("JSON: \(json)")
                for i in 0..<json.count{
                self.model.append(FilmsTrendModel(movieId: json[i]["movieId"].stringValue, poster: json[i]["movieId"].stringValue))
                }
            case .failure(let error):
               
                print(error)
            }
        }
    }
}
class ViewModelGetForMe: ObservableObject {
    @Published var model :[FilmsForMeModel] = []
    init() {
        getPoster()
    }
    func getPoster() {
        let url = "http://cinema.areas.su/movies?filter=forMe"
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
//                print("JSON: \(json)")
                for i in 0..<json.count{
                self.model.append(FilmsForMeModel(movieId: json[i]["movieId"].stringValue, poster: json[i]["movieId"].stringValue))
                }
            case .failure(let error):
               
                print(error)
            }
        }
    }
}
