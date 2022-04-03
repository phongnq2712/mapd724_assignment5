/**
 * MAPD724 - Assignment 4
 * File Name:    ThemeManager.swift
 * Author:         Quoc Phong Ngo
 * Student ID:   301148406
 * Version:        1.0
 * Date Modified:   March 26th, 2022
 */

import SwiftUI

class ThemeManager: ObservableObject {
    
    @AppStorage("selectedTheme") var themeSelected = 0
    static let shared = ThemeManager()
    public var themes:[Theme] = [BlueTheme(), OrangeTheme(), GreenTheme()]
    @Published var selectedTheme: Theme = BlueTheme()
    
    init() {
        getTheme()
    }
    
    public func applyTheme(_ theme:Int) {
        self.selectedTheme = self.themes[theme]
    }
    
    func getTheme() {
        self.selectedTheme = self.themes[themeSelected]
    }
}
