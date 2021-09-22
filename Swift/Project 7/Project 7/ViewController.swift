//
//  ViewController.swift
//  Project 7
//
//  Created by Paul-Louis Renard on 21/09/2021.
//

import UIKit

class ViewController: UITableViewController {
    
    var petitions = [Petition]()
    var filteredPetitions = [Petition]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(showCredit))
        navigationItem.leftBarButtonItems = [UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(filterPetition)), UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(resetFilter))]
        
        let urlString: String
        
        if navigationController?.tabBarItem.tag == 0 {
            urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
        } else {
            urlString = "https://www.hackingwithswift.com/samples/petitions-2.json"
        }
//
//        if let url = URL(string: urlString) {
//            if let data = try? Data(contentsOf: url) {
//                // we're OK to parse!
//                parse(json: data)
//            } else {
//                showError()
//            }
//        } else {
//            showError()
//        }
//
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                // we're OK to parse!
                parse(json: data)
                return
            }
        }
        
        showError()
    }
    
    @objc func resetFilter() {
        filteredPetitions.removeAll()
        tableView.reloadData()
    }
    
    @objc func showCredit() {
        let ac = UIAlertController(title: "Credit", message: "Theses data come from We The People API of the WhiteHouse", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    @objc func filterPetition() {
        let ac = UIAlertController(title: "Filter ", message: nil, preferredStyle: .alert)
        ac.addTextField()
        let action = UIAlertAction(title: "Submit", style: .default) { [weak self, weak ac] action in
            guard let filter = ac?.textFields?[0].text else { return }
            self?.submit(filter)
        }
        
        ac.addAction(action)
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(ac, animated: true)
    }
    
    func submit(_ filter: String) {
        filteredPetitions.removeAll()
        for petition in petitions {
            if petition.title.contains(filter) || petition.body.contains(filter) {
                filteredPetitions.append(petition)
            }
        }
        tableView.reloadData()
    }
    
    func showError() {
        let ac = UIAlertController(title: "Loading error", message: "There was a problem loading the feed; please check your connection and try again.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    func parse(json: Data) {
        let decoder = JSONDecoder()
        
        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
            petitions = jsonPetitions.results
            tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !filteredPetitions.isEmpty {
            return filteredPetitions.count
        } else {
            return petitions.count
        }

    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell",for: indexPath)
        
        let petition: Petition
        
        if !filteredPetitions.isEmpty {
            petition = filteredPetitions[indexPath.row]
        } else {
            petition = petitions[indexPath.row]
        }
        

        cell.textLabel?.text = petition.title
        cell.detailTextLabel?.text = petition.body
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        
        let petition: Petition
        if !filteredPetitions.isEmpty {
            petition = filteredPetitions[indexPath.row]
        } else {
            petition = petitions[indexPath.row]
        }
        
        vc.detailItem = petition
        navigationController?.pushViewController(vc, animated: true)
    }



}

