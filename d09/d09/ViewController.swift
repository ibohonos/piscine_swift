//
//  ViewController.swift
//  d09
//
//  Created by Ivan BOHONOSIUK on 10/12/18.
//  Copyright © 2018 Ivan BOHONOSIUK. All rights reserved.
//

import UIKit
import ibohonos2018

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var titleLabel: UITextField!
    @IBOutlet weak var contentLabel: UITextView!
    @IBOutlet weak var imageLabel: UIImageView!
    
    let pickerController = UIImagePickerController()
    var articleManager : ArticleManager?
    let language = NSLocale.preferredLanguages.first
    var article: Article?
    var reloadData: Bool = false
    
    @IBAction func btnTakeAction(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            pickerController.sourceType = .camera
            present(pickerController, animated: true, completion: nil)
        }
    }
    
    @IBAction func btnChooseAction(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            pickerController.sourceType = .photoLibrary
            present(pickerController, animated: true, completion: nil)
        }
    }
    
    @IBAction func btnSaveAction(_ sender: UIBarButtonItem) {
        if titleLabel.text == nil || titleLabel.text == "" {
            alert(message: "Can't save without a title!")
            return
        }
        if article == nil {
            article = articleManager!.newArticle()
            article!.created_at = NSDate()
            article!.language = language
        } else {
            article!.updated_at = NSDate()
        }
        article!.title = titleLabel.text
        article!.content = contentLabel.text
        if imageLabel.image != nil {
            article!.image = UIImagePNGRepresentation(imageLabel.image!)! as NSData
        }
        articleManager!.save()
        reloadData = true
        performSegue(withIdentifier: "backSegue", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        pickerController.delegate = self
        
        if article != nil {
            titleLabel.text = article!.title
            contentLabel.text = article!.content
            if article!.image != nil {
                imageLabel.image = UIImage(data: article!.image! as Data)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageLabel.image = pickedImage
        }
        dismiss(animated: true, completion: nil)
    }
    
    func alert (message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "backSegue" {
            if let vc = segue.destination as? DiaryTableViewController {
                vc.reloadData = reloadData
            }
        }
    }

}

