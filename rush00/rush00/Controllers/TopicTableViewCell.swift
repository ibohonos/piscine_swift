//
//  TopicTableViewCell.swift
//  rush00
//
//  Created by Ivan BOHONOSIUK on 07.10.2018.
//  Copyright © 2018 Ivan BOHONOSIUK. All rights reserved.
//

import UIKit

class TopicTableViewCell: UITableViewCell {
    
    var id_mess : Int!
    var id_topic : Int!
    var token: String!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    
    @IBOutlet weak var editBtn: UIButton!
    @IBOutlet weak var deleteBtn: UIButton!
    
    @IBOutlet weak var messLoginLabel: UILabel!
    @IBOutlet weak var messDateLabel: UILabel!
    @IBOutlet weak var messDescLabel: UILabel!
    
    @IBOutlet weak var messEditBtn: UIButton!
    @IBOutlet weak var messDellBtn: UIButton!
    
    
    @IBAction func editAction(_ sender: Any) {
    }
    
    @IBAction func deleteAction(_ sender: Any) {
        deleteTopic(message: id_topic)
    }
    @IBAction func messEditAction(_ sender: Any) {
        
    }
    @IBAction func messDellAction(_ sender: Any) {
        deleteMessage(message: id_mess)
    }
    
    func deleteMessage(message: Int) {
        let string = "https://api.intra.42.fr/v2/messages/" + String(message);
        let url = URL(string: string.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)
        var request = URLRequest(url: url!);
        request.httpMethod = "DELETE";
        request.setValue("Bearer " + token!, forHTTPHeaderField: "Authorization");
        let group = DispatchGroup();
        let task = URLSession.shared.dataTask(with: request) {
            (data, response, error) in
            
            if let err = error {
                print(err);
            } else if let d = data {
                do {
                    if let dic: [String: Any] = try JSONSerialization.jsonObject(with: d, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String: Any] {
                        print(dic);
                    }
                } catch {
                    print(error.localizedDescription);
                }
            }
            group.leave();
        };
        group.enter();
        task.resume();
        group.wait();
    }
    
    func deleteTopic(message: Int) {
        let string = "https://api.intra.42.fr/v2/topics/\(String(message)).json";
        let url = URL(string: string.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)
        var request = URLRequest(url: url!);
        request.httpMethod = "DELETE";
        request.setValue("Bearer " + token!, forHTTPHeaderField: "Authorization");
        let group = DispatchGroup();
        let task = URLSession.shared.dataTask(with: request) {
            (data, response, error) in
            
            if let err = error {
                print(err);
            } else if let d = data {
                do {
                    if let dic: [String: Any] = try JSONSerialization.jsonObject(with: d, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String: Any] {
                        print(dic);
                    }
                } catch {
                    print(error.localizedDescription);
                }
            }
            group.leave();
        };
        group.enter();
        task.resume();
        group.wait();
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
