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
    
    func updateMapType() {
        if mapType == .standard {
            mapType = .hybrid
            mapView.mapType = mapType
        } else {
            mapType = .standard
            mapView.mapType = mapType
        }
    }
    
    func focusLocation() {
        guard let _ = region else {return}
        mapView.setRegion(region, animated: true)
        mapView.setVisibleMapRect(mapView.visibleMapRect, animated: true)
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
