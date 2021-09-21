//
//  ViewController.swift
//  Project5 Shopping List
//
//  Created by Paul-Louis Renard on 21/09/2021.
//

import UIKit

class ViewController: UITableViewController {
    
    var shoppingList = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationItem.rightBarButtonItems = [UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(insert)),UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareList))]
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(clearTable))
    }
    
    @objc func shareList() {
        let share = shoppingList.joined(separator: "\n")
        let vc = UIActivityViewController(activityItems: [share], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
    
    @objc func clearTable() {
        shoppingList.removeAll()
        tableView.reloadData()
    }
    
    @objc func insert() {
        let ac = UIAlertController(title: "Add a product", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        let submitAction = UIAlertAction(title: "Submit", style: .default) { [weak self, weak ac] action in
              guard let answer = ac?.textFields?[0].text else {return}
              self?.submit(answer)
              
          }
          
        ac.addAction(submitAction)
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(ac, animated: true)
    }
    
    func submit(_ product: String) {
        shoppingList.insert(product, at: 0)
        let indexRow = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexRow], with: .automatic)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Product", for: indexPath)
        cell.textLabel?.text = shoppingList[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingList.count
    }


}

