//
//  ViewController.swift
//  MilestoneProject24
//
//  Created by Paul-Louis Renard on 27/12/2021.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

extension UIView {
    func bounceOut(duration: TimeInterval) {
        UIView.animate(withDuration: duration,delay: 0, options: .curveEaseOut) {
            self.transform = CGAffineTransform(scaleX: 0.0001, y: 0.0001)
        }
    }
}

extension Int {
    func times(completion: () -> Void) {
        guard self > 0 else { return }
        for _ in 0..<self {
            completion()
        }
    }
}

extension Array where Element: Comparable {
    mutating func remove(item: Element){
        if let index = firstIndex(of: item) {
            self.remove(at: index)
        }
    }
}
