//
//  InputSectionView.swift
//  WhatIsThis-WGO
//
//  Created by Waleerat Gottlieb on 2021-09-16.
//

import SwiftUI
import Kingfisher

struct ShareFormPreviewView: View {
    @ObservedObject private var keyboard = KeyboardInfo.shared
    @EnvironmentObject var imagePicker: ImagePickerViewModel
    
    @State var collectionRefe: FCollectionReference
    @State var selectedRow: CommonModel?
    @Binding var title:String
    @Binding var description:String
    @Binding var imageURL:String
    
    // Note: - helper variables
    @State private var objectId: String = ""
    @State var audioInThaiFromDB: String = ""
    @State var audioInEnglishFromDB: String = ""

    
    var body: some View{
        
        VStack (spacing: 10){
            VStack {
                // Note: - IMAGE PREVIEW
                if keyboard.height == 0 {
                    HStack {
                        
                        if imagePicker.selectedImagePreview != nil{
                            Image(uiImage: imagePicker.selectedImagePreview)
                                .resizable()
                                .modifier(ImageModifier())
                        } else {
                            if  !imageURL.isEmpty {
                                KFImage(URL(string: imageURL)!)
                                    .resizable()
                                    .modifier(ImageModifier())
                            } else {
                                Image(systemName: "photo")
                                    .resizable()
                                    .modifier(ImageModifier())
                            }
                        }
                    }
                    .frame(width: isIpad ? screenSize.width * 0.5 : screenSize.width * 0.8)
                }
                 
                
                VStack(spacing: 15){
                    // Note: - Preview Thai
                    Text(title.isEmpty ? "Empty title" : title)
                        .modifier(TextRegularModifier(fontStyle: .title))
                    
                    Text(description.isEmpty ? "Empty description" : description)
                        .modifier(TextRegularModifier(fontStyle: .title))
                }
                .padding()
                
            }
            //:: VSTACK
           // .padding()
        }
        .onTapGesture {
          withAnimation() {
              // Code Here
              hideKeyboard()
              if imagePicker.showImagePicker{
                  // Closing Picker...
                  imagePicker.showImagePicker.toggle()
              }
          }
        }
        //:VSTACK
        .onAppear() {
            // Note: - Load default value
             if let row = selectedRow {
                 objectId = row.id
                 title = row.title
                 description = row.description
             }
        }
    } 
} 
