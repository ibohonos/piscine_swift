//
//  ViewController.swift
//  d02
//
//  Created by Ivan BOHONOSIUK on 03.10.2018.
//  Copyright © 2018 Ivan BOHONOSIUK. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
   
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var descText: UITextView!
    @IBOutlet weak var dateText: UIDatePicker!
    
    var name: String!
    var desc: String!
    var date: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        descText!.layer.borderWidth = 1
        descText!.layer.borderColor = UIColor.gray.cgColor
        dateText.minimumDate = Date()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if nameText.text != "" {
            let format = DateFormatter()
            format.dateFormat = "yyyy-mm-dd HH:mm:ss"
            let date2  = format.string(from: dateText.date)
            name = nameText.text!
            desc = descText.text!
            date = String(describing: date2)
            
            print(nameText.text!)
            print(descText.text!)
            print(dateText.date)
        } else {
            name = ""
        }
    }
}
