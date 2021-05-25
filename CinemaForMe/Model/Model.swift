//
//  Model.swift
//  CinemaForMe
//
//  Created by Sofi on 19.05.2021.
//

import Foundation
import SwiftUI


struct GetPosterModel:Hashable {
    var movieId, backgroundImage, foregroundImage:String
    
}

struct FilmsNewModel {
    var movieId, poster:String
}
struct FilmsTrendModel {
    var movieId, poster:String
}
struct FilmsForMeModel {
    var movieId, poster:String
}
struct ConcretFilm {
    var movieId, name, description, age, poster:String
    var tags :[String]
    var images:[String]
}
struct EpisodeModel:Hashable {
    let episodeId,name,description,director, stars, year, images, runtime,preview,moviesId:String
    let image:[String]
}
struct Tags:Hashable {
    var idTags,tagName:String
}
struct ModelTags:Hashable {
    var tag:[Tags]
}

struct GetFilmModel:Hashable {
   
    
    let movieId,name,age, images, poster, tags, description:String
    let image:[String]
}
