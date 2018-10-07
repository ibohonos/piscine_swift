//
//  Global.swift
//  rush00
//
//  Created by Ivan BOHONOSIUK on 07.10.2018.
//  Copyright © 2018 Ivan BOHONOSIUK. All rights reserved.
//

import Foundation
import UIKit

func Global(_ type: Int) -> String {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    if type == 0 {
        return (appDelegate.apic?.getToken())!
    } else {
        return (appDelegate.apic?.id_user)!
    }
}
