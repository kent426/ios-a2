//
//  MasterViewController.swift
//  lab2
//
//  Created by Yu Hong Huang on 2017-12-01.
//  Copyright © 2017 Yu Hong Huang. All rights reserved.
//

import UIKit
import Alamofire
import Foundation

class MasterViewController: UITableViewController {

    var detailViewController: DetailViewController? = nil
    var objects = [String]()
    
    var titleToContent: [String:String]!


    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleToContent = [String:String]()
        
        let thisBaseUrl = "https://swapi.co/api/films/"
        
        
        //set up the header
        let headers: HTTPHeaders = ["Accept": "application/json"]
        
        //sending request
        Alamofire.request(thisBaseUrl, headers: headers).responseJSON { [weak self] response in
            
            let re = response.result.value! as? [String:Any]
            
            //array of films
            let res = re!["results"] as? [Any]
            
            for one in res! {
                let o = one as! [String: Any]
                let title = o["title"] as! String
                
                let opencrawl = o["opening_crawl"] as! String
                
                self?.insertNewObject(o: title)
                
                self?.titleToContent.updateValue(opencrawl, forKey: title)
               // print(t)
                //print(opencrawl)
            }
            
            
        }
    
//        navigationItem.leftBarButtonItem = editButtonItem
//
//        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(insertNewObject(_:)))
//        navigationItem.rightBarButtonItem = addButton
        if let split = splitViewController {
            let controllers = split.viewControllers
            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }


    func insertNewObject(o:String) {
        objects.insert(o, at: 0)
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }

    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let titleTapped = objects[indexPath.row]
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                controller.text = self.titleToContent[titleTapped]
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        let s = objects[indexPath.row]
        cell.textLabel!.text = s
        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            objects.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }


}

