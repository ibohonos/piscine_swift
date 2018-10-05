//
//  ViewController.swift
//  d04
//
//  Created by Ivan BOHONOSIUK on 05.10.2018.
//  Copyright © 2018 Ivan BOHONOSIUK. All rights reserved.
//

import UIKit

//class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, APITwitterDelegate, UISearchBarDelegate {

//    @IBOutlet weak var myTable: UITableView!
//
//    var allTweets : [tweetData] = []
//
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // Do any additional setup after loading the view, typically from a nib.
//        print("view")
//        let CUSTUMER_KEY = "lo0j5t40X6nt8Wj3YBzg"
//        let CUSTUMER_SECRET = "39PPCILZq7aDCaA2eN8wRp6v9uIllYBaANLLtA1sPlY"
//        let BEARER = ((CUSTUMER_KEY + ":" + CUSTUMER_SECRET).data(using: String.Encoding.utf8))!.base64EncodedString(options: NSData.Base64EncodingOptions.init(rawValue: 0))
//
//        let url = URL(string: "https://api.twitter.com/oauth2/token")
//        var request = URLRequest(url: url! as URL)
//        request.httpMethod = "POST"
//        request.setValue("Basic " + BEARER, forHTTPHeaderField: "Authorization")
//        request.setValue("application/x-www-form-urlencoded;charset=UTF-8", forHTTPHeaderField: "Content-Type")
//        request.httpBody = "grant_type=client_credentials".data(using: String.Encoding.utf8)
//
//        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
//            if nil != error {
//                print(error.debugDescription)
//            } else if let d = data {
//                do {
//                    let dic: Dictionary = try JSONSerialization.jsonObject(with: d, options: []) as! [String:Any]
//                    let req = APIController(na: self, t: (dic["access_token"] as? String)!)
//                    req.queryRequest(dict: "school 42")
//                }
//                catch (let err) {
//                    print(err)
//                }
//            }
//        }
//        task.resume()
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        print("table cell")
//        return allTweets.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        tableView.rowHeight = UITableViewAutomaticDimension
//        tableView.estimatedRowHeight = 150
//        tableView.separatorColor = UIColor.black
//        tableView.contentInset = UIEdgeInsets.zero
//
//        let cell = tableView.dequeueReusableCell(withIdentifier: "tweetCell", for: indexPath) as! TweetTableViewCell
//        cell.nameLabel?.text = allTweets[indexPath.row].name
//        cell.dateLabel?.text = allTweets[indexPath.row].date
//        cell.descLabel?.text = allTweets[indexPath.row].text
//        //cell.testLabel?.text = allTweets[indexPath.row].description
//        cell.backgroundColor = UIColor.white
//        cell.layer.borderWidth = 2.5
//
//        return cell
//    }
//
//    func threatTheTweets(name: [tweetData]) {
////        DispatchQueue.main.async {
////            self.allTweets = name
////            self.myTable.reloadData()
////        }
//    }
//
//    func error(er: NSError) {
//        print(er)
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//

//}

