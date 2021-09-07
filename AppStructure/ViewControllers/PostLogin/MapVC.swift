//
//  MapVC.swift
//  AppStructure
//
//  Created by Admin on 06/09/21.
//

import UIKit
import MapKit
import CoreLocation

class MapVC: UIViewController {
    
    //MARK: Properties
    let locationManager = CLLocationManager()
    
    //MARK: IBOutlet
    @IBOutlet weak var mapView: MKMapView!
    
    //MARK: ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        mapView.showsUserLocation = true
        locationManager.startUpdatingLocation()
    }
    
    func render(_ location: CLLocation){
        let coordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        mapView.setRegion(region, animated: true)
        
        let pin = MKPointAnnotation()
        pin.coordinate = coordinate
        mapView.addAnnotation(pin)
    }
}

extension MapVC: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let locate = locations.first{
            locationManager.stopUpdatingLocation()
            render(locate)
        }
    }
}

extension MapVC : MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "AnnotationView")
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "AnnotationView")
        }
        
        if annotation === mapView.userLocation {
         
            let x = (annotationView?.center.x)!
            let y = (annotationView?.center.y)!
            
            let view = UIView(frame: CGRect(x: x-12, y: y-12.25, width: 60, height: 60))
            view.backgroundColor = .white
            view.layer.cornerRadius = 30
            view.layer.masksToBounds = true
            
            let outerView = UIView(frame: CGRect(x: x, y: y, width: 40, height: 40))
            outerView.backgroundColor = .blue
            outerView.layer.cornerRadius = 20
            outerView.alpha  = 0.5
            outerView.layer.masksToBounds = true
            
            let innerView = UIView(frame: CGRect(x: x, y: y, width: 36, height: 36))
            innerView.backgroundColor = .blue
            innerView.layer.cornerRadius = 18
            innerView.layer.masksToBounds = true
            
            annotationView!.insertSubview(view, belowSubview: innerView)
            annotationView?.insertSubview(outerView, belowSubview: view)
            annotationView?.insertSubview(innerView,aboveSubview: annotationView!)
                                
            UIView.animate(withDuration: 2, delay: 2, options: [.curveLinear,.repeat], animations: {
                outerView.transform = CGAffineTransform(scaleX: 3.6, y: 3.6)
                outerView.alpha  = 0.02
            })
            
            UIView.animate(withDuration: 2, delay: 2, options: [.autoreverse,.repeat], animations: {
            innerView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            })
        }
        
        annotationView?.canShowCallout = true
        annotationView?.annotation = annotation
        return annotationView
    }
}
