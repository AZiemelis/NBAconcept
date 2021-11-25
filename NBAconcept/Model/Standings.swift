//
//  Standings.swift
//  NBAconcept
//
//  Created by Arturs Ziemelis on 25/11/2021.
//

import Foundation

struct StandingsAPI: Decodable {
    let api: StandingsMainAPI
}

struct StandingsMainAPI: Decodable {
    let standings: [Standings]
}

struct Standings: Decodable {
    let teamId: String
    let win: String
    let loss: String
    let conference: Confrence
}

struct Confrence: Decodable {
    let name: String
    let rank: String
}

