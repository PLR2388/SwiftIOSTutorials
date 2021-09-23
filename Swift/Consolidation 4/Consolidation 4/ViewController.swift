//
//  ViewController.swift
//  Consolidation 4
//
//  Created by Paul-Louis Renard on 23/09/2021.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    var wordToGuess = "hello"
    var allWords: [String] = [String]()
    
    var displayText = "" {
        didSet {
            currentWordLabel.text = displayText
            title = "\(displayText) score: \(score)"
        }
    }
    var triesLeft = 7 {
        didSet {
            if triesLeft == 0 {
                endGame()
            }
            remainedTriesLabel.text = "Remained tries: \(triesLeft)"
        }
    }
    var usedLetters = [String]()
    var score = 0 {
        didSet {
            title = "\(displayText) score: \(score)"
        }
    }


    @IBOutlet var currentWordLabel: UILabel!
    @IBOutlet var remainedTriesLabel: UILabel!
    @IBOutlet var textField: UITextField!
    
    
    @IBAction func submitLetter(_ sender: Any) {
        
        if let letter = textField.text?.lowercased() {
            if usedLetters.contains(letter) {
                let ac = UIAlertController(title: "Wrong", message: "This letter was already choosen!", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "OK", style: .default))
                triesLeft -= 1
                if triesLeft > 0 {
                    present(ac, animated: true)
                }
            } else {
                usedLetters.append(letter)
                if wordToGuess.contains(letter) {
                    for (index , character) in wordToGuess.enumerated() {
                        if String(character) == letter {
                            displayText = replace(myString: displayText, index, character)
                        }
                    }
                    if displayText == wordToGuess {
                        score += 1
                        let ac = UIAlertController(title: "Good", message: "You find the word: \(displayText). Now, your score is \(score)", preferredStyle: .alert)
                        ac.addAction(UIAlertAction(title: "OK", style: .default))
                        present(ac, animated: true)
                        nextWord()
                    }
                } else {
                    let ac = UIAlertController(title: "Wrong", message: "This letter is not in the secret word", preferredStyle: .alert)
                    ac.addAction(UIAlertAction(title: "OK", style: .default))
                    triesLeft -= 1
                    if triesLeft > 0 {
                        present(ac, animated: true)
                    }
                }
            }
            textField.text = ""
        }
        
    }
    
    func endGame() {
        let ac = UIAlertController(title: "Game Over", message: "Your score is \(score)", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        
        let action = UIAlertAction(title: "Restart", style: .default) { _ in
            self.startGame()
        }
        ac.addAction(action)
        present(ac, animated: true)
        score = 0
    }
    
    private func replace(myString: String, _ index: Int, _ newChar: Character) -> String {
        var chars = Array(myString)     // gets an array of characters
        chars[index] = newChar
        let modifiedString = String(chars)
        return modifiedString
    }

    
    func startGame() {
        DispatchQueue.global(qos: .userInteractive).async {
            if let startWordURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
                if let startWords = try? String(contentsOf: startWordURL) {
                    self.allWords = startWords.components(separatedBy: "\n")
                    self.allWords.shuffle()
                    if !self.allWords.isEmpty {
                        DispatchQueue.main.async {
                            self.resetGame()
                        }
                    } else {
                        self.performSelector(onMainThread: #selector(self.showError), with: nil, waitUntilDone: false)
                    }
                } else {
                    self.performSelector(onMainThread: #selector(self.showError), with: nil, waitUntilDone: false)
                }
            } else {
                self.performSelector(onMainThread: #selector(self.showError), with: nil, waitUntilDone: false)
            }
        }
    }
    
    @objc func showError() {
        let ac = UIAlertController(title: "Error", message: "An error occurs!", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    func resetGame() {
        wordToGuess = allWords.popLast()!
        print(wordToGuess)
        displayText = ""
        triesLeft = 7
        usedLetters.removeAll(keepingCapacity: true)
        for _ in 0 ..< wordToGuess.count {
            displayText += "?"
        }
    }
    
    func nextWord() {
        if !allWords.isEmpty {
            resetGame()
        } else {
            endGame()
        }
  
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        textField.delegate = self
        startGame()
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    
    
    private func textLimit(existingText: String?,
                           newText: String,
                           limit: Int) -> Bool {
        let text = existingText ?? ""
        let isAtLimit = text.count + newText.count <= limit
        return isAtLimit
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return textLimit(existingText: textField.text, newText: string, limit: 1)
    }


}

