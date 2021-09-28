//
//  AskForPermission.swift
//  WhatIsThis-WGO
//
//  Created by Waleerat Gottlieb on 2021-09-16.
//

import SwiftUI

struct AskForPermission: View {
    @EnvironmentObject var imagePicker: ImagePickerViewModel
    
    var body: some View {
        // More Or Give Access Button...
        if imagePicker.library_status == .denied || imagePicker.library_status == .limited{
            
            VStack(spacing: 15){
                // Note: - description view
                Text(imagePicker.library_status == .denied ? "Allow Access For Photos" : "Select More Photos" )
                    .foregroundColor(.gray)
                
                Button(action: {
                    // Go to Settings
                    UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
                }, label: {
                    // Note: - button view
                    Text(imagePicker.library_status == .denied ? "Allow Access" : "Select More")
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .padding(.vertical,10)
                        .padding(.horizontal)
                        .background(Color.blue)
                        .cornerRadius(5)
                })
            }
            .frame(width: 150)
        }
    }
}

struct AskForPermission_Previews: PreviewProvider {
    static var previews: some View {
        AskForPermission()
    }
}
