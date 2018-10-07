//
//  APIController.swift
//  rush00
//
//  Created by Ivan BOHONOSIUK on 06.10.2018.
//  Copyright © 2018 Ivan BOHONOSIUK. All rights reserved.
//

import Foundation
import UIKit

class APIController {
    let key : String = "2841c23aee32782b087795faf54566bea4eb0388a49e14562ba1976ef98d2bdb"
    let secret : String = "8d38487dc4196ff85713e7eeb1f45c95b8733f4dd735d9795a3a2ed5b3478311"
    
    var token : String = ""
    var id_user : String = ""
    var code: String!
    
    init (code: String = "") {
        if code != "" {
            self.code = code
        }
    }
    
    func getToken() -> String {
        return self.token
    }
    
    func APITokenRequest(window: UIWindow) {
        let BEARER = ((self.key + ":" + self.secret).data(using: String.Encoding.utf8))!.base64EncodedString(options: NSData.Base64EncodingOptions.init(rawValue: 0))
        
        let url = "https://api.intra.42.fr/oauth/token"
        let callbackUrl = "rush00%3A%2F%2Frush00"
        let params: String = "?grant_type=authorization_code&client_id=" + self.key + "&client_secret=" + self.secret + "&code=" + code + "&redirect_uri=" + callbackUrl
        var request = URLRequest(url: (URL(string : url + params)!))
        request.httpMethod = "POST"
        request.setValue("Basic " + BEARER, forHTTPHeaderField: "Authorization")
        request.setValue("application/x-www-form-urlencoded;charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.httpBody = "grant_type=client_credentials".data(using: String.Encoding.utf8)
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if nil != error {
                print(error.debugDescription)
            } else if let d = data {
                do {
                    if let dic: Dictionary = try JSONSerialization.jsonObject(with: d, options: []) as? [String:Any] {
                        self.token = (dic["access_token"] as? String)!
                        self.APIUserRequest(window: window)
                    }
                }
                catch (let err) {
                    print(err)
                }
            }
        }
        task.resume()
    }
    
    func APIUserRequest(window: UIWindow)
    {
        let url = "https://api.intra.42.fr/v2/me?access_token=" + self.token
        var request = URLRequest(url: (URL(string : url)!))
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            (data, response, error) in
            if let err = error {
                print(err)
            }
            else if let d = data {
                do {
                    if let dic: Dictionary = try JSONSerialization.jsonObject(with: d, options: []) as? [String:Any] {
                        self.id_user = String(describing: dic["id"]!)
                        DispatchQueue.main.async {
                            let ms: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                            let page: StartNavigationController = ms.instantiateViewController(withIdentifier: "isLogginned") as! StartNavigationController
                            window.rootViewController = page
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
}
