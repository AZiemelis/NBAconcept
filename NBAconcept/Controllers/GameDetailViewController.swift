//
//  GameDetailViewController.swift
//  NBAconcept
//
//  Created by Arturs Ziemelis on 24/11/2021.
//

// Uztaisiit for ciklu kur izskata un izvelk max vertibu (punkti, assisti, reboundi)


import UIKit
import SDWebImage
import CoreData

class GameDetailViewController: UIViewController {

    var gameDetail: [GameDetail] = []
    
    @IBOutlet weak var homeTeamImage: UIImageView!
    @IBOutlet weak var awayTeamImage: UIImageView!
    @IBOutlet weak var homeTeamLabel: UILabel!
    @IBOutlet weak var awayTeamLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var playerNameLabel: UILabel!
    @IBOutlet weak var playerProfileImage: UIImageView!
    
    var context: NSManagedObjectContext?
    var gameId = String()
    
    var awayTeamLogo = String()
    var awayTeamFullName = String()
    var awayTeamPoints = String()
    
    var homeTeamLogo = String()
    var homeTeamFullName = String()
    var homeTeamPoints = String()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getNBADetailData(gameID: gameId)
        
        homeTeamImage.sd_setImage(with: URL(string: homeTeamLogo), placeholderImage: UIImage(named: "team.png"))
        
        awayTeamImage.sd_setImage(with: URL(string: awayTeamLogo), placeholderImage: UIImage(named: "team.png"))
        
        awayTeamLabel.text = awayTeamFullName
        homeTeamLabel.text = homeTeamFullName
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        context = appDelegate.persistentContainer.viewContext
        
    }
    
    
    
    func getNBADetailData (gameID: String) {
        let headers = [
            "x-rapidapi-host": "api-nba-v1.p.rapidapi.com",
            "x-rapidapi-key": "29a89b941dmshb710b982fc842fdp17f010jsne45e8742fe9a"
        ]

        let request = NSMutableURLRequest(url: NSURL(string: "https://api-nba-v1.p.rapidapi.com/gameDetails/\(gameID)")! as URL,
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
                let jsonData = try JSONDecoder().decode(GameDetailAPI.self, from: data)
                DispatchQueue.main.async {
                    self.gameDetail = jsonData.api.game
                    print(self.gameDetail)
              
                   
                }
            }catch {
                print("err:", error)
            }
        })
        dataTask.resume()
    }
    // if statement ja poga tiek uzspiesta
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let teamShortNameForUrl = "LAL"
        
        let fullUrl = "https://www.espn.com/nba/team/_/name/\(teamShortNameForUrl)/"
        guard let destinationVC: WebViewController = segue.destination as? WebViewController else {return}
        
        print(sender!)
        
        destinationVC.urlString = fullUrl
    }
    
}


