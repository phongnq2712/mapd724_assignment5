/**
 * MAPD724 - Assignment 5
 * File Name:    CustomMapViewModel.swift
 * Author:         Quoc Phong Ngo
 * Student ID:   301148406
 * Version:        1.0
 * Date Modified:   April 8th, 2022
 */

import SwiftUI
import MapKit
import CoreLocation
import Firebase

class CustomMapViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var mapView = MKMapView()
    
    @Published var region: MKCoordinateRegion!
    
    @Published var permissionDenied = false
    
    @Published var mapType: MKMapType = .standard
    
    @Published var searchTxt = ""
    
    @Published var searchDestination = ""
    
    @Published var places: [Place] = []
    
    @Published var startPlace = CLLocationCoordinate2D()
    
    @Published var destinationPlace = CLLocationCoordinate2D()
    
    @Published var annotationStart = ""
    @Published var annotationDestination = ""
    @Published var startArr = [String]()
    @Published var destinationArr = [String]()
    @Published var directionsMap: [Int: MapModel] = [Int: MapModel]()
    
    func updateMapType() {
        if mapType == .standard {
            mapType = .hybrid
            mapView.mapType = mapType
        } else {
            mapType = .standard
            mapView.mapType = mapType
        }
    }
    
//    func focusLocation() {
//        guard let _ = region else {return}
//        mapView.setRegion(region, animated: true)
//        mapView.setVisibleMapRect(mapView.visibleMapRect, animated: true)
//    }
    override init() {
        super.init()
        self.loadDirections()
    }
    
    func loadDirections() {
        let db = Firestore.firestore()
        var md  = MapModel()
        db.collection("maps").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                var i = 0
                var j = 0
                for document in querySnapshot!.documents {
                    if document.data().count > 0 {
                        for (key,value) in document.data() {
                            if i%4 == 0 {
                                md = MapModel()
                            }
                            if key == "start" {
                                md.start = value as? String
                            } else if key == "destination" {
                                md.destination = value as? String
                            } else if key == "distance" {
                                md.m_distance = value as? Double
                            } else {
                                md.m_directions = value as? [String]
                            }
                            if i%4 == 3 {
                                self.directionsMap[j] = md
                            }
                            i += 1
                        }
                    }
                    j += 1
                }
            }
        }
    }
    
    func searchQuery(searchType: String) {
        places.removeAll()
        let request = MKLocalSearch.Request()
        if searchType == "start" {
            request.naturalLanguageQuery = searchTxt
        } else if searchType == "destination" {
            request.naturalLanguageQuery = searchDestination
        }
        
        
        MKLocalSearch(request: request).start{(response, _) in
            guard let result = response else {return}
            self.places = result.mapItems.compactMap({ (item) -> Place? in
                return Place(place: item.placemark)
            })
        }
    }
    
    func selectPlace(place: Place, typeOfPlace: String) {
        self.places = []
        guard let coordinate = place.place.location?.coordinate else {return}
        
        if typeOfPlace == "start" {
            self.startPlace = coordinate
        } else if typeOfPlace == "destination" {
            print(mapView.annotations.count)
            self.destinationPlace = coordinate
            // TODO
            if !mapView.annotations.isEmpty, mapView.annotations.count == 2 {
                mapView.removeAnnotation(mapView.annotations[1])
            }
        }
        
        let pointAnnotation = MKPointAnnotation()
        pointAnnotation.coordinate = coordinate
        pointAnnotation.title = place.place.name ?? "No Name"
        if typeOfPlace == "start" {
            self.annotationStart = pointAnnotation.title ?? ""
        } else if typeOfPlace == "destination" {
            self.annotationDestination = pointAnnotation.title ?? ""
        }
        
//        mapView.removeAnnotations(mapView.annotations)
        mapView.addAnnotation(pointAnnotation)
        
        // Moving map to that location
        var coordinateRegion = MKCoordinateRegion()
        if typeOfPlace == "start" {
            coordinateRegion = MKCoordinateRegion(center: self.startPlace, latitudinalMeters: 10000, longitudinalMeters: 10000)
        } else if typeOfPlace == "destination" {
            coordinateRegion = MKCoordinateRegion(center: self.destinationPlace, latitudinalMeters: 10000, longitudinalMeters: 10000)
        }
        
        mapView.setRegion(coordinateRegion, animated: true)
        mapView.setVisibleMapRect(mapView.visibleMapRect, animated: true)
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .denied:
            permissionDenied.toggle()
        case .notDetermined:
            // Requesting...
            manager.requestWhenInUseAuthorization()
        case .authorizedWhenInUse:
            manager.requestLocation()
        default:
            ()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {return}
        
        self.region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
        
        self.mapView.setRegion(self.region, animated: true)
        self.mapView.setVisibleMapRect(self.mapView.visibleMapRect, animated: true)
    }
}
