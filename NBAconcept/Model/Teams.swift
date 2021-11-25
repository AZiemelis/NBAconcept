//
//  Teams.swift
//  NBAconcept
//
//  Created by Arturs Ziemelis on 25/11/2021.
//

import Foundation

struct TeamsAPI: Decodable {
    let api: TeamsMainAPI
}

struct TeamsMainAPI: Decodable {
    let teams: [Teams]
}

struct Teams: Decodable {
    //let teamId: String
    let fullName: String
    let shortName: String
    let logo: String
}






//func getTeamsInfo(teamId: String) {
//    let headers = [
//        "x-rapidapi-host": "api-nba-v1.p.rapidapi.com",
//        "x-rapidapi-key": "29a89b941dmshb710b982fc842fdp17f010jsne45e8742fe9a"
//    ]
//
//    let request = NSMutableURLRequest(url: NSURL(string: "https://api-nba-v1.p.rapidapi.com/teams/teamId/\(teamId)")! as URL,
//                                            cachePolicy: .useProtocolCachePolicy,
//                                        timeoutInterval: 10.0)
//    request.httpMethod = "GET"
//    request.allHTTPHeaderFields = headers
//
//    let session = URLSession.shared
//    let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
//        if (error != nil) {
//            print(error!)
//        } else {
//            let httpResponse = response as? HTTPURLResponse
//            print(httpResponse!)
//        }
//
//        do {
//            let jsonData = try JSONDecoder().decode(TeamsAPI.self, from: data!)
//            DispatchQueue.main.async {
//
//            }
//        }catch {
//            print("err:", error)
//        }
//
//    })
//
//    dataTask.resume()
//}
