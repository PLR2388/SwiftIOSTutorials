//
//  ViewController.swift
//  Milestone Day 74
//
//  Created by Paul-Louis Renard on 27/11/2021.
//

import UIKit

class ViewController: UITableViewController {
    
    var notes: [Note] = []
    let NOTES_KEY: String = "notes"

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view
        let defaults = UserDefaults.standard
        if let notes = defaults.object(forKey: NOTES_KEY) as? [Note] {
            self.notes = notes
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addANote))
    }
    
    @objc func addANote() {
        let note = Note(title: "", body: "")
        navigate(note: note)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        notes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "note", for: indexPath)
        let note = notes[indexPath.row]
        cell.textLabel?.text = note.title
        cell.detailTextLabel?.text = note.body
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let note = notes[indexPath.row]
        navigate(note: note)
    }
    
    private func navigate(note: Note) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "details") as? DetailsViewController {
            vc.note = note
            vc.saveNoteDelegate = { note in
                self.notes.append(note)
                let defaults = UserDefaults.standard
                defaults.set(self.notes, forKey: self.NOTES_KEY)
            }
            navigationController?.pushViewController(vc, animated: true)
        }
    }


}

