//
//  WebViewController.swift
//  NBAconcept
//
//  Created by Arturs Ziemelis on 24/11/2021.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKNavigationDelegate  {

    var urlString = String()
    @IBOutlet weak var WebView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Web"
        guard let url = URL(string: urlString) else {return}
        
        WebView.load(URLRequest(url: url))
        
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("didFinish navigation")
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("didStartProvisionNavigation")
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
