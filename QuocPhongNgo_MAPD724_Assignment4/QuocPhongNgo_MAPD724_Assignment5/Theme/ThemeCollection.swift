/**
 * MAPD724 - Assignment 4
 * File Name:    ThemeCollection.swift
 * Author:         Quoc Phong Ngo
 * Student ID:   301148406
 * Version:        1.0
 * Date Modified:   March 26th, 2022
 */

import SwiftUI

final class BlueTheme : Theme {
    var primaryColor: Color = Color("1-BlueColor")
    var labelColor: Color = Color("LabelColor")
    var themeName: String = "Blue Theme"
}

final class OrangeTheme : Theme {
    var primaryColor: Color = Color("2-OrangeColor")
    var labelColor: Color = Color("LabelColor")
    var themeName: String = "Orange Theme"
}

final class GreenTheme : Theme {
    var primaryColor: Color = Color("3-GreenColor")
    var labelColor: Color = Color("LabelColor")
    var themeName: String = "Green Theme"
}
