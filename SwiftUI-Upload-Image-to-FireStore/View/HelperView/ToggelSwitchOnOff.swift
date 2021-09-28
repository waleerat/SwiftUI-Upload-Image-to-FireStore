//
//  ToggelSwitchOnOff.swift
//  Sawasdee By WGO
//
//  Created by Waleerat Gottlieb on 2021-09-07.
//

import SwiftUI

struct ToggelSwitchOnOff: View {
    @Binding var isActive:Bool
    @State var isDisable:Bool = false
    @State var title:String = ""
    
    var body: some View {
        // Note: - On/Off icon
        Toggle(isOn: $isActive){
            HStack {
                Text(title)
                    .modifier(TextBoldModifier(fontStyle: .common))
                Spacer()
            }
        }
        .disabled(isDisable)
        .toggleStyle(CheckmarkToggleStyle()) 
    }
}

struct ToggelSwitchOnOff_Previews: PreviewProvider {
    static var previews: some View {
        ToggelSwitchOnOff(isActive: .constant(false))
    }
}


struct CheckmarkToggleStyle: ToggleStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.label
            Spacer()
            Rectangle()
                .foregroundColor(configuration.isOn ? .green : .gray)
                .frame(width: 40, height: 25, alignment: .center)
                .overlay(
                    Circle()
                        .foregroundColor(.white)
                        .padding(.all, 3)
                        .overlay(
                            Image(systemName: configuration.isOn ? "checkmark" : "xmark")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .font(Font.title.weight(.black))
                                .frame(width: 8, height: 8, alignment: .center)
                                .foregroundColor(configuration.isOn ? .green : .gray)
                        )
                        .offset(x: configuration.isOn ? 11 : -11, y: 0)
                        .animation(Animation.linear(duration: 0.1))
                        
                ).cornerRadius(20)
                .onTapGesture { configuration.isOn.toggle() }
        }
    }
    
}
