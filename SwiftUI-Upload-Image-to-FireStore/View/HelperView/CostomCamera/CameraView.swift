//
//  CameraView.swift
//  WhatIsThis-WGO
//
//  Created by Waleerat Gottlieb on 2021-09-16.
//

import SwiftUI
import AVFoundation

 
struct CameraView: View {
    @StateObject var camera = CameraModel()
    
    @Binding var isCustomCamera:Bool
    
    var body: some View{
        
        ZStack{
            // Going to Be Camera preview...
            CameraPreview(camera: camera).ignoresSafeArea(.all, edges: .all)
            
            VStack{
                HStack {
                    
                    Button(action: {
                        isCustomCamera.toggle() // close
                    }, label: {
                        Image(systemName: "xmark")
                            .foregroundColor(.accentColor)
                            .padding()
                            .background(Color.accentColor.opacity(0.5))
                            .clipShape(Circle())
                    })
                    
                    Spacer()
                    if camera.isTaken{
                        Button(action: camera.reTake, label: {

                            Image(systemName: "arrow.triangle.2.circlepath.camera")
                                .foregroundColor(.accentColor)
                                .padding()
                                .background(Color.accentColor.opacity(0.5))
                                .clipShape(Circle())
                        })
                        .padding(.trailing,10)
                        
                    }
                }
                .padding()
               // .modifier(IgnoreTopAreaModifier())
                
                Spacer()
                
                HStack{
                    // if taken showing save and again take button...
                    
                    if camera.isTaken{
                        Button(action: {
                            isCustomCamera.toggle() // Close
                        }, label: {
                            Text("OK")
                                .foregroundColor(.black)
                                .fontWeight(.semibold)
                                .padding(.vertical,10)
                                .padding(.horizontal,20)
                                .background(Color.white)
                                .clipShape(Capsule())
                        })
                        .padding(.leading)
                        
                        Spacer()
                    }
                    else{
                        
                        Button(action: camera.takePic, label: {
                            
                            ZStack{
                                
                                Circle()
                                    .fill(Color.white)
                                    .frame(width: 65, height: 65)
                                
                                Circle()
                                    .stroke(Color.white,lineWidth: 2)
                                    .frame(width: 75, height: 75)
                            }
                        })
                    }
                }
                .frame(height: 75)
                .modifier(IgnoreBottomAreaModifier())
            }
        }
        .ignoresSafeArea(.all)
        .onAppear(perform: {
            camera.Check()
        })
        .alert(isPresented: $camera.alert) {
            Alert(title: Text("Please Enable Camera Access"))
        }
    }
}
