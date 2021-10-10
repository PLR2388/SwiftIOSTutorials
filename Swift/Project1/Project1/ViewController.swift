//
//  ViewController.swift
//  Project1
//
//  Created by Paul-Louis Renard on 03/09/2021.
//

import UIKit

class ViewController: UITableViewController {

    var pictures = [String]()
    var numberShown = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Storm Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareApp))

        DispatchQueue.global(qos: .userInitiated).async {
            let defaults = UserDefaults.standard
            
         
            
            let fm = FileManager.default
            let path = Bundle.main.resourcePath!
            let items = try! fm.contentsOfDirectory(atPath: path)
            var defaultArray = [Int]()

            for item in items {
                if item.hasPrefix("nssl") {
                    // this is a picture to load!
                    self.pictures.append(item)
                    defaultArray.append(0)
                }
            }
            self.pictures.sort()
            
            if let savedNumberShown = defaults.object(forKey: "numberShown") as? Data {
                let jsonDecoder = JSONDecoder()

                do {
                    self.numberShown = try jsonDecoder.decode([Int].self, from: savedNumberShown)
                } catch {
                    print("Failed to load numberShown")
                }
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }

    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        cell.textLabel?.text = pictures[indexPath.row]
        cell.detailTextLabel?.text = "viewed \(numberShown[indexPath.row])"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(identifier: "Detail") as? DetailViewController {
            vc.selectedImage = pictures[indexPath.row]
            vc.indexImage = (indexPath.row) + 1
            vc.numberImages = pictures.count
            numberShown[indexPath.row] += 1
            tableView.reloadData()
            save()
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func save() {
        let jsonEncoder = JSONEncoder()
        if let savedData = try? jsonEncoder.encode(numberShown) {
            let defaults = UserDefaults.standard
            defaults.set(savedData,forKey: "numberShown")
        }
    }
    
    @objc func shareApp(){
        let text = "Look at Project1, certainly the best iPhone app ever!"
        let vc = UIActivityViewController(activityItems: [text], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }


}

