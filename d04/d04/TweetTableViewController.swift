//
//  TweetTableViewController.swift
//  d04
//
//  Created by Ivan BOHONOSIUK on 05.10.2018.
//  Copyright © 2018 Ivan BOHONOSIUK. All rights reserved.
//

import UIKit

class TweetTableViewController: UITableViewController, APITwitterDelegate {

    @IBOutlet weak var myTable: UITableView!
    
    var allTweets : [tweetData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        let CUSTUMER_KEY = "lo0j5t40X6nt8Wj3YBzg"
        let CUSTUMER_SECRET = "39PPCILZq7aDCaA2eN8wRp6v9uIllYBaANLLtA1sPlY"
        let BEARER = ((CUSTUMER_KEY + ":" + CUSTUMER_SECRET).data(using: String.Encoding.utf8))!.base64EncodedString(options: NSData.Base64EncodingOptions.init(rawValue: 0))
        
        let url = URL(string: "https://api.twitter.com/oauth2/token")
        var request = URLRequest(url: url! as URL)
        request.httpMethod = "POST"
        request.setValue("Basic " + BEARER, forHTTPHeaderField: "Authorization")
        request.setValue("application/x-www-form-urlencoded;charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.httpBody = "grant_type=client_credentials".data(using: String.Encoding.utf8)
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if nil != error {
                print(error.debugDescription)
            } else if let d = data {
                do {
                    let dic: Dictionary = try JSONSerialization.jsonObject(with: d, options: []) as! [String:Any]
                    let req = APIController(na: self, t: (dic["access_token"] as? String)!)
                    req.queryRequest(dict: "school 42")
                }
                catch (let err) {
                    print(err)
                }
            }
        }
        task.resume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        if allTweets.count == 0 {
            return 0
        } else {
            return 1
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return allTweets.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tweetCell", for: indexPath) as! TweetTableViewCell

        // Configure the cell...
        cell.nameLabel?.text = allTweets[indexPath.row].name
        cell.dateLabel?.text = allTweets[indexPath.row].date
        cell.descLabel?.text = allTweets[indexPath.row].text
        //cell.testLabel?.text = allTweets[indexPath.row].description
        cell.backgroundColor = UIColor.white
        cell.layer.borderWidth = 2.5
        
        myTable.rowHeight = UITableViewAutomaticDimension
        myTable.estimatedRowHeight = 150
        myTable.separatorColor = UIColor.black
        myTable.contentInset = UIEdgeInsets.zero

//        myTable.rowHeight = UITableViewAutomaticDimension
//        myTable.estimatedRowHeight = 150.0
        
        return cell
    }
    
    func threatTheTweets(name: [tweetData]) {
        DispatchQueue.main.async {
            self.allTweets = name
            self.myTable.reloadData()
        }
    }
    
    func error(er: NSError) {
        print(er)
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
