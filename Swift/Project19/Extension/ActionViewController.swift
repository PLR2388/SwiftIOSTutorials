//
//  ActionViewController.swift
//  Extension
//
//  Created by Paul-Louis Renard on 03/11/2021.
//

import UIKit
import MobileCoreServices

class ActionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet var tableView: UITableView!
    @IBOutlet var script: UITextView!
    var pageTitle = ""
    var pageUrl = ""
    
    var url: URL {
        return URL(string: pageUrl)!
    }
    
    var recordedScripts = [String:String]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recordedScripts.count
    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        // create a new cell if needed or reuse an old one
//        let cell:UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "cell") ?? UITableViewCell()
//           
//           // set the text from the data model
//        cell.textLabel?.text = recordedScripts.remove(at: indexPath.row)
//           
//           return cell
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Register the table view cell class and its reuse id
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        // (optional) include this line if you want to remove the extra empty cell divider lines
        // self.tableView.tableFooterView = UIView()

        // This view controller itself will provide the delegate methods and row data for the table view.
        tableView.delegate = self
        tableView.dataSource = self
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .play, target: self, action: #selector(displayScript))
        
        if let inputItem = extensionContext?.inputItems.first as? NSExtensionItem {
            if let itemProvider = inputItem.attachments?.first {
                itemProvider.loadItem(forTypeIdentifier: kUTTypePropertyList as String) { [weak self] (dict, error) in
                    guard let itemDictionary = dict as? NSDictionary else { return }
                    guard let javaScriptValues = itemDictionary[NSExtensionJavaScriptPreprocessingResultsKey] as? NSDictionary else { return }
                    self?.pageTitle = javaScriptValues["title"] as? String ?? ""
                    self?.pageUrl = javaScriptValues["URL"] as? String ?? ""
                    
                   
                    if let host = self?.url.host {
                        let defaults = UserDefaults.standard
                        let script = defaults.string(forKey: host) ?? ""
                        DispatchQueue.main.async {
                            self?.script.text = script
                        }
                    }

                    DispatchQueue.main.async {
                        self?.title = self?.pageTitle
                    }
                }
            }
        }
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    @objc func displayScript() {
        let ac = UIAlertController(title: "Choose a prerecorded script", message: nil, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Alert title", style: .default, handler: { [weak self] _ in
            self?.script.text = "alert(document.title);"
        }))
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(ac, animated: true)
    }
    
    @objc func adjustForKeyboard(notification: Notification) {
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        
        let keyboardScreenEndFrame = keyboardValue.cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
        
        
        if notification.name == UIResponder.keyboardWillHideNotification {
            script.contentInset = .zero
        } else {
            script.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height - view.safeAreaInsets.bottom, right: 0)
        }
        
        script.scrollIndicatorInsets = script.contentInset
        
        let selectedRange = script.selectedRange
        script.scrollRangeToVisible(selectedRange)
    }

    @IBAction func done() {
        let ac = UIAlertController(title: "Name your script", message: nil, preferredStyle: .alert)
        ac.addTextField()
        ac.addAction(UIAlertAction(title: "Validate", style: .default, handler: { [weak self] _ in
            let item = NSExtensionItem()
            let argument: NSDictionary = ["customJavaScript": self?.script.text]
            
            let defaults = UserDefaults.standard
            if let host = self?.url.host {
                defaults.set(self?.script.text, forKey: host)
            }

            
            
            let webDictionary: NSDictionary = [NSExtensionJavaScriptFinalizeArgumentKey: argument]
            let customJavaScript = NSItemProvider(item: webDictionary, typeIdentifier: kUTTypePropertyList as String)
            item.attachments = [customJavaScript]
            
            self?.extensionContext?.completeRequest(returningItems: [item])
        }))
        
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
                     
        present(ac, animated: true)
        
  
    }

}
