//
//  ViewController.swift
//  Project16
//
//  Created by Paul-Louis Renard on 31/10/2021.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {
    @IBOutlet var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .organize, target: self, action: #selector(chooseMapType))
        
        let london = Capital(title: "London", coordinate: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), info: "Home to the 2012 Summer Olympics", url: URL(string: "https://en.wikipedia.org/wiki/London")!)
        let oslo = Capital(title: "Oslo", coordinate: CLLocationCoordinate2D(latitude: 59.95, longitude: 10.75), info: "Founded over a thousand years ago.", url: URL(string: "https://en.wikipedia.org/wiki/Oslo")!)
        let paris = Capital(title: "Paris", coordinate: CLLocationCoordinate2D(latitude: 48.8567, longitude: 2.3508), info: "Often called the City of Light", url: URL(string: "https://en.wikipedia.org/wiki/Paris")!)
        let rome = Capital(title: "Rome", coordinate: CLLocationCoordinate2D(latitude: 41.9, longitude: 12.5), info: "Has a whole country inside it", url: URL(string: "https://en.wikipedia.org/wiki/Rome")!)
        let washington = Capital(title: "Washington DC", coordinate: CLLocationCoordinate2D(latitude: 38.895111, longitude: -77.036667), info: "Named after George himself", url: URL(string: "https://en.wikipedia.org/wiki/Washington,_D.C.")!)
        
        mapView.addAnnotations([london, oslo, paris, rome, washington])
    }
    
    @objc func chooseMapType() {
        let ac = UIAlertController(title: "Choose a map type", message: nil, preferredStyle: .alert)
        
        let names = ["standard", "satellite", "hybrid", "satelliteFlyover", "hybridFlyover", "mutedStandard"]
        
        for name in names {
            ac.addAction(UIAlertAction(title: name, style: .default, handler: { [weak self] alertAction in
                guard let self = self else { return }
                switch alertAction.title {
                case "standard":
                    self.mapView.mapType = .standard
                    break;
                case "satellite":
                    self.mapView.mapType = .satellite
                    break;
                case "hybrid":
                    self.mapView.mapType = .hybrid
                    break;
                case "satelliteFlyover":
                    self.mapView.mapType = .satelliteFlyover
                    break;
                case "hybridFlyover":
                    self.mapView.mapType = .hybridFlyover
                    break;
                case "mutedStandard":
                    self.mapView.mapType = .mutedStandard
                    break;
                default:
                    break;
                }
            }))
        }
        present(ac, animated: true)
        
        
    }

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is Capital else { return nil }
        
        let identifier = "Capital"
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView
        
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
            
            let btn = UIButton(type: .detailDisclosure)
            annotationView?.rightCalloutAccessoryView = btn
        } else {
            annotationView?.annotation = annotation
        }
        
        annotationView?.pinTintColor = UIColor.green
        
        return annotationView
        
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let capital = view.annotation as? Capital else { return }
        
        let url = capital.url
        
        let wvc = WebViewController()
        wvc.url = url
        
        navigationController?.pushViewController(wvc, animated: true)
        
//        let placeName = capital.title
//        let placeInfo = capital.info
//
//        let ac = UIAlertController(title: placeName, message: placeInfo, preferredStyle: .alert)
//        ac.addAction(UIAlertAction(title: "OK", style: .default))
//
//        present(ac, animated: true)
    }

}

