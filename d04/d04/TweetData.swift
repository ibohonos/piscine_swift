//
//  TweetData.swift
//  d04
//
//  Created by Ivan BOHONOSIUK on 05.10.2018.
//  Copyright © 2018 Ivan BOHONOSIUK. All rights reserved.
//

import Foundation

struct tweetData : CustomStringConvertible {
    let name : String
    let text : String
    let date : String
    public var description : String {
        return "\(name)\n\(date)\n\(text)"
    }
}
