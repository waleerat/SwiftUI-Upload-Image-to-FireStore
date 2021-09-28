//
//  ContentView.swift
//  SwiftUI-Upload-Image-to-FireStore
//
//  Created by Waleerat Gottlieb on 2021-09-28.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            CommonIndexView()
                .modifier(ScreenModifier())
                .modifier(NavigationBarHiddenModifier())
        }.navigationViewStyle(StackNavigationViewStyle())
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        
        ContentView()
            
    }
}


