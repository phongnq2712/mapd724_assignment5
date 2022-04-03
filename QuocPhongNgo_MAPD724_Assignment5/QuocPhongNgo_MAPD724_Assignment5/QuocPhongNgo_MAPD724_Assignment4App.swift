/**
 * MAPD724 - Assignment 4
 * File Name:    ContentView.swift
 * Author:         Quoc Phong Ngo
 * Student ID:   301148406
 * Version:        1.0
 * Date Modified:   March 20th, 2022
 */

import SwiftUI

@main
struct QuocPhongNgo_MAPD724_Assignment4App: App {
    @StateObject var themeManager = ThemeManager()
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(themeManager)
        }
    }
}
