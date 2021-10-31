//
//  ViewController.swift
//  Project13-15
//
//  Created by Paul-Louis Renard on 31/10/2021.
//

import UIKit

class ViewController: UITableViewController {
    
    var countries = [Country]()

    override func viewDidLoad() {
        super.viewDidLoad()
        loadCountries()
        
    }
    
    func loadCountries() {
        let jsonDecoder = JSONDecoder()
        if let bundlePath = Bundle.main.path(forResource: "countries", ofType: "json") {
            if let data = try? String(contentsOfFile: bundlePath).data(using: .utf8) {
                if let countries = try? jsonDecoder.decode([Country].self, from: data) {
                    self.countries = countries
                }
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(identifier: "Details") as? DetailViewController {
            vc.country = countries[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") {
            cell.textLabel?.text = countries[indexPath.row].name
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }


}

