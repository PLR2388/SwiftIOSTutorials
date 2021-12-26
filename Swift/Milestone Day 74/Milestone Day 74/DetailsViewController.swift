//
//  DetailsViewController.swift
//  Milestone Day 74
//
//  Created by Paul-Louis Renard on 28/11/2021.
//

import UIKit

class DetailsViewController: UIViewController {
    var note: Note!
    var saveNoteDelegate: ((Note) -> ())!

    @IBOutlet weak var titleTextView: UITextView!
    @IBOutlet weak var bodyTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "OK", style: .plain, target: self, action: #selector(saveNote))
    }
    
    @objc func saveNote() {
        note.title = titleTextView.text
        note.body = bodyTextView.text
        saveNoteDelegate(note)
        
        navigationController?.popViewController(animated: true)
    }

}
