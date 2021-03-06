//
//  ViewController.swift
//  Project5
//
//  Created by Paul-Louis Renard on 07/09/2021.
//

import UIKit

class ViewController: UITableViewController {
    
    var allWords = [String]()
    var usedWords = [String]() {
        didSet {
            let defaults = UserDefaults.standard
            defaults.set(usedWords, forKey: "words")
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(startGame))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptForAnswer))
        
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordsURL) {
                allWords = startWords.components(separatedBy: "\n")
            }
        }
        
        if allWords.isEmpty {
            allWords = ["silkworm"]
        }
        
        let defaults = UserDefaults.standard
        let title = defaults.string(forKey: "word")
        if let title = title {
            self.title = title
            if let words = defaults.object(forKey: "words") as? [String] {
                self.usedWords = words
                tableView.reloadData()
            }
            
            
        } else {
            startGame()
        }
       
    }
    
    @objc func startGame() {
        title = allWords.randomElement()
        let defaults = UserDefaults.standard
        defaults.set(title, forKey: "word")
        usedWords.removeAll(keepingCapacity: true)
        defaults.set(usedWords, forKey: "words")
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usedWords.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Word", for: indexPath)
        cell.textLabel?.text = usedWords[indexPath.row]
        return cell
    }
    
    @objc func promptForAnswer() {
        let ac = UIAlertController(title: "Enter answer", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        let submitAction = UIAlertAction(title: "Submit", style: .default) { [weak self, weak ac] action in
            guard let answer = ac?.textFields?[0].text else {return}
            self?.submit(answer)
            
        }
        
        ac.addAction(submitAction)
        present(ac, animated: true)
    }
    
    func submit(_ answer: String) {
        let lowerAnswer = answer.lowercased()
        
        if lowerAnswer == title?.lowercased() {
            showErrorMessage(title: "Identical Word", message: "You can't write the same word!")
        } else if isPossible(word: lowerAnswer) {
            if isOriginal(word: lowerAnswer) {
                if isReal(word: lowerAnswer) {
                    usedWords.insert(answer, at: 0)
                    let defaults = UserDefaults.standard
                    let indexPath = IndexPath(row: 0, section: 0)
                    tableView.insertRows(at: [indexPath], with: .automatic)
                    defaults.set(usedWords, forKey: "words")
                    return
                } else {
                    showErrorMessage(title:"Word not recognised" , message: "You can't just make them up, you know!")
                }
            } else {
                showErrorMessage(title: "Word used already", message: "Be more original!")
            }
        } else {
            guard let title = title?.lowercased() else {
                return
            }
            showErrorMessage(title: "Word not possible", message:  "You can't spell that word from \(title)")
        }
    }
    
    func isPossible(word: String) -> Bool {
        guard var tempWord = title?.lowercased() else {return false}
        
        for letter in word {
            if let position = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: position)
            } else {
                return false
            }
    
        }
        return true
    }
    
    func isOriginal(word: String) -> Bool {
        return !usedWords.contains(word)
    }
    
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let count = word.utf16.count
        if count < 3 {
            return false
        } else {
            let range = NSRange(location: 0, length: count)
            let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
            return misspelledRange.location == NSNotFound
        }
    }
    
    func showErrorMessage(title: String, message: String) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }


}

