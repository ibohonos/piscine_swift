//
//  TopicsTableViewController.swift
//  rush00
//
//  Created by Ivan BOHONOSIUK on 07.10.2018.
//  Copyright © 2018 Ivan BOHONOSIUK. All rights reserved.
//

import UIKit

class TopicsTableViewController: UITableViewController {

    var token: String!
    var user_id: String!
    var topics: [Topics] = []
    var apic: APIController?
    
    @IBOutlet var topicsT: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDeleg = UIApplication.shared.delegate as! AppDelegate
        apic = appDeleg.apic
        self.token = apic?.token
        self.user_id = apic?.id_user
        print("Token: \(self.token!) id: \(self.user_id)")
        APITopicsRequest(token: self.token)
        
//        topicsT.rowHeight = UITableViewAutomaticDimension
//        topicsT.estimatedRowHeight = 140
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        if self.topics.count > 0 {
            return 1
        }
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.topics.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "topicCell", for: indexPath) as! TopicsTableViewCell

        // Configure the cell...
        print(self.topics[indexPath.row].text)
        cell.nameLabel.text = self.topics[indexPath.row].name
        cell.dateLabel.text = self.topics[indexPath.row].date
        cell.descTextLabel.text = self.topics[indexPath.row].text
        
//        if topics[indexPath.row].user_id == user_id {
//            cell.bt_edit.isEnabled = true
//        } else {
//            cell.bt_edit.isEnabled = false
//        }

        return cell
    }
    
    
    func APITopicsRequest(token: String) {
        
        let url = "https://api.intra.42.fr/v2/topics?page=1&per_page=100&access_token=" + token
        let request = NSMutableURLRequest(url: (URL(string : url) as! URL))
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            (data, response, error) in
            if let err = error {
                print(err)
            }
            else if let d = data {
                do {
                    if let json = try? JSONSerialization.jsonObject(with: d, options: []) as! [NSDictionary] {
                        for forum in json {
                            let id: Int! = forum["id"] as! Int
                            let topics_name: String! = forum["name"] as! String
                            let user = forum["author"]! as! NSDictionary
                            let name: String! = user["login"] as! String
                            let user_id: String! = String(describing: user["id"]!)
                            let date: String! =  forum["created_at"] as! String
                            let dateFormatter = DateFormatter()
                            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
                            let date2 = dateFormatter.date(from: date!)
                            dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
                            let newDate = dateFormatter.string(from: date2!)
                            self.topics.append(Topics(id: id, name: name, user_id: user_id, date: newDate, text: topics_name, content: ""))
                        }
                        DispatchQueue.main.async {
                            self.user_id = self.apic?.id_user
                            self.topicsT.reloadData()
                        }
                    }
                }
                catch (let err) {
                    print(err)
                }
            }
        }
        task.resume()
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
