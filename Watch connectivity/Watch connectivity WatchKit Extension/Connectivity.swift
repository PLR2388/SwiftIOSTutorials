//
//  Connectivity.swift
//  Watch connectivity
//
//  Created by Paul-Louis Renard on 11/09/2021.
//

import Foundation
import WatchConnectivity
import ClockKit

func getDocumentsDirectory() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return paths[0]
}

class Connectivity: NSObject, ObservableObject, WCSessionDelegate {
    
    @Published var receivedText = ""
    
    #if os(iOS)
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        // Called after connection done
        // One can check activationState to see if it's effective
        DispatchQueue.main.async {
            if activationState == .activated {
                if session.isWatchAppInstalled {
                    self.receivedText = "Watch app is installed!"
                }
            }
        }
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        
    }
    
    func updateComplication(with data: [String: Any]) {
        let session = WCSession.default
        
        if session.activationState == .activated && session.isComplicationEnabled {
            session.transferCurrentComplicationUserInfo(data)
            receivedText = "Attempt to send complication data. Remaining transfers: \(session.remainingComplicationUserInfoTransfers)"
        }
    }
    
    #else
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
    #endif
    
    func session(_ session: WCSession, didReceiveUserInfo userInfo: [String : Any] = [:]) {
        DispatchQueue.main.async {
            if let text = userInfo["text"] as? String {
                // Currently cannot be tested on simulator
                // Work on real device according to hackingWithSwift
                self.receivedText = text
            } else {
                #if os(watchOS)
                if let number = userInfo["number"] as? String {
                    UserDefaults.standard.set(number, forKey: "complication_number")
                    let server = CLKComplicationServer.sharedInstance()
                    guard let complications = server.activeComplications else {
                        return
                    }
                    for complication in complications {
                        server.reloadTimeline(for: complication)
                    }
                }
                #endif
            }
        }
    }
    
    // Guarranty the delivery of the data but might not be immediate
    // Common choice and fast enough for most people
    func transferUserInfo(_ userInfo: [String: Any]) {
        let session = WCSession.default
        
        if session.activationState == .activated {
            session.transferUserInfo(userInfo)
        }
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any], replyHandler: @escaping ([String : Any]) -> Void) {
        DispatchQueue.main.async {
            if let text = message["text"] as? String {
                self.receivedText = text
                // One can reply to a message if we don't, one must use the other form
                replyHandler(["response": "Be excellent to each other"])
            }
        }
    }
    
    // Instant but not guaranteed
    func sendMessage(_ data: [String: Any]) {
        let session = WCSession.default
        
        if session.isReachable {
            session.sendMessage(data){ response in
                DispatchQueue.main.async {
                    self.receivedText = "Received response: \(response)"
                }
            }
        }
    }
    
    func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String : Any]) {
        DispatchQueue.main.async {
            self.receivedText = "Application context received: \(applicationContext)"
        }
    }
    
    // Guaranty delivery, will happen and throws error in that doesn't work
    // Keep only the last send
    // Transfer application state
    func setContext(to data: [String: Any]) {
        let session = WCSession.default
        
        if session.activationState == .activated {
            do {
                try session.updateApplicationContext(data)
            } catch {
                receivedText = "Alert! Updating app context failed"
            }
        }
    }
    
    func session(_ session: WCSession, didReceive file: WCSessionFile) {
        let fm = FileManager.default
        let destURL = getDocumentsDirectory().appendingPathComponent("saved_file")
        
        do{
            if fm.fileExists(atPath: destURL.path) {
                try fm.removeItem(at: destURL)
            }
            
            try fm.copyItem(at: file.fileURL, to: destURL)
            let contents = try String(contentsOf: destURL)
            receivedText = "Received File: \(contents)"
        } catch {
            receivedText = "File copy failed"
        }
    }
    
    func sendFile(_ url: URL) {
        let session = WCSession.default
        
        if session.activationState == .activated {
            session.transferFile(url, metadata: nil)
        }
    }

    
    override init() {
        super.init()
        
        if WCSession.isSupported() {
            let session = WCSession.default
            session.delegate = self
            session.activate()
        }
    }
}
