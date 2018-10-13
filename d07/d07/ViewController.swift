//
//  ViewController.swift
//  d07
//
//  Created by Ivan BOHONOSIUK on 10/10/18.
//  Copyright © 2018 Ivan BOHONOSIUK. All rights reserved.
//

import UIKit
import RecastAI
import ForecastIO

class ViewController: UIViewController {

    var bot : RecastAIClient?
    let client = DarkSkyClient(apiKey: "56d2fbac80a695c25785aa61dd767d6a")
    
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var questionText: UITextField!
    
    @IBAction func sendRequest(_ sender: Any) {
        if questionText.text != nil && questionText.text?.trimmingCharacters(in: .whitespacesAndNewlines) != "" {
            self.bot?.textRequest(questionText.text!, successHandler: { (resp) in
                if resp.intents?.count != 0 {
                    if resp.intent()?.slug == "get-weather" {
                        if let ret = resp.get(entity: "location") as NSDictionary? {
                            if ret["lat"] != nil && ret["lng"] != nil {
                                self.answerLabel.text = String(describing: ret["formatted"]!)
                                self.askDarkSky(lat: ret.value(forKey: "lat") as! Double, lng: ret.value(forKey: "lng") as! Double)
                            }
                        } else {
                            self.answerLabel.text = "Sory. Uknown city. Try again"
                            self.questionText.text = ""
                        }
                    }
                } else {
                    self.answerLabel.text = "Error. Please enter City"
                }
            }, failureHandle: { (err) in
                print(err)
            })
        } else {
            self.answerLabel.text = "Error. Please enter question"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.bot = RecastAIClient(token : "ab76b47336e8b32971a23c1149d43888")
        client.language = .english
        client.units = .si
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func askDarkSky(lat: Double, lng: Double) {
        client.getForecast(latitude: lat, longitude: lng) { result in
            switch result {
            case .success(let currentForecast, let requestMetadata):
                print(requestMetadata)
                DispatchQueue.main.async {
                    self.answerLabel.text = "\(self.answerLabel.text!)\n\(currentForecast.daily!.summary!)"
                    self.questionText.text = ""
                }
            case .failure(let error):
                print(error)
                DispatchQueue.main.async {
                    self.answerLabel.text = "Error: error from Dark Sky"
                }
            }
        }
    }


}

