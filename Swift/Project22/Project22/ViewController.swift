//
//  ViewController.swift
//  Project22
//
//  Created by Paul-Louis Renard on 16/12/2021.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    var locationManager: CLLocationManager?
    var isFirstDetecting: Bool = true

    @IBOutlet weak var circleView: UIView!
    @IBOutlet var distanceReading: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestAlwaysAuthorization()
        
        view.backgroundColor = .gray
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways {
            if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) {
                if CLLocationManager.isRangingAvailable() {
                    startScanning()
                }
            }
        }
    }
    
    func startScanning() {
        let uuid = UUID(uuidString: "5A4BCFCE-174E-4BAC-A814-092E77F6B7E5")!
        let beaconRegion = CLBeaconRegion(proximityUUID: uuid, major: 123, minor: 456, identifier: "MyBeacon")
        
        locationManager?.startMonitoring(for: beaconRegion)
        locationManager?.startRangingBeacons(in: beaconRegion)
    }
    
    func displayFirstAlertController() {
        if isFirstDetecting {
            let controller = UIAlertController(title: "Information", message: "First detect beacon", preferredStyle: .alert)
            controller.addAction(UIAlertAction(title: "OK", style: .default))
            present(controller, animated: true)
            isFirstDetecting = false
        }
        
    }
    
    func update(distance: CLProximity) {
        UIView.animate(withDuration: 1) {
            switch distance {
            case .immediate:
                self.view.backgroundColor = .red
                self.distanceReading.text = "RIGHT HERE"
                self.displayFirstAlertController()
            case .near:
                self.view.backgroundColor = .orange
                self.distanceReading.text = "NEAR"
                self.displayFirstAlertController()
            case .far:
                self.view.backgroundColor = .blue
                self.distanceReading.text = "FAR"
                self.displayFirstAlertController()
                
            default:
                self.view.backgroundColor = .gray
                self.distanceReading.text = "UNKOWN"
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
        if let beacon = beacons.first {
            update(distance: beacon.proximity)
        } else {
            update(distance: .unknown)
        }
    }


}

