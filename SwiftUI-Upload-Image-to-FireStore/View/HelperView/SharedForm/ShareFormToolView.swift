//
//  NewWordToolView.swift
//  WhatIsThis-WGO
//
//  Created by Waleerat Gottlieb on 2021-09-16.
//

import SwiftUI

struct ShareFormToolView: View {
    @EnvironmentObject var imagePicker: ImagePickerViewModel
    
    @Binding var title:String
    @Binding var description:String
    @Binding var isCustomCamera:Bool
    
    // Note: - helper variables
    
    
    var body: some View {
        VStack (spacing: 10){
            // Note: - Photo / theme Selections
            HStack(spacing: 15){
                Spacer()
                
                Button(action: imagePicker.openImagePicker, label: {
                    Image(systemName: imagePicker.showImagePicker ? "xmark" : "photo")
                        .resizable()
                        .modifier(CommonIconModifier())
                })
                
                if isIphone {
                    Button(action: {
                        hideKeyboard()
                        isCustomCamera.toggle() // open
                    }, label: {
                        Image(systemName: "camera")
                            .resizable()
                            .modifier(CommonIconModifier())
                    })
                }
            }
            .padding(.horizontal)
            
            // Note: - Text Input Thai
            TextField("Title", text: $title, onEditingChanged: { (opened) in
             
                if opened && imagePicker.showImagePicker{
                    // Closing Picker...
                    imagePicker.showImagePicker.toggle()
                }
            }).modifier(TextInputModifier())
            
            
            TextField("Description", text: $description, onEditingChanged: { (opened) in
             
                if opened && imagePicker.showImagePicker{
                    // Closing Picker...
                    imagePicker.showImagePicker.toggle()
                }
            }).modifier(TextInputModifier())
            
            ScrollView(.horizontal, showsIndicators: false, content: {
                
                LazyHStack(spacing: 10){
                    // Images...
                    ForEach(imagePicker.fetchedPhotos){photo in
                        // Note: - PICKING IMAGE
                        Button(action: {
                            // Clearing Content...
                            //imagePicker.selectedVideoPreview = nil
                            imagePicker.selectedImagePreview = nil
                            // Set the new selected image
                            imagePicker.extractPreviewData(asset: photo.asset)
                            imagePicker.showPreview.toggle()
                            // Dismiss images List view
                            imagePicker.showImagePicker.toggle()
                        }, label: {
                            ThumbnailView(photo: photo)
                        })
                    }
                    // Note: - IN CASE IF YOU DON'T ALLOW DEVICE IN THE BEGINNING THEN THIS POP SECTION VIEW SHOW
                    // More Or Give Access Button...
                    AskForPermission()
                        .environmentObject(imagePicker)
                }
                .padding()
            })
            // Showing When Button Clicked...
            .frame(height: imagePicker.showImagePicker ? 200 : 0)
            .background(Color.primary.opacity(0.04).ignoresSafeArea(.all, edges: .bottom))
            .opacity(imagePicker.showImagePicker ? 1 : 0)
        }
       // .modifier(PopupPaddingModifier())
        .padding()
        .background(Color.accentColor.opacity(0.3))
        .cornerRadius(10)
        
    }
    
 
}
