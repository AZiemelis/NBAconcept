//
//  Standings.swift
//  NBAconcept
//
//  Created by Arturs Ziemelis on 25/11/2021.
//

import Foundation

struct StandingsAPI: Codable {
    let api: StandingsMainAPI
}

struct StandingsMainAPI: Codable {
    let standings: [Standings]
}

struct Standings: Codable {
    let teamId: String
    let win: String
    let loss: String
}
