//
//  ViewController.swift
//  rush00
//
//  Created by Ivan BOHONOSIUK on 06.10.2018.
//  Copyright © 2018 Ivan BOHONOSIUK. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let clientId : String = "2841c23aee32782b087795faf54566bea4eb0388a49e14562ba1976ef98d2bdb"
    let callbackUrl = "rush00%3A%2F%2Frush00"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//        let apic = APIController()
//        if (apic.code != nil) {
//            let info = apic.getInfo()
//            print(info.token as Any)
//        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func loginIntra(_ sender: UIButton) {
        let authURL = URL(string: "https://api.intra.42.fr/oauth/authorize?client_id=\(self.clientId)&redirect_uri=\(self.callbackUrl)&response_type=code")
        UIApplication.shared.open(authURL!, options: [:], completionHandler: nil)
    }
    
    override func performSegue(withIdentifier identifier: String, sender: Any?) {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let seq = segue.destination as! TopicsTableViewController
        print(seq)
//        let cell = sender! as! TopicsTableViewCell
//        if cell.imageLabel.image != nil {
//            seq.image = cell.imageLabel.image!
//        } else {
//            let alertController = UIAlertController(title: "Error", message: "Cannot acces to this image", preferredStyle: UIAlertControllerStyle.alert)
//            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
//            self.present(alertController, animated: true, completion: nil)
//        }
    }
    
}
