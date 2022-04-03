/**
 * MAPD724 - Assignment 4
 * File Name:    Style.swift
 * Author:         Quoc Phong Ngo
 * Student ID:   301148406
 * Version:        1.0
 * Date Modified:   March 20th, 2022
 */

import UIKit
import SwiftUI

public struct Style {

    enum Spacing {

        static let medium: CGFloat = 12.0
        static let tall: CGFloat = 16.0
        static let normal: CGFloat = 24.0
    }

    enum TextSize {

        /// 45
        case extraHuge
        /// 40
        case huge
        /// 36
        case doubleHeader
        /// 28
        case header
        /// 26
        case bigHeader
        /// 24
        case title3
        /// 22
        case bigTitle
        /// 20
        case subtitle20
        /// 18
        case subtitle
        /// 16
        case subtitle2
        /// 15
        case title4
        /// 14
        case subtitle3
        /// 13
        case title2
        /// 12
        case subtitle6
        /// 11
        case subtitle4
        /// 10
        case subtitle5
        /// 8
        case subtitle7
        /// 9
        case badge

        private var size: CGFloat {

            switch self {
            case .extraHuge:
                return 45.0
            case .huge:
                return 40.0
            case.doubleHeader:
                return 36.0
            case .header:
                return 28.0
            case .bigHeader:
                return 26.0
            case .title3:
                return 24
            case .bigTitle:
                return 22.0
            case .subtitle20:
                return 20
            case .subtitle:
                return 18.0
            case .subtitle2:
                return 16.0
            case .title4:
                return 15
            case .subtitle3:
                return 14.0
            case .title2:
                return 13
            case .subtitle6:
                return 12
            case .subtitle4:
                return 11
            case .subtitle5:
                return 10
            case .subtitle7:
                return 8
            case .badge:
                return 9
            }
        }

        func font(_ style: CustomFont.Style) -> Font {

            return CustomFont.withSize(size, style: style)
        }
    }
}
