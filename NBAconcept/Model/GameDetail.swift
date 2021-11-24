//
//  GameDetail.swift
//  NBAconcept
//
//  Created by Arturs Ziemelis on 24/11/2021.
//

import Foundation

struct GameDetailAPI: Codable {
    let api: GameDetailMainAPI
    
}

struct GameDetailMainAPI: Codable {
    let game: [GameDetail]
}


struct GameDetail: Codable {

    let vTeam: GameDetailVersusTeam
    let hTeam: GameDetailHomeTeam

}

struct GameDetailHomeTeam: Codable {
    let leaders: [GameDetailLeaders]

}

struct GameDetailVersusTeam: Codable {
    let leaders: [GameDetailLeaders]

}
    
struct GameDetailLeaders: Codable {
    let assists: String?
    let rebounds: String?
    let points: String?
    let name: String
}
