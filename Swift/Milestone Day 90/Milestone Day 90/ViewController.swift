//
//  ViewController.swift
//  Milestone Day 90
//
//  Created by Paul-Louis Renard on 29/12/2021.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate , UINavigationControllerDelegate {
    @IBOutlet var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func importPictureTapped(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        
        dismiss(animated: true)
        
        imageView.image = image
    }
    
    func drawImageWithText(image: UIImage, text: String, position: CGPoint) {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: image.size.width, height: image.size.height))
        
        let img = renderer.image { ctx in
            
            let paragraphStyle = NSMutableParagraphStyle()
            
            paragraphStyle.alignment = .center
            
            let attrs: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: 50),
                .strokeColor: UIColor.black,
                .foregroundColor: UIColor.white,
                .strokeWidth: 3,
                .paragraphStyle: paragraphStyle
            ]
            
            let attributedString = NSAttributedString(string: text, attributes: attrs)
            
            image.draw(at: CGPoint(x: 0, y: 0))
            
            attributedString.draw(in: CGRect(x: position.x, y: position.y, width: image.size.width, height: 100))
        }
        
        imageView.image = img
    }
    
    @IBAction func setTopTextTapped(_ sender: Any) {
        guard let image = imageView.image else { return }
        let ac = UIAlertController(title: "Set a Top Text", message: nil, preferredStyle: .alert)
        ac.addTextField()
        let action = UIAlertAction(title: "OK", style: .default) { [weak self, weak ac] action in
                   guard let text = ac?.textFields?[0].text else { return }
            self?.drawImageWithText(image: image, text: text, position: CGPoint(x: 20, y: image.size.height / 5))
               }
        ac.addAction(action)
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        present(ac, animated: true)
    }

    
    @IBAction func setBottomTextTapped(_ sender: Any) {
        guard let image = imageView.image else { return }
        let ac = UIAlertController(title: "Set a Bottom Text", message: nil, preferredStyle: .alert)
        ac.addTextField()
        let action = UIAlertAction(title: "OK", style: .default) { [weak self, weak ac] action in
                   guard let text = ac?.textFields?[0].text else { return }
            self?.drawImageWithText(image: image, text: text, position: CGPoint(x: 20, y: 4 * image.size.height / 5))
               }
        ac.addAction(action)
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        present(ac, animated: true)
    }
}

