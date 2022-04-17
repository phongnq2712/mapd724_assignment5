/**
 * MAPD724 - Assignment 5
 * File Name:    CustomMapView.swift
 * Author:         Quoc Phong Ngo
 * Student ID:   301148406
 * Version:        1.0
 * Date Modified:   April 8th, 2022
 */

import SwiftUI
import MapKit
import Firebase

struct CustomMapView: UIViewRepresentable {
    
    @EnvironmentObject var mapData: CustomMapViewModel
    @Binding var directions: [String]
    @State private var ref: DocumentReference? = nil
    @State private var db = Firestore.firestore()
    
    func makeCoordinator() -> Coordinator {
        return Coordinator()
    }
    
    func makeUIView(context: Context) -> MKMapView {
        let view = mapData.mapView
        view.showsUserLocation = false
        view.delegate = context.coordinator
        
        return view
    }
    
    func updateUIView(_ view: MKMapView, context: Context) {
        view.showsUserLocation = true
//        let p1 = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 12.23, longitude: 109.19))
        let p1 = MKPlacemark(coordinate: mapData.startPlace)
//        let p2 = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 10.82, longitude: 106.62))
        let p2 = MKPlacemark(coordinate: mapData.destinationPlace)
        
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: p1)
        request.destination = MKMapItem(placemark: p2)
        request.transportType = .automobile
        
        let directions = MKDirections(request: request)
        directions.calculate { response, error in
            guard let route = response?.routes.first else {
                return
            }
            view.addAnnotation(p1)
            view.addOverlay(route.polyline)
            view.setVisibleMapRect(route.polyline.boundingMapRect, edgePadding: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20), animated: true)
            self.directions = route.steps.map{$0.instructions}.filter{ !$0.isEmpty }
        }
        // add directions to Firebase
        if self.directions.count > 0 {
            db.collection("maps").whereField("start", isEqualTo: "A")
                .getDocuments() { (querySnapshot, err) in
                    if let err = err {
                        print("Error getting documents: \(err)")
                    } else {
                        if querySnapshot!.documents.count > 0 {
                            print("Already exists start - destination places")
                        } else {
    //                        for document in querySnapshot!.documents {
    //                            print("\(document.documentID) => \(document.data())")
    //                        }
                            self.ref = self.db.collection("maps").addDocument(data: [
                                "start": mapData.annotationStart,
                                "destination": mapData.annotationDestination,
                                "directions": self.directions
                            ]) { err in
                            if let err = err {
                                print("Error adding document: \(err)")
                            } else {
                                print("Document added with ID: \(ref!.documentID)")
                            }
                        }
                    }
                }
            }
        }
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            if annotation.isKind(of: MKUserLocation.self){return nil}
            else {
                let pinAnnotation = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "PIN_VIEW")
                pinAnnotation.tintColor = .red
                pinAnnotation.animatesDrop =  true
                pinAnnotation.canShowCallout = true

                return pinAnnotation
            }
        }
        
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            let renderer = MKPolylineRenderer(overlay: overlay)
            renderer.strokeColor = .blue
            renderer.lineWidth = 5
            
            return renderer
        }
    }
}
