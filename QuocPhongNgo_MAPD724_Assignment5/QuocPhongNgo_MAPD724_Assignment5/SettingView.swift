/**
 * MAPD724 - Assignment 5
 * File Name:    SettingView.swift
 * Author:         Quoc Phong Ngo
 * Student ID:   301148406
 * Version:        1.0
 * Date Modified:   April 15th, 2022
 */

import SwiftUI
import CoreData

struct SettingView: View {
    @EnvironmentObject private var themeManager: ThemeManager
    @State private var showingAlert = false
    
    var body: some View {
        NavigationView {
            List {
                changeTheme
            }
            .font(.headline)
            .accentColor(.blue)
            .listStyle(GroupedListStyle())
            .navigationTitle("Settings")
            
        }
    }
}

extension SettingView {
    private var changeTheme : some View {
        Section(header: Text("Theme color")) {
            VStack(alignment: .leading) {
                ForEach(0..<themeManager.themes.count) {
                    themeCount in
                    Button(action: {
                        withAnimation {
                            showingAlert = true
                            themeManager.applyTheme(themeCount)
                            // save theme into firebase
                            themeManager.updateTheme(themeIndex: themeCount)
                        }
                    }, label: {
                        Text("Change \(themeManager.themes[themeCount].themeName)")
                    }).alert("Save theme color successfully!", isPresented: $showingAlert) {
                        Button("OK", role: .cancel) { }
                    }
                }
                .buttonStyle(.bordered)
                .buttonBorderShape(.roundedRectangle)
                .tint(.gray)
            }
            .padding(.vertical)
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        MainView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
