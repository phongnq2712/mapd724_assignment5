/**
 * MAPD724 - Assignment 5
 * File Name:    ThemeModel.swift
 * Author:         Quoc Phong Ngo
 * Student ID:   301148406
 * Version:        1.0
 * Date Modified:   April 16th, 2022
 */

import SwiftUI

struct ThemeModel: Codable, Identifiable {
    var id: String = UUID().uuidString
    var themeID: Int?
}
