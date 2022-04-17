/**
 * MAPD724 - Assignment 5
 * File Name:    ThemeManager.swift
 * Author:         Quoc Phong Ngo
 * Student ID:   301148406
 * Version:        1.0
 * Date Modified:   April 16th, 2022
 */

import SwiftUI
import FirebaseFirestore

class ThemeManager: ObservableObject {
    
    @AppStorage("selectedTheme") var themeSelected = 0
    static let shared = ThemeManager()
    public var themes:[Theme] = [BlueTheme(), OrangeTheme(), GreenTheme()]
    @Published var selectedTheme: Theme = BlueTheme()
    private var db = Firestore.firestore()
    let themeColorID = "Z1G45bzPUUJFTtiRANu9"
    
    init() {
        self.getTheme()
    }
    
    public func applyTheme(_ theme:Int) {
        self.selectedTheme = self.themes[theme]
    }
    
//    func getTheme() {
//        self.selectedTheme = self.themes[themeSelected]
//    }
    
    /**
     * Update themeId
     */
    func updateTheme(themeIndex: Int) {
        let db = Firestore.firestore()
        let ref = db.collection("theme_color").document(self.themeColorID)

        // update themeID in 'theme_color' collection
        ref.updateData([
            "themeID": themeIndex
        ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
            }
        }
    }
    
    /**
     * Read data from Firebase Firestore
     */
    func getTheme() {
        let docRef = db.collection("theme_color").document(self.themeColorID)

        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                var dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                let themeID = (dataDescription.components(separatedBy: ":")[1].dropLast() as NSString).integerValue
                self.selectedTheme = self.themes[themeID]
            } else {
                print("Document does not exist")
            }
        }
    }
    
}
