//
//  DetailViewController.swift
//  Project13-15
//
//  Created by Paul-Louis Renard on 31/10/2021.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet var populationLabel: UILabel!
    @IBOutlet var languageLabel: UILabel!
    
    var country: Country?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let country = country {
            title = country.name
            populationLabel.text = "\(country.population)"
            languageLabel.text = "\(country.language)"
            
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(share))
        }
    }
    
    @objc func share() {
        if let country = country {
            let ac = UIActivityViewController(activityItems: [country.descriptionCountry], applicationActivities: nil)
            present(ac, animated: true)
        }

    }

}
