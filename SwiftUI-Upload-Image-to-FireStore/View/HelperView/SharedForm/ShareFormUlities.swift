//
//  ShareFormProperties.swift
//  WhatIsThis-WGO
//
//  Created by Waleerat Gottlieb on 2021-09-19.
//

import SwiftUI 

struct ConfirmDeleteView : View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var isConfirmDeleteAction: Bool
    @Binding var isConfirmDelete: Bool
    var body: some View {
        ZStack{
            BlankView(
            backgroundColor: Color.gray,
              backgroundOpacity: 0.7)
              .onTapGesture {
                withAnimation() {
                    isConfirmDeleteAction.toggle()
                }
              }
            
            VStack(spacing: 25) {
                Text("Are you sure?")
                    .modifier(TextBoldModifier(fontStyle: .title))
                
                ButtonTextAction(buttonLabel: .constant("Confirm"), isActive: .constant(true), backgroundColor: Color.red) {
                    isConfirmDeleteAction.toggle()
                    isConfirmDelete = true
                }
                
                ButtonTextAction(buttonLabel: .constant("Cancel"), isActive: .constant(true)) {
                    isConfirmDeleteAction.toggle()
                }
            }
            
        }
    }
} 

struct ThumbnailView: View {
    
    var photo: ImageAsset
    
    var body: some View{
        
        ZStack(alignment: .bottomTrailing, content: {
            
            Image(uiImage: photo.image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 150, height: 150)
                .cornerRadius(10)
            
            // If Its Video
            // Displaying Video Icon...
            
            if photo.asset.mediaType == .video{
                Image(systemName: "video.fill")
                    .font(.title2)
                    .foregroundColor(.white)
                    .padding(8)
            }
        })
    }
}


struct microphoneRecordingView: View {
    @Binding  var isRecording:Bool
    
    var body: some View {
        ZStack{
            Circle()
                .fill(Color.red)
                .frame(width: getIconSize() , height: getIconSize())
            
            Circle()
                .stroke(!isRecording ? Color.orange : Color.gray.opacity(0.2), lineWidth: isIpad ? 10 : 6)
                .frame(
                    width: isIpad ? getIconSize() + 7 : getIconSize() + 5 ,
                    height: isIpad ? getIconSize() + 7 : getIconSize() + 5
                )
            
            Image(systemName: "mic.fill")
                .resizable()
                .scaledToFit()
                .foregroundColor(.white)
                .frame(
                    width:  isIpad ? getIconSize() - 7 : getIconSize() - 4,
                    height: isIpad ? getIconSize() - 7 : getIconSize() - 4
                )
        }
    }
}


struct audioRemoveIconView: View {
    @State var systemName: String = "xmark.bin.fill"
    
    var body: some View {
        ZStack{
            Circle()
                .fill(Color.red)
                .frame(width: isIpad ? 45 : 25, height: isIpad ? 45 : 25)
            
            Image(systemName: systemName)
                .resizable()
                .scaledToFit()
                .foregroundColor(Color.white)
                .frame(width: isIpad ? 35 : 18, height: isIpad ? 35 : 18)
        }
    }
}

// Note: - Class to check if Keyboard appeared
class KeyboardInfo: ObservableObject {

    public static var shared = KeyboardInfo()

    @Published public var height: CGFloat = 0

    private init() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardChanged), name: UIApplication.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardChanged), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardChanged), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }

    @objc func keyboardChanged(notification: Notification) {
        if notification.name == UIApplication.keyboardWillHideNotification {
            self.height = 0
        } else {
            self.height = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect)?.height ?? 0
        }
    }

}
