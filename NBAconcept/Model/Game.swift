//
//  Game.swift
//  NBAconcept
//
//  Created by Arturs Ziemelis on 22/11/2021.
//

import Foundation

struct API: Decodable {
    let api: MainAPI
    
}

struct MainAPI: Decodable {
    let games: [Game]
}


struct Game: Decodable {
   
    let gameId: String
    let vTeam: versusTeam
    let hTeam: homeTeam

}
    struct homeTeam: Decodable {
        let teamId: String
        let nickName: String
        let logo: String
        let score: homeTeamScore
        let fullName: String
        let shortName: String
    }
    
    struct versusTeam: Decodable {
        let teamId: String
        let nickName: String
        let logo: String
        let score: versusTeamScore
        let fullName: String
        let shortName: String
    }
    
    struct homeTeamScore: Decodable {
        let points: String
    }
    
    struct versusTeamScore: Decodable {
        let points: String
    }
    

