//
//  CommonFormView.swift
//  WhatIsThis-WGO
//
//  Created by Waleerat Gottlieb on 2021-09-18.
//

import SwiftUI

struct CommonFormView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var commonVM: CommonVM
    
    // Note: - Input Fields
    @Binding var isReload: Bool
    @State var objectId:String  = ""
    @State var title:String  = ""
    @State var description:String  = ""
    @State var imageURL:String  = ""
    
    // Note: - helper variables
    @State var isSaved: Bool = false
    
    @State var isCustomCamera: Bool = false
    @StateObject var imagePicker = ImagePickerViewModel()
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Color(kScreenBackground)
                .ignoresSafeArea(.all)
            // MARK: - Start
            VStack(spacing: 20){
               
                HStack(spacing: 10) {
                    
                    ButtonWithIconWithClipShapeCircleAction(systemName: "arrow.backward", action: {
                        withAnimation() {
                            self.presentationMode.wrappedValue.dismiss()
                        }
                    })
                    
                    Text("Sample").modifier(TextBoldModifier(fontStyle: .header))
                    
                    Spacer()
                    
                    ButtonTextAction(buttonLabel: .constant(commonVM.selectedRow == nil ? "Save" : "Update") , isActive: .constant(!title.isEmpty), frameWidth: 60) {
                        
                        saveToFirebase(objectId: objectId)
                        
                    }.disabled(title.isEmpty)
                   
                }
               // .padding(.leading)
               // .padding(.trailing)
                
                
                // Note: - preview section
                ScrollView(.vertical, showsIndicators: false) {
                    ShareFormPreviewView(
                        collectionRefe: .Common,
                        selectedRow: commonVM.selectedRow,
                        title: $title,
                        description: $description,
                        imageURL: $imageURL)
                        .environmentObject(imagePicker)
                }
                
                // Note: - input section
                ShareFormToolView(
                    title: $title,
                    description: $description, isCustomCamera: $isCustomCamera
                )
                .environmentObject(imagePicker)
                
            }//: VSTACK
            .blur(radius: (isSaved)  ? 8.0 : 0, opaque: false)
            .onChange(of: isSaved, perform: { _ in
                if isSaved {
                    
                }
            })
            .onAppear() {
                if let currentRow = commonVM.selectedRow {
                    objectId = currentRow.id
                    title = currentRow.title
                    description = currentRow.description
                    imageURL = currentRow.imageURL
                } else {
                    objectId = UUID().uuidString
                }
            }
            .onTapGesture {
                withAnimation() {
                    hideKeyboard()
                }
              }
            .padding(20)
            
            if isCustomCamera {
                 CameraView(isCustomCamera: $isCustomCamera)
             }
            // MARK: - End
        } 
    }
    
    // MARK: - HELPER FUNCTIONS
    func saveToFirebase(objectId: String){
        // Note: - Save to Firebase
        let modelData = CommonModel(_id: objectId,
                                    _title: (title != kPlaceholderTitle) ? title : "",
                                    _description:  (description != kPlaceholderDescription) ? description : "",
                                    _imageURL: imageURL)
        
        commonVM.SaveRecord(objectId: objectId, modelData: modelData) { isCompleted in
            DispatchQueue.main.async {
                commonVM.doUploadImage(objectId: objectId, selectedUIImage: imagePicker.selectedImagePreview)
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                isReload = true
                self.presentationMode.wrappedValue.dismiss()
           }
            isSaved = true
        }
    }

    func resetFields(){
        title = ""
        description = ""
        imageURL = ""
    }
}
