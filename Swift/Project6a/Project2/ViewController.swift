//
//  ViewController.swift
//  Project2
//
//  Created by Paul-Louis Renard on 04/09/2021.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    var countries = [String]()
    var score = 0
    var correctAnswer = 0
    var numberQuestionAnswered = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        countries += ["Estonia", "France", "Germany", "Ireland", "Italy", "Monaco", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"]
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .play, target: self, action: #selector(showScore))
        
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        
        askQuestion(action: nil)
    }
    
    func askQuestion(action: UIAlertAction!) {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        
        title = "\(countries[correctAnswer].uppercased()) score: \(score)"
    }


    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String
       
        numberQuestionAnswered += 1
        
      
        
        if sender.tag == correctAnswer {
            title = "Correct"
            score += 1
        } else {
            title = "Wrong! That's the flag of \(countries[sender.tag])"
            score -= 1
        }
        
        var message = "Your score is \(score)"
        
        if numberQuestionAnswered == 10 {
            title = "Game over"
            message = "Your final score is \(score)"
        }
        
        let ac = UIAlertController(title: title, message: message , preferredStyle: .alert)
        
        if numberQuestionAnswered < 10 {
            ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
        }
      
        present(ac, animated: true)
    }
    
    @objc func showScore() {
        let title = "Score"
        let message = "Your score is \(score)"
        let ac = UIAlertController(title: title, message: message , preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
}

