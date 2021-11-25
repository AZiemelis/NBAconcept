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
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var dateTextField: UITextField!
    let datePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        let date = Date()
        let formatter = DateFormatter()
        
        formatter.timeZone = .current
        formatter.locale = .current
        formatter.dateFormat = "EEEE, MMM d, yyyy"
        let stringDateTextField: String = formatter.string(from: date)
        dateTextField.text = stringDateTextField
        
        
        formatter.dateFormat = "yyyy-MM-dd"
        let stringDateGamesData: String = formatter.string(from: date)
        createDatePicker()

        getNBAdata(gamesDate: stringDateGamesData)
        
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
    
    func createDatePicker() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([doneBtn], animated: true)
        
        dateTextField.inputAccessoryView = toolbar
        dateTextField.inputView = datePicker
        
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.sizeToFit()
    }
    
    @objc func donePressed() {
        
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        formatter.dateFormat = "EEEE, MMM d, yyyy"
        dateTextField.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
        
        formatter.dateFormat = "yyyy-MM-dd"
        let dateInput = formatter.string(for: datePicker.date)
        
        getNBAdata(gamesDate: dateInput!)
    }

    
    @IBAction func refreshButtonTapped(_ sender: UIBarButtonItem) {
        viewDidLoad()
    }
    
    
    
    func getNBAdata (gamesDate: String) {
        activityIndicator(animated: true)
        let headers = [
            "x-rapidapi-host": "api-nba-v1.p.rapidapi.com",
            "x-rapidapi-key": "29a89b941dmshb710b982fc842fdp17f010jsne45e8742fe9a"
        ]

        let request = NSMutableURLRequest(url: NSURL(string: "https://api-nba-v1.p.rapidapi.com/games/date/\(gamesDate)")! as URL,
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
        return 130
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "gameCell", for: indexPath) as? GameTableViewCell else {return UITableViewCell()}
        
        let game = gamesVariable[indexPath.row]
        cell.homeTeamLabel.text = game.hTeam.nickName
        cell.awayTeamLabel.text = game.vTeam.nickName
        
        cell.homeTeamImage.sd_setImage(with: URL(string: game.hTeam.logo), placeholderImage: UIImage(named: "team.png"))
        cell.awayTeamImage.sd_setImage(with: URL(string: game.vTeam.logo), placeholderImage: UIImage(named: "team.png"))
        
        cell.resultLabel.text = "\(game.vTeam.score.points):\(game.hTeam.score.points)"
        
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
        vc.awayTeamShortName = item.vTeam.shortName
        
        vc.homeTeamLogo = item.hTeam.logo
        vc.homeTeamFullName = item.hTeam.fullName
        vc.homeTeamPoints = item.hTeam.score.points
        vc.homeTeamShortName = item.hTeam.shortName
        vc.fullScore = "\(item.vTeam.score.points):\(item.hTeam.score.points)"
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
}

