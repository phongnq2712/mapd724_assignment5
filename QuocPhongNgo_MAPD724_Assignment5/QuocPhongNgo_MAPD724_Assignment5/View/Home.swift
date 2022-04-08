/**
 * MAPD724 - Assignment 5
 * File Name:    Home.swift
 * Author:         Quoc Phong Ngo
 * Student ID:   301148406
 * Version:        1.0
 * Date Modified:   April 8th, 2022
 */

import SwiftUI
import CoreLocation

struct Home: View {
    @StateObject var mapData = CustomMapViewModel()
    @State var locationManager = CLLocationManager()
    @State private var directions: [String] = []
    @State private var showDirections = false
    
    var body: some View {
        ZStack {
            CustomMapView(directions: $directions)
                .environmentObject(mapData)
                .ignoresSafeArea(.all, edges: .all)
            
            VStack {
                
                VStack(spacing: 0) {
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                        TextField("Choose Starting point", text: $mapData.searchTxt)
                            .colorScheme(.light)
                    }
                    .padding(.vertical, 10)
                    .padding(.horizontal)
                    .background(Color.white)
                    
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                        TextField("Choose Destination", text: $mapData.searchDestination)
                            .colorScheme(.light)
                    }
                    .padding(.top, 5)
                    .padding(.vertical, 10)
                    .padding(.horizontal)
                    .background(Color.white)
                    
                    VStack {
                        
                        Button(action: {
                            self.showDirections.toggle()
                        }, label: {
                            Text("Show Directions")
                        }).disabled(directions.isEmpty)
                            .padding([.top, .leading, .trailing, .bottom], 10)
                            .foregroundColor(Color.red)
                    }.sheet(isPresented: $showDirections, content: {
                        VStack {
                            Text("Directions")
                                .font(.largeTitle)
                                .bold()
                                .padding()
                            
                            Divider().background(Color.blue)
                            
                            List {
                                ForEach(0...self.directions.count - 1, id: \.self) {i in
                                    Text(self.directions[i])
                                        .padding()
                                }
                            }
                        }
                    })
                    
//                    HStack {
//                        Button(action: calculateRoute,
//                               label: {
//                            Text("Show Directions")
//                                .foregroundColor(Color.red)
//                        }).padding([.top, .leading, .trailing, .bottom], 10)
//                    }
                    
                    // display result
                    if !mapData.places.isEmpty {
                        if mapData.searchTxt != "", mapData.searchDestination == "" {
                            ScrollView {
                                VStack(spacing: 15) {
                                    ForEach(mapData.places) { place in
                                        Text(place.place.name ?? "")
                                            .foregroundColor(.black)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .padding(.leading)
                                            .onTapGesture {
                                                mapData.selectPlace(place: place, typeOfPlace: "start")
                                            }
                                        
                                        Divider()
                                    }
                                }
                                .padding(.top)
                            }
                            .background(Color.white)
                        } else if mapData.searchDestination != "" {
                            ScrollView {
                                VStack(spacing: 15) {
                                    ForEach(mapData.places) { place in
                                        Text(place.place.name ?? "")
                                            .foregroundColor(.black)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .padding(.leading)
                                            .onTapGesture {
                                                mapData.selectPlace(place: place, typeOfPlace: "destination")
                                            }
                                        
                                        Divider()
                                    }
                                }
                                .padding(.top)
                            }
                            .background(Color.white)
                        }
                    }
                    
                }.padding()
                
                Spacer()
                VStack {
//                    Button(action: mapData.focusLocation, label:{
//                        Image(systemName: "location.fill")
//                            .font(.title2)
//                            .padding(10)
//                            .background(Color.primary)
//                            .clipShape(Circle())
//                    })
                    
                    Button(action: mapData.updateMapType, label:{
                        Image(systemName: mapData.mapType == .standard ? "network" : "map")
                            .font(.title2)
                            .padding(10)
                            .background(Color.primary)
                            .clipShape(Circle())
                    })
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
            }
        }
        .onAppear(perform: {
            locationManager.delegate = mapData
            locationManager.requestWhenInUseAuthorization()
        })
        .alert(isPresented: $mapData.permissionDenied, content: {
            Alert(title: Text("Permission Denied"), message: Text("Please enable permission in App Settings"), dismissButton: .default(Text("Go to Settings"), action: {
                UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
            }))
        })
        .onChange(of: mapData.searchTxt, perform: { value in
            let delay = 0.3
            DispatchQueue.main.asyncAfter(deadline: .now() + delay)
            {
                if value == mapData.searchTxt {
                    self.mapData.searchQuery(searchType: "start")
                }
            }
        })
        .onChange(of: mapData.searchDestination, perform: { value in
            let delay = 0.3
            DispatchQueue.main.asyncAfter(deadline: .now() + delay)
            {
                if value == mapData.searchDestination {
                    self.mapData.searchQuery(searchType: "destination")
                }
            }
        })
    }
}

func calculateRoute() {
    
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
