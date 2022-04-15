/**
 * MAPD724 - Assignment 5
 * File Name:    ContentView.swift
 * Author:         Quoc Phong Ngo
 * Student ID:   301148406
 * Version:        1.0
 * Date Modified:   April 15th, 2022
 */

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject private var themeManager: ThemeManager

    var body: some View {
        NavigationView {
            ZStack {
//            Rectangle()
//                .foregroundColor(Color(red: 197/255,
//                    green: 231/255, blue: 255/255))
//                .edgesIgnoringSafeArea(.all)
                themeManager.selectedTheme.primaryColor.edgesIgnoringSafeArea(.all)
            
                VStack {
                    HStack {
                        Text("Take a round")
                            .bold()
                            .italic()
                            .foregroundColor(Color(red: 137/255, green: 80/255, blue: 23/255))
                    }.scaleEffect(2)
                    .padding(.bottom, 20)
                    HStack {
                        Text("Canada")
                            .font(Style.TextSize.bigTitle.font(.semiBold))
                            .bold()
                            .foregroundColor(Color(red: 137/255, green: 80/255, blue: 23/255))
                    }.scaleEffect(2)
                    HStack {
                        // picture
                        Image("Toronto").resizable()
                            .frame(width: 295.0, height: 195.0)
                            .aspectRatio(1, contentMode: .fit)
                            .background(Color.white.opacity(0.8))
                            .cornerRadius(20)
                            .padding(.all, 20)
                    }
                    HStack {
                        NavigationLink(destination:MainView(), label: {
                            // Start Button
                            Text("START")
                            .font(Style.TextSize.subtitle3.font(.semiBold))
                            .foregroundColor(.accentColor)
                            .frame(width: 125, height: 36, alignment: .center)
                            .accentColor(.white)
                            .background(RoundedRectangle(cornerRadius: 24,
                            style: .continuous).fill(Color.blue))
                        })
                    }.padding(.bottom, 30)
                    HStack {
                        // Setting Button
                        NavigationLink(destination:SettingView(), label: {
                            // Start Button
                            Text("SETTINGS")
                            .font(Style.TextSize.subtitle3.font(.semiBold))
                            .accentColor(.white)
                            .foregroundColor(Color.accentColor)
                            .frame(width: 125, height: 36, alignment: .center)
                            .background(RoundedRectangle(cornerRadius: 24,
                                style: .continuous).fill(Color.red))
                        }).padding(.bottom, 30)
                    }
                    HStack {
                        // Help Button
                        NavigationLink(destination:HelpView(), label: {
                            // Start Button
                            Text("HELP")
                            .font(Style.TextSize.subtitle3.font(.semiBold))
                            .accentColor(.white)
                            .foregroundColor(Color.accentColor)
                            .frame(width: 125, height: 36, alignment: .center)
                            .background(RoundedRectangle(cornerRadius: 24,
                                                         style: .continuous).fill(Color.brown))
                        }).padding(.bottom, 100)
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
