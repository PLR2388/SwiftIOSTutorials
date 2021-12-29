//
//  DetailViewController.swift
//  Project1
//
//  Created by Paul-Louis Renard on 03/09/2021.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    var selectedImage: String?
    var indexImage: Int = 0
    var numberImages: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Picture \(indexImage) of \(numberImages)"
        navigationItem.largeTitleDisplayMode = .never
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        
        if let imageToLoad = selectedImage {
            imageView.image = UIImage(named: imageToLoad)
        }

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
        
    }
    
    func addCopyrightText(to image: UIImage) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: image.size.width, height: image.size.height))
        
        let img = renderer.image { ctx in
            let attrs: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: 36),
                .foregroundColor: UIColor.red
            ]
            
            let string = "From Storm Viewer"
            let attributedString = NSAttributedString(string: string, attributes: attrs)
            
         
            image.draw(at: CGPoint(x: 0, y: 0))
            attributedString.draw(at: CGPoint(x: 50, y: 50))
        }
        
        return img
    }
    
    @objc func shareTapped() {
        guard let image = imageView.image else {
            print("No image found")
            return
            
        }
        let modifiedImage = addCopyrightText(to: image)
        
//        guard let image = imageView.image?.jpegData(compressionQuality: 0.8) else {
//            print("No image found")
//            return
//        }
        let imageData = modifiedImage.jpegData(compressionQuality: 0.8)
        let vc = UIActivityViewController(activityItems: [imageData, selectedImage!], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
