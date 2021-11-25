//
//  StandingsViewController.swift
//  NBAconcept
//
//  Created by Arturs Ziemelis on 24/11/2021.
//

import UIKit
import SDWebImage

class StandingsViewController: UIViewController {
    
    var standingsVariable: [Standings] = []
    var teamVariable: [Teams] = []

    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        getNBAstandingsData(year: "2021")

    }
    
    
    @IBAction func calendarButtonTapped(_ sender: UIBarButtonItem) {
        
    }
    
    func activityIndicator(animated: Bool) {
        DispatchQueue.main.async {
            if animated {
                
                self.activityIndicatorView.isHidden = false
                self.activityIndicatorView.startAnimating()
            
            }else {
                
                self.activityIndicatorView.isHidden = true
                self.activityIndicatorView.startAnimating()
                
            }
        }
    }
    

    func getNBAstandingsData(year: String) {
        activityIndicator(animated: true)
        let headers = [
            "x-rapidapi-host": "api-nba-v1.p.rapidapi.com",
            "x-rapidapi-key": "29a89b941dmshb710b982fc842fdp17f010jsne45e8742fe9a"
        ]

        let request = NSMutableURLRequest(url: NSURL(string: "https://api-nba-v1.p.rapidapi.com/standings/standard/2021")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error)
            } else {
                let httpResponse = response as? HTTPURLResponse
                print(httpResponse)
            }
            do {
                let jsonData = try JSONDecoder().decode(StandingsAPI.self, from: data!)
                DispatchQueue.main.async {
                    self.standingsVariable = jsonData.api.standings
                    self.tableView.reloadData()
                    self.activityIndicator(animated: false)
                }
            }catch {
                print("err:", error)
            }
            
        })

        dataTask.resume()
    }
    
//    func getTeamsInfo(teamId: String) {
//        let headers = [
//            "x-rapidapi-host": "api-nba-v1.p.rapidapi.com",
//            "x-rapidapi-key": "29a89b941dmshb710b982fc842fdp17f010jsne45e8742fe9a"
//        ]
//
//        let request = NSMutableURLRequest(url: NSURL(string: "https://api-nba-v1.p.rapidapi.com/teams/teamId/11")! as URL,
//                                                cachePolicy: .useProtocolCachePolicy,
//                                            timeoutInterval: 10.0)
//        request.httpMethod = "GET"
//        request.allHTTPHeaderFields = headers
//
//        let session = URLSession.shared
//        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
//            if (error != nil) {
//                print(error!)
//            } else {
//                let httpResponse = response as? HTTPURLResponse
//                print(httpResponse!)
//            }
//
//            do {
//                let jsonData = try JSONDecoder().decode(TeamsAPI.self, from: data!)
//                DispatchQueue.main.async {
//                    self.teamVariable = jsonData.api.teams
//
////                    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
////                        guard let cell = tableView.dequeueReusableCell(withIdentifier: "standingCell", for: indexPath) as? StandingsTableViewCell else {return UITableViewCell()}
////
////                        cell.teamShortnameLabel.text = self.teamVariable[indexPath.row].shortName
////                        cell.teamImage.sd_setImage(with: URL(string: self.teamVariable[indexPath.row].logo))
////
////                        return cell
////                    }
//                    self.tableView.reloadData()
//
//                   //print(self.teamVariable)
//                }
//            }catch {
//                print("err:", error)
//            }
//
//        })
//        dataTask.resume()
//    }

}


extension StandingsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 15
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 79
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "standingCell", for: indexPath) as? StandingsTableViewCell else {return UITableViewCell()}
        
        for i in standingsVariable {
            if i.conference.name == "west" && i.conference.rank == String(indexPath.row + 1) {

                //getTeamsInfo(teamId: i.teamId)
    
                cell.positionLabel.text = String(indexPath.row + 1)
                cell.winsLabel.text = i.win
                cell.lossesLabel.text = i.loss
                cell.teamShortnameLabel.text = "teamID: \(i.teamId)"
            }
        }
        
        return cell
    }
    
}
