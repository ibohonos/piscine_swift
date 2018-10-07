//
//  Messeges.swift
//  rush00
//
//  Created by Ivan BOHONOSIUK on 07.10.2018.
//  Copyright © 2018 Ivan BOHONOSIUK. All rights reserved.
//

import Foundation

struct Messages: CustomStringConvertible {
    let id: Int?
    let name: String?
    let user_id: String?
    let date: String?
    let text: String?
    let topic_id: String?
    let replies: [Messages]?
    
    var description: String {
        return "\(String(describing: id)), \(String(describing: name)), \(String(describing: date)), \n\(String(describing: text)), \n\(String(describing: replies))"
    }
    
    func sendRequest(_ type: String) {
        var method: String
        var path: String
        let token: String = Global(0)
        let userid: String = Global(1)
        
        switch type {
        case "create":
            method = "POST"
            path = "https://api.intra.42.fr/v2/topics/\(String(describing: topic_id))/messages.json"
        case "mod":
            method = "PUT"
            path = "https://api.intra.42.fr/v2/messages/\(String(describing: self.id)).json"
        case "del":
            method = "DELETE"
            path = "https://api.intra.42.fr/v2/messages/\(String(describing: self.id)).json"
        default:
            return
        }
        if let url = URL(string: path) {
            var request = URLRequest(url: url)
            let json: [String: Any] = ["message":["author_id": userid, "content": text]]
            request.httpMethod = method
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            let jsonData = try? JSONSerialization.data(withJSONObject: json)
            request.httpBody = jsonData
            postTopic(request as URLRequest)
        } else {
            print("url == nil!")
        }
    }
    
}
