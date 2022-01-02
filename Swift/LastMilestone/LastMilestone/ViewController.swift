//
//  ViewController.swift
//  LastMilestone
//
//  Created by Paul-Louis Renard on 31/12/2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    @IBOutlet var button4: UIButton!
    @IBOutlet var button5: UIButton!
    @IBOutlet var button6: UIButton!
    @IBOutlet var button7: UIButton!
    @IBOutlet var button8: UIButton!
    @IBOutlet var button9: UIButton!
    @IBOutlet var button10: UIButton!
    @IBOutlet var button11: UIButton!
    @IBOutlet var button12: UIButton!
    @IBOutlet var button13: UIButton!
    @IBOutlet var button14: UIButton!
    @IBOutlet var winLabel: UILabel!
    
    let dict1: [String: String] = [
        "France": "Paris",
        "Allemagne": "Berlin",
        "Suisse": "Berne",
        "Italie": "Rome",
        "Espagne": "Madrid",
        "Angleterre": "Londres",
        "Suède": "Oslo"
    ]
    
    var allValues = [
    "France","Paris","Allemagne","Berlin","Suisse","Berne","Italie","Rome","Espagne","Madrid","Angleterre","Londres","Suède","Oslo"
    ]
    
    
    var linkDict = [Int: String]()
    
    var firstWordRevealed: String = ""
    var secondWordRevealed: String = ""
    var hideButtonsNumber = 0
    
    var mustCompare: Bool {
        !firstWordRevealed.isEmpty && !secondWordRevealed.isEmpty
    }
    
    func compare() {
        let valid: Bool
        if mustCompare {
            if let value = dict1[firstWordRevealed] {
                valid = value == secondWordRevealed
            } else if let value = dict1[secondWordRevealed] {
                valid = value == firstWordRevealed
            } else {
                valid = false
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                if let index1 = self.linkDict.key(forValue: self.firstWordRevealed) {
                    self.modifyButton(i: index1, isHidden: valid, eraseText: !valid)
                }
                if let index2 = self.linkDict.key(forValue: self.secondWordRevealed) {
                    self.modifyButton(i: index2, isHidden: valid, eraseText: !valid)
                }
                self.firstWordRevealed = ""
                self.secondWordRevealed = ""
            }
        }
    }
    
    func modifyButton(i: Int, isHidden: Bool = false, eraseText: Bool = false) {
        switch i {
        case 1:
            button1.isHidden = isHidden
            if eraseText {
                button1.setTitle("Click to Show", for: .normal)
            }
            break
        case 2:
            button2.isHidden = isHidden
            if eraseText {
                button2.setTitle("Click to Show", for: .normal)
            }
            break
        case 3:
            button3.isHidden = isHidden
            if eraseText {
                button3.setTitle("Click to Show", for: .normal)
            }
            break
        case 4:
            button4.isHidden = isHidden
            if eraseText {
                button4.setTitle("Click to Show", for: .normal)
            }
            break
        case 5:
            button5.isHidden = isHidden
            if eraseText {
                button5.setTitle("Click to Show", for: .normal)
            }
            break
        case 6:
            button6.isHidden = isHidden
            if eraseText {
                button6.setTitle("Click to Show", for: .normal)
            }
            break
        case 7:
            button7.isHidden = isHidden
            if eraseText {
                button7.setTitle("Click to Show", for: .normal)
            }
            break
        case 8:
            button8.isHidden = isHidden
            if eraseText {
                button8.setTitle("Click to Show", for: .normal)
            }
            break
        case 9:
            button9.isHidden = isHidden
            if eraseText {
                button9.setTitle("Click to Show", for: .normal)
            }
            break
        case 10:
            button10.isHidden = isHidden
            if eraseText {
                button10.setTitle("Click to Show", for: .normal)
            }
            break
        case 11:
            button11.isHidden = isHidden
            if eraseText {
                button11.setTitle("Click to Show", for: .normal)
            }
            break
        case 12:
            button12.isHidden = isHidden
            if eraseText {
                button12.setTitle("Click to Show", for: .normal)
            }
            break
        case 13:
            button13.isHidden = isHidden
            if eraseText {
                button13.setTitle("Click to Show", for: .normal)
            }
            break
        case 14:
            button14.isHidden = isHidden
            if eraseText {
                button14.setTitle("Click to Show", for: .normal)
            }
            break
        default:
            break
        }
        
        if isHidden {
            hideButtonsNumber += 1
            if hideButtonsNumber == 14 {
                winLabel.isHidden = false
            }
        }

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        allValues.shuffle()
        for (i, elt) in allValues.enumerated() {
            linkDict[(i+1)] = elt
        }
    }
    
    func affectWord(index: Int) {
        guard let word = linkDict[index] else { return }
        if firstWordRevealed.isEmpty {
            firstWordRevealed = word
        } else if secondWordRevealed.isEmpty {
            secondWordRevealed = word
        }
        compare()
    }
    
    
    @IBAction func button1Tapped(_ sender: Any) {
        button1.setTitle(linkDict[1], for: .normal)
        affectWord(index: 1)
    }
    
    @IBAction func button2Tapped(_ sender: Any) {
        button2.setTitle(linkDict[2], for: .normal)
        affectWord(index: 2)
    }
    @IBAction func button3Tapped(_ sender: Any) {
        button3.setTitle(linkDict[3], for: .normal)
        affectWord(index: 3)
    }
    
    @IBAction func button4Tapped(_ sender: Any) {
        button4.setTitle(linkDict[4], for: .normal)
        affectWord(index: 4)
    }
    
    @IBAction func button5Tapped(_ sender: Any) {
        button5.setTitle(linkDict[5], for: .normal)
        affectWord(index: 5)
    }
    
    @IBAction func button6Tapped(_ sender: Any) {
        button6.setTitle(linkDict[6], for: .normal)
        affectWord(index: 6)
    }
    
    @IBAction func button7Tapped(_ sender: Any) {
        button7.setTitle(linkDict[7], for: .normal)
        affectWord(index: 7)
    }
    @IBAction func button8Tapped(_ sender: Any) {
        button8.setTitle(linkDict[8], for: .normal)
        affectWord(index: 8)
    }
    @IBAction func button9Tapped(_ sender: Any) {
        button9.setTitle(linkDict[9], for: .normal)
        affectWord(index: 9)
    }
    
    @IBAction func button10Tapped(_ sender: Any) {
        button10.setTitle(linkDict[10], for: .normal)
        affectWord(index: 10)
    }
    
    @IBAction func button11Tapped(_ sender: Any) {
        button11.setTitle(linkDict[11], for: .normal)
        affectWord(index: 11)
    }
    @IBAction func button12Tapped(_ sender: Any) {
        button12.setTitle(linkDict[12], for: .normal)
        affectWord(index: 12)
    }
    
    @IBAction func button13Tapped(_ sender: Any) {
        button13.setTitle(linkDict[13], for: .normal)
        affectWord(index: 13)
    }
    @IBAction func button14Tapped(_ sender: Any) {
        button14.setTitle(linkDict[14], for: .normal)
        affectWord(index: 14)
    }
    
    
}

extension Dictionary where Value: Equatable {
    func key(forValue value: Value) -> Key? {
        return first { $0.1 == value }?.0
    }
}
