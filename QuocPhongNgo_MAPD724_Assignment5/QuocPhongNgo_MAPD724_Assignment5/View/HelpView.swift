/**
 * MAPD724 - Assignment 5
 * File Name:    HelpView.swift
 * Author:         Quoc Phong Ngo
 * Student ID:   301148406
 * Version:        1.0
 * Date Modified:   April 15th, 2022
 */

import SwiftUI

struct HelpView: View {
    var body: some View {
        NavigationView {
            List {
                about
            }
            .font(.headline)
            .accentColor(.blue)
            .listStyle(GroupedListStyle())
            .navigationTitle("About")
            
        }
    }
}

extension HelpView {
    private var about : some View {
        Section(header: Text("")) {
            VStack(alignment: .leading) {
                Text("This app provides information related to 3 major cities in Canada: Toronto, Vancouver, and Montreal.")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundColor(Color.black)
                    .padding(.bottom, 10)
                Text("Besides, the app allows users to find routes as well as directions between 2 any places that they choose.")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundColor(Color.black)
                    .padding(.bottom, 10)
                Text("This app is written by SwiftUI, using WebKit, CoreLocation, and MapKit framework.")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundColor(Color.black)
            }
            .padding(.vertical)
        }
    }
}

struct HelpView_Previews: PreviewProvider {
    static var previews: some View {
        HelpView()
    }
}
