/**
 * MAPD724 - Assignment 4
 * File Name:    Theme.swift
 * Author:         Quoc Phong Ngo
 * Student ID:   301148406
 * Version:        1.0
 * Date Modified:   March 26th, 2022
 */

import SwiftUI

protocol Theme {
    var primaryColor: Color {get set}
    var labelColor: Color {get set}
    var themeName: String {get set}
}
