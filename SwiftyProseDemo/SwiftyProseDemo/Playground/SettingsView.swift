//
//  SettingsView.swift
//  SwiftyProseDemo
//
//  Created by Marcel Opitz on 08.06.23.
//

import SwiftUI

struct SettingsView: View {
    
    @Binding var textColor: Color
    @Binding var linkColor: Color
    @Binding var headingTextColor: Color
    @Binding var nodeSpacing: CGFloat
    @Binding var paragraphLineSpacing: CGFloat
    @Binding var textFont: UIFont
    @Binding var headingFont: UIFont
    @Binding var linkFont: UIFont
    
    @State private var presentFontPicker: Bool = false
    
    var body: some View {
        List {
            
            ColorPicker(selection: $textColor) {
                Text("Change text color")
            }
            
            ColorPicker(selection: $linkColor) {
                Text("Change link color")
            }
            
            ColorPicker(selection: $headingTextColor) {
                Text("Change heading text color")
            }
            
            Stepper("Spacing between nodes", value: $nodeSpacing, in: 0...100)
            
            Stepper("Spacing between paragraph lines", value: $paragraphLineSpacing, in: 0...100)
            
            Button {
                textFont = UIFont.random(size: 16)
            } label: {
                Text("Random text font")
            }
            
            Button {
                headingFont = UIFont.random(size: 16)
            } label: {
                Text("Random heading font")
            }
            
            Button {
                linkFont = UIFont.random(size: 16)
            } label: {
                Text("Random link font")
            }

        }
    }
}

