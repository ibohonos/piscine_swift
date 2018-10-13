//
//  DiaryTableViewController.swift
//  d09
//
//  Created by Ivan BOHONOSIUK on 10/13/18.
//  Copyright © 2018 Ivan BOHONOSIUK. All rights reserved.
//

import UIKit
import LocalAuthentication
import ibohonos2018

class DiaryTableViewController: UITableViewController {

    @IBOutlet var diaryTable: UITableView!
    
    let context = LAContext()
    
    let language = NSLocale.preferredLanguages.first
    let articleManager = ArticleManager()
    var articles: [Article] = []
    var reloadData: Bool = false
    var articleDel: Article? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        authenticate()
        diaryTable.delegate = self
        diaryTable.dataSource = self
        diaryTable.rowHeight = UITableViewAutomaticDimension
        diaryTable.estimatedRowHeight = 140
    }
    
    func alert (message: String) {
        let alertController = UIAlertController(title: "Error", message:
            message, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default,handler: nil))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func authenticate () {
        if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: nil) {
            context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: "You need to be authenticate") {
                (success, error) in
                if success {
                    DispatchQueue.main.async {
                        self.loadArticles()
                        self.diaryTable.reloadData()
                    }
                } else {
                    DispatchQueue.main.async {
                        self.alert(message: NSLocalizedString("Authentification failed!", comment: ""))
                        self.authenticate()
                    }
                }
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return articles.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellDiary", for: indexPath) as! DiaryTableViewCell
        
        cell.titleLabel.text = articles[indexPath.row].title
        if articles[indexPath.row].image != nil {
            let i = UIImage(data: articles[indexPath.row].image! as Data)
            cell.imageLabel.image = i
            cell.imageLabel.isHidden = false
        } else {
            cell.imageLabel.isHidden = true
        }
        cell.contentLabel.text = articles[indexPath.row].content
        let d = DateFormatter()
        d.locale = Locale(identifier: language!)
        d.setLocalizedDateFormatFromTemplate("MMM dd, YYYY 'at' HH:mm")
        cell.cretedLabel.text = "Creation: \(d.string(from: articles[indexPath.row].created_at! as Date))"
        if articles[indexPath.row].updated_at != nil {
            cell.updatedLabel.text = "Modification: \(d.string(from: articles[indexPath.row].updated_at! as Date))"
            cell.updatedLabel.isHidden = false
        } else {
            cell.updatedLabel.isHidden = true
        }

        // Configure the cell...

        return cell
    }
    
    func loadArticles() {
        self.articles = []
        self.articles = self.articleManager.getArticles(withLang: language!)
    }
    
    internal override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "updateSeque", sender: indexPath.row)
    }
    
    @IBAction func unWindsegue(segue: UIStoryboardSegue) {
        if reloadData {
            loadArticles()
            diaryTable.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "updateSeque" {
            if let vc = segue.destination as? ViewController {
                let row = sender as! Int
                vc.articleManager = articleManager
                vc.article = articles[row]
            }
        } else if segue.identifier == "createSegue" {
            if let vc = segue.destination as? ViewController {
                vc.articleManager = articleManager
            }
        }
    }
    
    // Swipe
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            articleDel = articles[indexPath.row]
            confirmDelete(article: articleDel!.title!)
            
        }
    }
    
    func confirmDelete(article: String) {
        let alert = UIAlertController(title: "Delete article", message: "Are you sure you want to permanently delete \(article)?", preferredStyle: .actionSheet)
        
        let DeleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: handleDeleteArticle)
        let CancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: cancelDeleteArticle)
        
        alert.addAction(DeleteAction)
        alert.addAction(CancelAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func handleDeleteArticle(alertAction: UIAlertAction!) -> Void {
        articleManager.removeArticle(article: articleDel!)
        loadArticles()
        diaryTable.reloadData()
        articleDel = nil
    }
    
    func cancelDeleteArticle(alertAction: UIAlertAction!) {
        articleDel = nil
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
