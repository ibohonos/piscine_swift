//
//  TopicTableViewController.swift
//  rush00
//
//  Created by Ivan BOHONOSIUK on 07.10.2018.
//  Copyright © 2018 Ivan BOHONOSIUK. All rights reserved.
//

import UIKit

class TopicTableViewController: UITableViewController{

    var topic: Topics!
    var id_user: String!
    var token: String!
    var id_topic: String!
    var id_mess: String!
    var title_mess: String!
    var messages: [Messages] = []
    var rep_tab: [Messages]!
    
    @IBOutlet var messTable: UITableView!
    @IBOutlet var myTopicTable: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.APIMessagesRequest(token: self.token, id: String(self.topic.id))

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
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.messages.count + 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "topicInnerCell", for: indexPath) as! TopicTableViewCell
            
            cell.loginLabel.text = topic.name
            cell.dateLabel.text = topic.date
            cell.descLabel.text = topic.text
            cell.token = self.token
            cell.id_topic = topic.id
            
            if String(topic.user_id) != self.id_user {
                cell.editBtn.isHidden = true
                cell.deleteBtn.isHidden = true
            }
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "messagesCell", for: indexPath) as! TopicTableViewCell
            
            cell.messLoginLabel.text = messages[indexPath.row - 1].name
            cell.messDateLabel.text = messages[indexPath.row - 1].date
            cell.messDescLabel.text = messages[indexPath.row - 1].text
            cell.id_mess = messages[indexPath.row - 1].id
            
            if messages[indexPath.row - 1].user_id != self.id_user {
                cell.messDellBtn.isHidden = true
                cell.messEditBtn.isHidden = true
            }
            
            return cell
        }
        // Configure the cell...

        
    }
    
    
    func APIMessagesRequest(token: String, id: String) {
        
        let url = "https://api.intra.42.fr/v2/topics/" + id + "/messages?page=1&per_page=100&access_token=" + token
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
                        //print(json)
                        for mess in json {
                            let id: Int! = mess["id"] as! Int
                            let user = mess["author"]! as! NSDictionary
                            let name: String! = user["login"] as! String
                            let user_id: String! = String(describing: user["id"]!)
                            let date: String! =  mess["created_at"] as! String
                            let dateFormatter = DateFormatter()
                            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
                            let date2 = dateFormatter.date(from: date!)
                            dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
                            let newDate = dateFormatter.string(from: date2!)
                            let text = mess["content"] as! String
                            let replies_tab = mess["replies"] as! NSArray
                            var rep: [Messages] = []
                            for reply in replies_tab {
                                if let repl = reply as? NSDictionary {
                                    let id_rep: Int! = repl["id"] as! Int
                                    let user_rep = repl["author"]! as! NSDictionary
                                    let name_rep: String! = user_rep["login"] as! String
                                    let date_rep: String! =  repl["created_at"] as! String
                                    let dateFormatter_rep = DateFormatter()
                                    dateFormatter_rep.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
                                    let date2_rep = dateFormatter_rep.date(from: date_rep!)
                                    dateFormatter_rep.dateFormat = "dd.MM.yyyy HH:mm"
                                    let newDate_rep = dateFormatter_rep.string(from: date2_rep!)
                                    let text_rep = repl["content"] as! String
                                    rep.append(Messages(id: id_rep, name: name_rep, user_id: user_id, date: newDate_rep, text: text_rep, topic_id: self.id_topic, replies: []))
                                }
                            }
                            self.messages.append(Messages(id: id, name: name, user_id: user_id, date: newDate, text: text, topic_id: self.id_topic, replies: rep))
                        }
                        
                        DispatchQueue.main.async {
                            print(self.messages)
                            self.messTable.reloadData()
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
