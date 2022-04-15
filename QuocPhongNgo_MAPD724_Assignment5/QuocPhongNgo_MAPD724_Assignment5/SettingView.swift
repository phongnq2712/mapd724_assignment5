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
                    themCount in
                    Button(action: {
                        withAnimation {
                            themeManager.applyTheme(themCount)
                        }
                    }, label: {
                        Text("Change \(themeManager.themes[themCount].themeName)")
                    })
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
