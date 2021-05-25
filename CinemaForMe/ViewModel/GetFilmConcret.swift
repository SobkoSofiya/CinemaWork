//
//  GetFilmConcret.swift
//  CinemaForMe
//
//  Created by Sofi on 19.05.2021.
//

import Foundation
import Alamofire
import SwiftUI
import SwiftyJSON

class GetFilmConcretViewModel: ObservableObject {
    let idFilm = UserDefaults.standard.string(forKey: "idFilm")
    @Published var getFilm:[GetFilmModel] = []
    @Published var epi:[ModelTags] = []
    @Published var tegss:[Tags] = []
    init() {
        getFilmPosterModelForMe()
        getTags()
    }
    
    func getFilmPosterModelForMe() {
        let url = "http://cinema.areas.su/movies/\(idFilm!)"
        AF.request(url, method: .get).validate().responseJSON { [self]response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                if let images = json["images"].arrayObject {
                getFilm.append(GetFilmModel(movieId: json["movieId"].stringValue, name: json["name"].stringValue, age: json["age"].stringValue, images: json["images"].stringValue, poster: json["poster"].stringValue, tags: json["tags"].stringValue, description: json["description"].stringValue, image: images as! [String]))
                }
//                print("JSON: \(json)")
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getTags() {
        let url = "http://cinema.areas.su/movies/\(idFilm!)"
        AF.request(url, method: .get).validate().responseJSON { [self]response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
            
//                var tagArray = [Tags] =
                 let jsonArray = json["tags"].arrayValue
                print(jsonArray)
                for i in 0..<jsonArray.count{
                    let idTags = json["tags"][i]["idTags"].stringValue
                    let tagName = json["tags"][i]["tagName"].stringValue
                  
                    
                    tegss.append(Tags(idTags: idTags, tagName: tagName))
                   
                }
                epi.append(ModelTags(tag: tegss))
                
                
//            for i in
//                print("JSON: \(json)")
            case .failure(let error):
                print(error)
            }
        }
    }
}

class GetEpisode: ObservableObject {
    let idFilm = UserDefaults.standard.string(forKey: "idFilm")
    @Published var episodeFilm:[EpisodeModel] = []
  
    init() {
        getFilmPosterModelForMe()
    }
    
    func getFilmPosterModelForMe() {
        let url = "http://cinema.areas.su/movies/\(idFilm!)/episodes"
        AF.request(url, method: .get).validate().responseJSON { [self]response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
               for i in 0..<json.count{
               if  let images = json[i]["images"].arrayObject {
                episodeFilm.append(EpisodeModel(episodeId: json[i]["episodeId"].stringValue, name: json[i]["name"].stringValue, description: json[i]["description"].stringValue, director: json[i]["director"].stringValue, stars: json[i]["stars"].stringValue, year: json[i]["year"].stringValue, images: json[i]["images"].stringValue, runtime: json[i]["runtime"].stringValue, preview: json[i]["preview"].stringValue, moviesId: json[i]["moviesId"].stringValue, image: images as! [String]))
//                print(episodeFilm)
                print("JSON: \(images)")
                }
               }
                
            
//                print("JSON: \(json)")
            case .failure(let error):
                print(error)
            }
        }
    }
}
