//
//  yahooResultTableViewController.swift
//  YahooAPI
//
//  Created by Rania Arbash on 2020-03-13.
//  Copyright © 2020 Rania Arbash. All rights reserved.
//

import UIKit

class yahooResultTableViewController: UITableViewController , UISearchBarDelegate{

    var resultArray = NSArray()
    var downloader = Downloader()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //notification
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTheTable), name: Notification.Name("WepAPIIsReady"), object: nil)
        
        
    }
    
   @objc func reloadTheTable()  {
    resultArray = downloader.results
    print(resultArray.count)
    tableView.reloadData()
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
        print(searchBar.text ?? "")
        downloader.download(text: searchBar.text ?? "")
        // ask for new result
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return resultArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        let thisItem = resultArray[indexPath.row] as! NSDictionary
        cell.textLabel?.text = thisItem.value(forKey: "symbol") as? String
        cell.detailTextLabel?.text = thisItem.value(forKey: "name") as? String
        
        return cell
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
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
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
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
