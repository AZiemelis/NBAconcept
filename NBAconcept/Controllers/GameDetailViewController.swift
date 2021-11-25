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
    
    @IBOutlet weak var pointsLabel: UILabel!
    @IBOutlet weak var reboundsLabel: UILabel!
    @IBOutlet weak var assistsLabel: UILabel!
    
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    @IBOutlet weak var homeTeamImage: UIImageView!
    @IBOutlet weak var awayTeamImage: UIImageView!
    @IBOutlet weak var homeTeamLabel: UILabel!
    @IBOutlet weak var awayTeamLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
        
    //Team Names
    @IBOutlet weak var homePlayerNameLabelPoints: UILabel!
    @IBOutlet weak var homePlayerNameLabelRebounds: UILabel!
    @IBOutlet weak var homePlayerNameLabelAssists: UILabel!

    @IBOutlet weak var awayPlayerNameLabelPoints: UILabel!
    @IBOutlet weak var awayPlayerNameLabelRebounds: UILabel!
    @IBOutlet weak var awayPlayerNameLabelAssists: UILabel!
    
    //Team Leaders
    @IBOutlet weak var awayPlayerPointsLabel: UILabel!
    @IBOutlet weak var awayPlayerReboundsLabel: UILabel!
    @IBOutlet weak var awayPlayerAssistsLabel: UILabel!
    
    @IBOutlet weak var homePlayerPointsLabel: UILabel!
    @IBOutlet weak var homePlayerReboundsLabel: UILabel!
    @IBOutlet weak var homePlayerAssistsLabel: UILabel!
    
    @IBOutlet weak var backgroundImageView1: UIImageView!
    @IBOutlet weak var backgroundImageView0: UIImageView!
    @IBOutlet weak var backgroundImageView2: UIImageView!
    @IBOutlet weak var backgroundImageView3: UIImageView!
    
    var context: NSManagedObjectContext?
    var gameId = String()
    var fullScore = String()
    
    var awayTeamLogo = String()
    var awayTeamFullName = String()
    var awayTeamPoints = String()
    var awayTeamShortName = String()
    
    var homeTeamLogo = String()
    var homeTeamFullName = String()
    var homeTeamPoints = String()
    var homeTeamShortName = String()
    
    var teamShortNameForUrl: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        getNBADetailData(gameID: gameId)
        
        backgroundImageView0.layer.cornerRadius = 20
        backgroundImageView1.layer.cornerRadius = 20
        backgroundImageView2.layer.cornerRadius = 20
        backgroundImageView3.layer.cornerRadius = 20
        
        print(gameId)
        homeTeamImage.sd_setImage(with: URL(string: homeTeamLogo), placeholderImage: UIImage(named: "team.png"))
        
        awayTeamImage.sd_setImage(with: URL(string: awayTeamLogo), placeholderImage: UIImage(named: "team.png"))
        
        awayTeamLabel.text = awayTeamFullName
        homeTeamLabel.text = homeTeamFullName
        
        resultLabel.text = fullScore
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        context = appDelegate.persistentContainer.viewContext
        
    }
    
    override open var shouldAutorotate: Bool {
        return false
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
    
    func getNBADetailData (gameID: String) {
        
        pointsLabel.text = ""
        reboundsLabel.text = ""
        assistsLabel.text = ""
        
        homePlayerNameLabelPoints.text = ""
        homePlayerPointsLabel.text = ""
        homePlayerNameLabelRebounds.text = ""
        homePlayerReboundsLabel.text = ""
        homePlayerNameLabelAssists.text = ""
        homePlayerAssistsLabel.text = ""
        
        awayPlayerNameLabelPoints.text = ""
        awayPlayerPointsLabel.text = ""
        awayPlayerNameLabelRebounds.text = ""
        awayPlayerReboundsLabel.text = ""
        awayPlayerNameLabelAssists.text = ""
        awayPlayerAssistsLabel.text = ""
        
        activityIndicator(animated: true)
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
        
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
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
                    
                   // print(self.gameDetail)
                    
                    var homePlayerMaxPoints: Int = 0
                    var homePlayerMaxAssists: Int = 0
                    var homePlayerMaxRebounds: Int = 0
                    
                    var awayPlayerMaxPoints: Int = 0
                    var awayPlayerMaxAssists: Int = 0
                    var awayPlayerMaxRebounds: Int = 0
                    
                    for i in self.gameDetail {
                        for j in i.hTeam.leaders {
                            if j.points != nil {
                                if Int(j.points!)! >= homePlayerMaxPoints {
                                    homePlayerMaxPoints = Int(j.points!)!
                                    self.homePlayerNameLabelPoints.text = j.name
                                    self.homePlayerPointsLabel.text = String(homePlayerMaxPoints)


                                }
                            }else if j.rebounds != nil {
                                if Int(j.rebounds!)! >= homePlayerMaxRebounds {
                                    homePlayerMaxRebounds = Int(j.rebounds!)!
                                    self.homePlayerNameLabelRebounds.text = j.name
                                    self.homePlayerReboundsLabel.text = String(homePlayerMaxRebounds)
            
                                }
                            }else if j.assists != nil {
                                if Int(j.assists!)! >= homePlayerMaxAssists {
                                    homePlayerMaxAssists = Int(j.assists!)!
                                    self.homePlayerNameLabelAssists.text = j.name
                                    self.homePlayerAssistsLabel.text = String(homePlayerMaxAssists)
                                    
                   
                                }
                            }
                        }
                    }
                    
                    for i in self.gameDetail {
                        for j in i.vTeam.leaders {
                            if j.points != nil {
                                if Int(j.points!)! >= awayPlayerMaxPoints {
                                    awayPlayerMaxPoints = Int(j.points!)!
                                    self.awayPlayerNameLabelPoints.text = j.name
                                    self.awayPlayerPointsLabel.text = String(awayPlayerMaxPoints)


          
                                }
                            }else if j.rebounds != nil {
                                if Int(j.rebounds!)! >= awayPlayerMaxRebounds {
                                    awayPlayerMaxRebounds = Int(j.rebounds!)!
                                    self.awayPlayerNameLabelRebounds.text = j.name
                                    self.awayPlayerReboundsLabel.text = String(awayPlayerMaxRebounds)
                                    

                                }
                            }else if j.assists != nil {
                                if Int(j.assists!)! >= awayPlayerMaxAssists {
                                    awayPlayerMaxAssists = Int(j.assists!)!
                                    self.awayPlayerNameLabelAssists.text = j.name
                                    self.awayPlayerAssistsLabel.text = String(awayPlayerMaxAssists)
                                    
        
                                }
                            }
                        }
                    }
                    self.pointsLabel.text = "Points"
                    self.reboundsLabel.text = "Rebounds"
                    self.assistsLabel.text = "Assists"
                    self.activityIndicator(animated: false)
                }
            }catch {
                print("err:", error)
            }
        })
        dataTask.resume()
        

        
    }
    
    
    @IBAction func awayButtonPressed(_ sender: UIButton) {
        self.teamShortNameForUrl = awayTeamShortName
        
    }
    
    @IBAction func homeButtonPressed(_ sender: UIButton) {
        self.teamShortNameForUrl = homeTeamShortName
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
        let fullUrl = "https://www.espn.com/nba/team/_/name/\(teamShortNameForUrl)/"
        guard let destinationVC: WebViewController = segue.destination as? WebViewController else {return}
        
        destinationVC.urlString = fullUrl
    }
    
}


