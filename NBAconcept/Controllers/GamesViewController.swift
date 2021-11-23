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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        #warning("fix the date")
        let Date = Date()
        let formatter = DateFormatter()
        
        formatter.timeZone = .current
        formatter.locale = .current
        formatter.dateFormat = "EEEE, MMM d, yyyy"
        
        dateLabel.text = formatter.string(from: Date)
        
        formatter.dateFormat = "yyyy-MM-dd"
        //let date = formatter.string(from: Date)
        getNBAdata(date: "2021-11-21")
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
    
    func getNBAdata (date: String) {

        let headers = [
            "x-rapidapi-host": "api-nba-v1.p.rapidapi.com",
            "x-rapidapi-key": "29a89b941dmshb710b982fc842fdp17f010jsne45e8742fe9a"
        ]

        var request = URLRequest(url: URL(string: "https://api-nba-v1.p.rapidapi.com/games/date/2021-11-21")!)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        URLSession.shared.dataTask(with: request) { data, response, err in
            if err != nil {
                print(err?.localizedDescription)
            }else {
                print(response)
            }
            if let data = data {
                if let json = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
                    as? [String: Any]
                {
                    print(json)
                }
            }
            do {
                let jsonData = try JSONDecoder().decode(gameCard.self, from: data!)
                self.gamesVariable = jsonData.api.games
                DispatchQueue.main.async {
                    print("self.Game: ", self.gamesVariable)
                    self.TableView.reloadData()
                }
            }catch {
                //print("THERE IS THE REQUEST!: ",request)
                print("err:", error)
            }
            
            
            
            
            
        }.resume()
        
            

            
     
    }
    
}

extension GamesViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gamesVariable.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat  {
        return 300
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "gameCell", for: indexPath) as? GameTableViewCell else {return UITableViewCell()}
        
        let game = gamesVariable[indexPath.row]
        cell.homeTeamLabel.text = game.arena
        cell.awayTeamLabel.text = game.arena
        
       // cell.homeTeamImage.sd_setImage(with: URL(string: game.arena), placeholderImage: UIImage(named: "team.png"))
        
        
        return cell
    
    }
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
//        guard let vc = storyboard.instantiateInitialViewController(withIdentifier: )
//    }
//
//
    
    
}

