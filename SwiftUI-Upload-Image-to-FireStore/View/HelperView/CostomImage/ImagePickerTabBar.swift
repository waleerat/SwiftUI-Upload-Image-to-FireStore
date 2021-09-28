//
//  TopBarViewForImagePicker.swift
//  WhatIsThis-WGO
//
//  Created by Waleerat Gottlieb on 2021-09-16.
//

import SwiftUI

struct ToolBarLeadingForImagePicker: View {
    var body: some View {
        Button(action: {}, label: {
            Image(systemName: "chevron.left")
                .font(.title2)
                
                
        })
    }
}


struct ToolBarCenterForImagePicker: View {
    var body: some View {
        HStack(spacing: 8){
            
            // Use Image Or Profile Image Here...
            Image("logo")
                .resizable()
                .scaledToFit()
                .frame(width: getIconSize(), height: getIconSize())
                .cornerRadius(10)
         
            Text("Sawasdee")
                .fontWeight(.semibold)
        }
    }
}

 
struct ToolBarTrailingForCamera: View {
    var body: some View {
        Button(action: {}, label: {
            Image(systemName: "photo.on.rectangle")
                .font(.title2)
                
        })
    }
}

struct ToolBarTrailingForPhone: View {
    var body: some View {
        Button(action: {}, label: {
            Image(systemName: "gearshape")
                .font(.title2)
                
        })
    }
}
