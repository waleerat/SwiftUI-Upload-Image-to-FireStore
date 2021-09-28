//
//  SwiftUI_Upload_Image_to_FireStoreApp.swift
//  SwiftUI-Upload-Image-to-FireStore
//
//  Created by Waleerat Gottlieb on 2021-09-28.
//

import SwiftUI
import Firebase

@main
struct SwiftUI_Upload_Image_to_FireStoreApp: App {
    
    init(){
        setupFirebaseApp()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
    
    private func setupFirebaseApp() {
       guard let plistPath = Bundle.main.path(forResource: "GoogleService-Info", ofType: "plist"),
                      let options =  FirebaseOptions(contentsOfFile: plistPath)
                      else { return }
                  if FirebaseApp.app() == nil{
                      FirebaseApp.configure(options: options)
                  }
    
    }
}
