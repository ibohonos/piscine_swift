//
//  ViewController.swift
//  ex02
//
//  Created by Ivan BOHONOSIUK on 10/1/18.
//  Copyright © 2018 Ivan BOHONOSIUK. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var result: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btns(_ sender: UIButton) {
        result.text = String(sender.tag - 1)
        print(sender.tag - 1)
    }
    
    @IBAction func AC(_ sender: UIButton) {
        print("AC")
    }
    
    @IBAction func NEG(_ sender: UIButton) {
        print("NEG")
    }
    
    @IBAction func plus(_ sender: UIButton) {
        print("+")
    }
    
    @IBAction func mult(_ sender: Any) {
        print("*")
    }
    
    @IBAction func minus(_ sender: UIButton) {
        print("-")
    }
    
    @IBAction func delivery(_ sender: UIButton) {
        print("/")
    }
    
    @IBAction func equals(_ sender: UIButton) {
        print("=")
    }
}


