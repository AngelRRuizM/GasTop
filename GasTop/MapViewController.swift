//
//  MapViewController.swift
//  GasTop
//
//  Created by Alumno on 10/21/18.
//  Copyright © 2018 Gekko. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var map: MKMapView!
    
    var manager = CLLocationManager();
    var gasStations: [GasStation] = [];
    var currentUserLocation: CLLocationCoordinate2D?;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        map.delegate = self;
        manager.delegate = self;
        
        if manager.responds(to: #selector(CLLocationManager.requestWhenInUseAuthorization)) {
            manager.requestWhenInUseAuthorization();
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        
        GasStation.getExistingStations(callback: getGasStations);
        
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        super.viewWillDisappear(animated)
    }
    
    //MARK: MapViewDelegate Functions
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        let region = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 700, 700);
        map.setRegion(region, animated: true);
    }
    
    //Does segue to gas station details if the annotation selected is a GasStation
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if let station = view.annotation as? GasStation {
            self.performSegue(withIdentifier: "toGasStationDetails", sender: station)

        }
    }

    //For annotations displaying the gas station icon. However, it removes the title
    /*func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let gasStation = annotation as? GasStation else {
            return nil;
        }
        
        let reuseId = "reviewAnnotationView";
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId)
        //Create new annotation view if cannot reuse one
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseId);
            annotationView?.canShowCallout = true;
        }
        else {
            annotationView!.annotation = annotation;
        }
        
        //Set annotation-specific properties **AFTER**
        //the view is dequeued or created...
        
        annotationView?.image = UIImage(named: gasStation.mapIconName);
        
        return annotationView;
    }
    */

    //MARK: Map Data functions
    func getGasStations(_ stations: [GasStation]) {
        gasStations.removeAll();
        
        gasStations.append(contentsOf: stations);
        setGasStationAnnotations();
    }
    
    func setGasStationAnnotations() {
        map.removeAnnotations(map.annotations);
        
        for station in gasStations {
            map.addAnnotation(station);
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let targetVC = segue.destination as? GasSationViewController {
            
            guard let gasStation = (sender as Any) as? GasStation else {
                fatalError("GasSation not passed correctly in segue as Sender");

            }
            targetVC.gasStationId = gasStation.id;
        
            targetVC.sceneMode = .View;
        }
    }

}
