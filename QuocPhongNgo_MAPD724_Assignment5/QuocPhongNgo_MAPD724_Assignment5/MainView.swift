/**
 * MAPD724 - Assignment 5
 * File Name:    MainView.swift
 * Author:         Quoc Phong Ngo
 * Student ID:   301148406
 * Version:        1.0
 * Date Modified:   April 2nd, 2022
 */

import SwiftUI
import CoreData

struct MainView: View {
    @EnvironmentObject private var themeManager: ThemeManager
    
    var body: some View {
        ZStack {
//            Rectangle()
//                .foregroundColor(Color(red: 197/255,
//                    green: 231/255, blue: 255/255))
//                .edgesIgnoringSafeArea(.all)
            themeManager.selectedTheme.primaryColor.edgesIgnoringSafeArea(.all)
            
            VStack {
                                
                HStack {
                    Button(action:  {
                    
                    }) {
                        Image("toronto-1").resizable()
                            .frame(width: 265.0, height: 155.0)
                            .aspectRatio(1, contentMode: .fit)
                            .padding(.all, 10)
                            .background(Color.white.opacity(0.8))
                            .cornerRadius(10)
                        }.padding(.bottom, 10)
                }.padding([.leading, .trailing, .bottom], 10)
                
                HStack {
                    Button(action:  {
                    
                    }) {
                        Image("montreal").resizable()
                            .frame(width: 265.0, height: 155.0)
                            .aspectRatio(1, contentMode: .fit)
                            .padding(.all, 10)
                            .background(Color.white.opacity(0.8))
                            .cornerRadius(10)
                        }.padding(.bottom, 10)
                }.padding([.leading, .trailing, .bottom], 10)
                
                HStack {
                    Button(action:  {
                    
                    }) {
                        Image("vancouver").resizable()
                            .frame(width: 265.0, height: 155.0)
                            .aspectRatio(1, contentMode: .fit)
                            .padding(.all, 10)
                            .background(Color.white.opacity(0.8))
                            .cornerRadius(10)
                        }.padding(.bottom, 10)
                }.padding([.leading, .trailing, .bottom], 10)
                
                HStack {
                    Button(action:  {
                    
                    }) {
                    Image("google-maps").resizable()
                        .frame(width: 125.0, height: 65.0)
                        .aspectRatio(1, contentMode: .fit)
                        .background(Color.white.opacity(0.8))
                        .cornerRadius(10)
                        .padding(.all, 10)
                    }
                }
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
