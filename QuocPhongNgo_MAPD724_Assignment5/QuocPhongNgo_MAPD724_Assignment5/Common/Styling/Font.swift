/**
 * MAPD724 - Assignment 4
 * File Name:    Font.swift
 * Author:         Quoc Phong Ngo
 * Student ID:   301148406
 * Version:        1.0
 * Date Modified:   March 20th, 2022
 */

import UIKit
import SwiftUI

struct CustomFont {

    enum Name: String {

        case poppins = "Poppins"
    }

    enum Style {

        case regular
        case semiBold
    }

    static func withSize(_ size: CGFloat, style: Style) -> Font {

        var fontName: String

        switch style {

        case .regular:
            fontName = "Poppins-Regular"

        case .semiBold:
            fontName = "Poppins-SemiBold"
        }

        return Font.custom(fontName, size: size)
    }
}
