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
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Text("This app provides information related to 3 major cities in Canada: Toronto, Vancouver, and Montreal.")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundColor(Color.black)
                    .padding(.bottom, 10)
            }
            .padding(.vertical)
        }
    }
}

struct SavedDirectionsView_Previews: PreviewProvider {
    static var previews: some View {
        SavedDirectionsView()
    }
}
