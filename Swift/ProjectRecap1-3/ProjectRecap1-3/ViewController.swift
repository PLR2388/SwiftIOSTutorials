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
        let country = flags[indexPath.row].extractName()
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "flag", for: indexPath)
        cell.textLabel?.text = country
        cell.imageView?.image = UIImage(named: flags[indexPath.row])
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(identifier: "Details") as? DetailsViewController {
            vc.imageToLoad = flags[indexPath.row]
            
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension String {
    func extractName() -> String {
        var filename = ""
        var components = self.components(separatedBy: ".")
        if components.count > 1 { // If there is a file extension
          components.removeLast()
          filename = components.joined(separator: ".")
        } else {
            filename =  self
        }
        return filename
    }
}
