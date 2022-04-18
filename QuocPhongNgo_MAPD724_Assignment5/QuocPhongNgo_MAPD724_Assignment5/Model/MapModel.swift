/**
 * MAPD724 - Assignment 5
 * File Name:    MapModel.swift
 * Author:         Quoc Phong Ngo
 * Student ID:   301148406
 * Version:        1.0
 * Date Modified:   April 17th, 2022
 */

import SwiftUI

struct MapModel: Codable, Identifiable {
    var id: String = UUID().uuidString
    var start: String?
    var destination: String?
    var m_distance: Double?
    var m_directions: [String]?
}
