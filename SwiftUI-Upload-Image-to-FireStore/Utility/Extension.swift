//
//  Extension.swift
//  MVVM-and-Design-Pattern
//
//  Created by Waleerat Gottlieb on 2021-09-23.
//

import Foundation
import SwiftUI

extension View{
#if canImport(UIKit)
func hideKeyboard() {
UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
}
#endif
}


extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
 
   func widthOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.width
    }
}
