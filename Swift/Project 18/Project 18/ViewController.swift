//
//  ViewController.swift
//  Project 18
//
//  Created by Paul-Louis Renard on 31/10/2021.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        print("I'm inside the viewDidLoad() method.")
//        print(1,2,3,4,5, separator: "-")
//        print("Some message", terminator: "")
//
//        assert(1 == 1, "Math failure!")
//        assert(1 == 2, "Math failure!")
//        assert(myReallySlowMethod() == true, "The slow method returned false, whice is a bad thing.")
        
        for i in 1...100 {
            print("Got number \(i).")
        }
    }


}

