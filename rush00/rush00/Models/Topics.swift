//
//  Topics.swift
//  rush00
//
//  Created by Ivan BOHONOSIUK on 07.10.2018.
//  Copyright © 2018 Ivan BOHONOSIUK. All rights reserved.
//

import Foundation
import UIKit

struct Topics: CustomStringConvertible {
    let id: Int
    let name: String
    let user_id: String
    let date: String
    let text: String
    let kind: String = "normal"
    let language_id: Int = 1
    let content: String
    
    var description: String {
        return "\(id), \(name), \(date), \(text)\n"
    }
    
    func sendRequest(_ type: String) {
        var method: String
        var path: String
        let token: String = Global(0)
        let userid: String = Global(1)
        
        switch type {
        case "create":
            method = "POST"
            path = "https://api.intra.42.fr/v2/topics.json"
        case "mod":
            method = "PUT"
            path = "https://api.intra.42.fr/v2/topics/\(self.id).json"
        case "del":
            method = "DELETE"
            path = "https://api.intra.42.fr/v2/topics/\(self.id).json"
        default:
            return
        }
        if let url = URL(string: path) {
            var request = URLRequest(url: url)
            let json: [String: Any] = ["topic":["kind": "normal", "cursus_ids": ["1"], "language_id": "1", "messages_attributes": [["author_id": userid, "content": content]], "name": name, "tag_ids": ["578"]]]
            request.httpMethod = method
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            let jsonData = try? JSONSerialization.data(withJSONObject: json)
            let string1 = String(data: jsonData!, encoding: String.Encoding.utf8) ?? "Data could not be printed"
            print("JSON = \(string1)")
            request.httpBody = jsonData
            postTopic(request as URLRequest)
        } else {
            print("url == nil!")
        }
    }
    
}

func postTopic(_ request: URLRequest) {
    let task = URLSession.shared.dataTask(with: request) {
        (data, response, error) in
        if let err = error {
            print(err)
        }
        if let rep = response as? HTTPURLResponse {
            if rep.statusCode > 300 {
                let alertController = UIAlertController(title: "Error", message: "Cannot create topic", preferredStyle: .alert)
                let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alertController.addAction(alertAction)
                let rootController = UIApplication.shared.delegate?.window??.rootViewController
                rootController?.present(alertController, animated: true, completion: nil)
                return
            }
            else {
                do {
                    if let json = try? JSONSerialization.jsonObject(with: data!) as! NSDictionary {
                        print("post topic: \(json)")
                    }
                }
                catch (let err) {
                    print(err)
                }
            }
        }
    }
    task.resume()
}
