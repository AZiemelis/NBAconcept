//
//  Game.swift
//  NBAconcept
//
//  Created by Arturs Ziemelis on 22/11/2021.
//

import Foundation

struct API: Codable {
    let api: MainAPI
    
}

struct MainAPI: Codable {
    let games: [Game]
}


struct Game: Codable {
   
    let gameId: String
    let vTeam: versusTeam
    let hTeam: homeTeam

}
    struct homeTeam: Codable {
        let teamId: String
        let nickName: String
        let logo: String
        let score: homeTeamScore
        let fullName: String
        let shortName: String
    }
    
    struct versusTeam: Codable {
        let teamId: String
        let nickName: String
        let logo: String
        let score: versusTeamScore
        let fullName: String
        let shortName: String
    }
    
    struct homeTeamScore: Codable {
        let points: String
    }
    
    struct versusTeamScore: Codable {
        let points: String
    }
    

