//
//  ViewController.swift
//  NBAconcept
//
//  Created by Arturs Ziemelis on 22/11/2021.
//

import UIKit
import SDWebImage

class GamesViewController: UIViewController {
    
    var gamesVariable: [Game] = []
    
    @IBOutlet weak var TableView: UITableView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       // #warning("fix the date")
        let Date = Date()
        let formatter = DateFormatter()
        
        formatter.timeZone = .current
        formatter.locale = .current
        formatter.dateFormat = "EEEE, MMM d, yyyy"
        
        dateLabel.text = formatter.string(from: Date)
        
        formatter.dateFormat = "yyyy-MM-dd"
        //let date = formatter.string(from: Date)
        getNBAdata()
        
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
    
    @IBAction func calendarBarButtonTapped(_ sender: UIBarButtonItem) {
        
    }
    
    func calendar() {
        let Date = Date()
        let formatter = DateFormatter()
        
        formatter.timeZone = .current
        formatter.locale = .current
        formatter.dateFormat = "EEEE, MMM d, yyyy"
        
        dateLabel.text = formatter.string(from: Date)
    }
    
    func getNBAdata () {
        activityIndicator(animated: true)
        let headers = [
            "x-rapidapi-host": "api-nba-v1.p.rapidapi.com",
            "x-rapidapi-key": "29a89b941dmshb710b982fc842fdp17f010jsne45e8742fe9a"
        ]

        let request = NSMutableURLRequest(url: NSURL(string: "https://api-nba-v1.p.rapidapi.com/games/date/2021-11-24")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error!)
            } else {
                let httpResponse = response as? HTTPURLResponse
                print(httpResponse!)
            }
            
            guard let data = data else {
                    return
                }
            
            do {
                let jsonData = try JSONDecoder().decode(API.self, from: data)
                DispatchQueue.main.async {
                    self.gamesVariable = jsonData.api.games
                    print(self.gamesVariable)
                    self.TableView.reloadData()
                    self.activityIndicator(animated: false)
                }
            }catch {
                print("err:", error)
            }
        })
        dataTask.resume()
    }
    
}

extension GamesViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gamesVariable.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat  {
        return 240
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "gameCell", for: indexPath) as? GameTableViewCell else {return UITableViewCell()}
        
        let game = gamesVariable[indexPath.row]
        cell.homeTeamLabel.text = game.hTeam.nickName
        cell.awayTeamLabel.text = game.vTeam.nickName
        
        cell.homeTeamImage.sd_setImage(with: URL(string: game.hTeam.logo), placeholderImage: UIImage(named: "team.png"))
        cell.awayTeamImage.sd_setImage(with: URL(string: game.vTeam.logo), placeholderImage: UIImage(named: "team.png"))
        
        cell.resultLabel.text = "\(game.hTeam.score.points):\(game.vTeam.score.points)"
        
        return cell
    
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storybaord = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        guard let vc = storybaord.instantiateViewController(withIdentifier: "GameDetailViewController") as? GameDetailViewController else {return}
        
        let item = gamesVariable[indexPath.row]
        
        vc.gameId = item.gameId
        
        vc.awayTeamLogo = item.vTeam.logo
        vc.awayTeamFullName = item.vTeam.fullName
        vc.awayTeamPoints = item.vTeam.score.points
        
        vc.homeTeamLogo = item.hTeam.logo
        vc.homeTeamFullName = item.hTeam.fullName
        vc.homeTeamPoints = item.hTeam.score.points
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
}

