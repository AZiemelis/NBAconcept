//
//  GameDetail.swift
//  NBAconcept
//
//  Created by Arturs Ziemelis on 24/11/2021.
//

import Foundation

struct GameDetailAPI: Decodable {
    let api: GameDetailMainAPI
    
}

struct GameDetailMainAPI: Decodable {
    let game: [GameDetail]
}


struct GameDetail: Decodable {

    let vTeam: GameDetailVersusTeam
    let hTeam: GameDetailHomeTeam

}

struct GameDetailHomeTeam: Decodable {
    let leaders: [GameDetailLeaders]

}

struct GameDetailVersusTeam: Decodable {
    let leaders: [GameDetailLeaders]

}
    
struct GameDetailLeaders: Decodable {
    let assists: String?
    let rebounds: String?
    let points: String?
    let name: String
}
