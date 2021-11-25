//
//  StandingsViewController.swift
//  NBAconcept
//
//  Created by Arturs Ziemelis on 24/11/2021.
//

import UIKit

class StandingsViewController: UIViewController {
    
    var standingsVariable: [Standings] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        getNBAstandingsData(year: "2021")
        // Do any additional setup after loading the view.
    }

    func getNBAstandingsData(year: String) {
        let headers = [
            "x-rapidapi-host": "api-nba-v1.p.rapidapi.com",
            "x-rapidapi-key": "29a89b941dmshb710b982fc842fdp17f010jsne45e8742fe9a"
        ]

        let request = NSMutableURLRequest(url: NSURL(string: "https://api-nba-v1.p.rapidapi.com/standings/standard/\(year)")! as URL,
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
            do {
                let jsonData = try JSONDecoder().decode(StandingsAPI.self, from: data!)
                DispatchQueue.main.async {
                    self.standingsVariable = jsonData.api.standings
                    print(self.standingsVariable)
//                    self.TableView.reloadData()
//                    self.activityIndicator(animated: false)
                }
            }catch {
                print("err:", error)
            }
            
        })

        dataTask.resume()
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension StandingsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 15
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "standingCell", for: indexPath) as? StandingsTableViewCell else {return UITableViewCell()}
        
        
        return cell
    }
    
}
