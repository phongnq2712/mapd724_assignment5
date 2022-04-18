/**
 * MAPD724 - Assignment 5
 * File Name:    SavedDirectionsView.swift
 * Author:         Quoc Phong Ngo
 * Student ID:   301148406
 * Version:        1.0
 * Date Modified:   April 17th, 2022
 */

import SwiftUI

struct SavedDirectionsView: View {
    @StateObject var mapData = CustomMapViewModel()
    
    var body: some View {
        VStack {
            Text("Directions")
                .font(.headline)
                .bold()
                .padding()
            
            Divider().background(Color.blue)
            
            List {
                if mapData.directionsMap.count > 0 {
                    ForEach(0..<mapData.directionsMap.count, id: \.self) {i in
                        let mData = mapData.directionsMap[i]
                        Text("Start: ").foregroundColor(Color.blue)
                        Text(mData?.start ?? "")
                            .padding()
                        Text("Destination: ").foregroundColor(Color.blue)
                        Text(mData?.destination ?? "")
                            .padding()
                        Text("Distance: ").foregroundColor(Color.blue)
                        Text(String(format: "%.2f", mData?.m_distance as! CVarArg))
                            .padding()

                        Divider().background(Color.blue)
                    }
                }
                
            }
        }
    }
}

struct SavedDirectionsView_Previews: PreviewProvider {
    static var previews: some View {
        SavedDirectionsView()
    }
}
