//
//  ViewController.swift
//  MilestoneProject12
//
//  Created by Paul-Louis Renard on 22/10/2021.
//

import UIKit

class ViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var contacts = [Contact]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaults = UserDefaults.standard
        
        if let savedContacts = defaults.object(forKey: "contacts") as? Data {
            let jsonDecoder = JSONDecoder()
            
            do {
                contacts = try jsonDecoder.decode([Contact].self, from: savedContacts)
            } catch {
                print("Failed to load contacts")
            }
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(addNewContact))
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func save() {
        let jsonEncoder = JSONEncoder()
        if let savedData = try? jsonEncoder.encode(contacts) {
            let defaults = UserDefaults.standard
            defaults.set(savedData, forKey: "contacts")
        } else {
            print("Failed to save contacts")
        }
    }
    
    @objc func addNewContact() {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.sourceType = .camera
        } else {
            picker.sourceType = .photoLibrary
        }
        
        present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        
        let imageName = UUID().uuidString
        let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)
        
        if let jpegData = image.jpegData(compressionQuality: 0.8) {
            try? jpegData.write(to: imagePath)
        }
        
        let contact = Contact(name: "", image: imageName)

        dismiss(animated: true)
        
        let ac = UIAlertController(title: "Name your contact", message: nil, preferredStyle: .alert)
        
        ac.addTextField()
        
        ac.addAction(UIAlertAction(title: "Ok", style: .default, handler: { [weak self, weak ac] _ in
            guard let name = ac?.textFields?[0].text else { return }
            contact.name = name
            self?.contacts.append(contact)
            self?.save()
            self?.tableView.reloadData()
        }))
        
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        present(ac, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(identifier: "Detail") as? DetailViewController {
            let contact = contacts[indexPath.row]
            let path = getDocumentsDirectory().appendingPathComponent(contact.image).path
            vc.selectedImage = path
            vc.title = contact.name
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "imageCell", for: indexPath) as? ImageCell else { return UITableViewCell()}
        
        let contact = contacts[indexPath.row]
        
        cell.caption.text = contact.name
        
        let path = getDocumentsDirectory().appendingPathComponent(contact.image)
        
        cell.imageView1.image = UIImage(contentsOfFile: path.path)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }


}

