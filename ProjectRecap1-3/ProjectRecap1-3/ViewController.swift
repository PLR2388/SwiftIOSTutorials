//
//  ViewController.swift
//  ProjectRecap1-3
//
//  Created by Paul-Louis Renard on 05/09/2021.
//

import UIKit

class ViewController: UITableViewController {
    
    var flags = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        for item in items {
            if item.hasSuffix(".png") {
                flags.append(item)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return flags.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var country = ""
        var components = flags[indexPath.row].components(separatedBy: ".")
        if components.count > 1 { // If there is a file extension
          components.removeLast()
          country = components.joined(separator: ".")
        } else {
            country =  flags[indexPath.row]
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "flag", for: indexPath)
        cell.textLabel?.text = country
        return cell
    }


}

