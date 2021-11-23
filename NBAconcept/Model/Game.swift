//
//  Game.swift
//  NBAconcept
//
//  Created by Arturs Ziemelis on 22/11/2021.
//

import Foundation

struct Game: Decodable {
   // let date: String
    let gameId: String
    let arena: String
    let city: String
    let vTeam: String
//    let teamId: String
//    let shortName: String
//    let fullName: String
//    let points: String
    let hTeam: String
//    let vTeamNickname: String
//    let hTeamNickname: String
//    let logo: String
   
    
    enum CodingKeys: String, CodingKey {
       // case date
        case gameId, arena, city
        case vTeam, hTeam
//        case fullName, points, hTeam, hTeamNickname, vTeamNickname
//        case logo, shortName, teamId
    }
}

struct gameCard: Decodable {
    let api: [Game]
}
