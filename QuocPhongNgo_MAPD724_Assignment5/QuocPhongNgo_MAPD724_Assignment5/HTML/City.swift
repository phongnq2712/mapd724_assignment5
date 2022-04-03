/**
 * MAPD724 - Assignment 5
 * File Name:    City.swift
 * Author:         Quoc Phong Ngo
 * Student ID:   301148406
 * Version:        1.0
 * Date Modified:   April 3rd, 2022
 */

import SwiftUI
import WebKit

enum WebViewError: Error {
    case contentConversion(String)
    case emptyFileName
    case invalidFilePath
    
    var message: String {
        switch self {
        case let .contentConversion(message):
            return "There was an error converting the file path to an HTML String. Error:\(message)"
        case .emptyFileName:
            return "The file name was empty"
        case let .invalidFilePath:
            return "The path is invalid"
        }
    }
}

struct WebView: UIViewRepresentable {
    let htmlFileName: String
    let onError: (WebViewError) -> Void
    
    private let webView = WKWebView()
    
    func makeUIView(context: Context) -> some UIView {
        return webView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        webView.load(htmlFileName, onError: onError)
    }
}

extension WKWebView {
    func load(_ htmlFileName: String, onError: (WebViewError) -> Void) {
        guard !htmlFileName.isEmpty else {
            return onError(.emptyFileName)
        }
        
        guard let filePath = Bundle.main.path(forResource: htmlFileName, ofType: "html") else {
            return onError(.invalidFilePath)
        }
        let url = URL(fileURLWithPath: filePath)
        do {
            let htmlString = try String(contentsOfFile: filePath, encoding: .utf8)
            loadHTMLString(htmlString, baseURL: URL(fileURLWithPath: filePath))
        } catch let error {
            onError(.contentConversion(error.localizedDescription))
        }
    }
}

struct City: View {
    var flag: Int
    var body: some View {
        if flag == 1 {
            WebView(htmlFileName: "Toronto", onError: { error in
                print(error.message)
            })
        } else if flag == 2 {
            WebView(htmlFileName: "Montreal", onError: { error in
                print(error.message)
            })
        } else if flag == 3 {
            WebView(htmlFileName: "Vancouver", onError: { error in
                print(error.message)
            })
        }
        
    }
}

struct City_Previews: PreviewProvider {
    static var previews: some View {
        City(flag: 1)
    }
}
