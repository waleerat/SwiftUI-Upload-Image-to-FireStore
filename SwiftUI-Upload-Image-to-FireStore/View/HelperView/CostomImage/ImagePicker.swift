//
//  ImagePicker.swift
//  ShopToday
//
//  Created by Waleerat Gottlieb on 2020-12-01.
// https://www.hackingwithswift.com/books/ios-swiftui/importing-an-image-into-swiftui-using-uiimagepickercontroller

import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.image = uiImage
                parent.imageSeleted  = uiImage
            }

            parent.presentationMode.wrappedValue.dismiss()
        }
        
    }
    
    @Environment(\.presentationMode) var presentationMode
    @Binding var image: UIImage?
    @Binding var imageSeleted : UIImage?
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {

    }
    
   
}
