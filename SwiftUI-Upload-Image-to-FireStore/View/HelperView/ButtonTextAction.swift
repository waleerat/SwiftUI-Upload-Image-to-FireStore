//
//  ButtonTextAction.swift
//  StampBankAdmin
//
//  Created by Waleerat Gottlieb on 2021-07-19.
//

import SwiftUI

struct ButtonTextAction: View {
    
    @Binding var buttonLabel: String
    @Binding var isActive: Bool
    @State var foregroundColor:Color = Color(kScreenBackground)
    @State var backgroundColor:Color = .accentColor
    @State var frameWidth: CGFloat = 200
   
    
    var action: () -> Void
    var body: some View {
        Button(action: action , label: {
            Text(buttonLabel)
                .font(.system(size: getFontSize(fontStyle: .common) ,weight: .regular, design: .rounded))
                .foregroundColor(foregroundColor)
                .padding(.vertical, 7)
                .frame(width: frameWidth)
                .background(backgroundColor.opacity(isActive ? 1 : 0.5))
                .clipShape(Capsule())
        })
    }
}
 
