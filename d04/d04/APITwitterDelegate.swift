//
//  APITwitterDelegate.swift
//  d04
//
//  Created by Ivan BOHONOSIUK on 05.10.2018.
//  Copyright © 2018 Ivan BOHONOSIUK. All rights reserved.
//

import Foundation

protocol APITwitterDelegate {
    func threatTheTweets(name: [tweetData])
    func error(er: NSError)
}
