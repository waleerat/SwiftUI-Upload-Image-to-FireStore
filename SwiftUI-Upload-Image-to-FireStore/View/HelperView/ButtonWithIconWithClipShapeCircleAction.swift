//
//  ButtonWithIconWithClipShapeCircleAction.swift
//  WhatIsThis-WGO
//
//  Created by Waleerat Gottlieb on 2021-09-18.
//

import SwiftUI
 
struct ButtonWithIconWithClipShapeCircleAction: View {
    var systemName:String? 
    
    var action: () -> Void
    var body: some View {
        Button(action: action , label: {
             
            if let systemName = systemName {
                Image(systemName: systemName)
                    .foregroundColor(.accentColor)
                    .padding()
                    .background(Color.accentColor.opacity(0.3))
                    .clipShape(Circle())
                   
            }
        })
    }
}
