//
//  DetailsViewController.swift
//  ProjectRecap1-3
//
//  Created by Paul-Louis Renard on 06/09/2021.
//

import UIKit

class DetailsViewController: UIViewController {
    
    var imageToLoad = ""
    
    @IBOutlet var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = UIImage(named: imageToLoad)
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareFlag))
    }
    
    @objc func shareFlag(){
        guard let image = imageView.image?.jpegData(compressionQuality: 0.8) else {
                  print("No image found")
                  return
              }
        let country = imageToLoad.extractName()
        let vc = UIActivityViewController(activityItems: [image, country], applicationActivities: [])
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
