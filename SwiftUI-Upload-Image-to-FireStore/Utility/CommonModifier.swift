//
//  CommonModifier.swift
//  SwiftUI-MVVM-and-Design-Pattern
//
//  Created by Waleerat Gottlieb on 2021-09-23.
//

import SwiftUI


struct NavigationBarHiddenModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
            .modifier(ScreenModifier())
    }
}

struct ScreenModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color("bg").ignoresSafeArea())
    }
}

struct IgnoreBottomAreaModifier : ViewModifier {
    func body(content: Content) -> some View {
    content
        .padding(.bottom, saveAreaBottom)
    }
}


struct TextInputModifier : ViewModifier {
    var foregroundColor = Color.accentColor
    
    func body(content: Content) -> some View {
    content
         .font(.system(size: getFontSize(fontStyle: .common) ,weight: .regular, design: .rounded))
        .foregroundColor(foregroundColor)
        .padding()
        .background(RoundedRectangle(cornerRadius: 4)
                        .strokeBorder(foregroundColor, lineWidth: 1))
    }
}

struct TextBoldModifier : ViewModifier {
    var fontStyle: FontStyle
    var foregroundColor = Color.accentColor
    
    func body(content: Content) -> some View {
    content
        .font(.system(size: getFontSize(fontStyle: fontStyle) ,weight: .bold, design: .rounded))
        .foregroundColor(foregroundColor)
    }
}

struct TextRegularModifier : ViewModifier {
    var fontStyle: FontStyle
    var foregroundColor = Color.accentColor
    
    func body(content: Content) -> some View {
    content
        .font(.system(size: getFontSize(fontStyle: fontStyle) ,weight: .regular, design: .rounded))
        .foregroundColor(foregroundColor)
    }
}

struct TextBoldWithUnderLineModifier : ViewModifier {
    var fontStyle: FontStyle
    var foregroundColor = Color.accentColor
    
    func body(content: Content) -> some View {
    content
        .font(.system(size: getFontSize(fontStyle: fontStyle) ,weight: .bold, design: .rounded))
        .foregroundColor(foregroundColor)
        //.underline(true, color: Color.white)
    }
}

struct CommonIconModifier: ViewModifier {
    var foregroundColor = Color.accentColor
    
    func body(content: Content) -> some View {
        content
            .frame(width: 20, height: 20)
            .foregroundColor(foregroundColor)
    }
}


struct ImageModifier : ViewModifier {
   func body(content: Content) -> some View {
   content
    .aspectRatio(contentMode: .fit)
    .foregroundColor(.accentColor.opacity(0.5))
    .frame(height: screenSize.height * 0.2)
    .cornerRadius(10)
    .modifier(CustomShadowModifier())
   }
}

struct ThumbnailImageModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .frame(width: 60 , height: 70 )
            .aspectRatio(contentMode: .fit)
            .cornerRadius(5)
    }
}


struct CustomShadowModifier : ViewModifier {
   func body(content: Content) -> some View {
   content
       .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.25), radius: 8, x: 0.0, y: 4.0)
   }
}


/*
 
 struct NavigationPropertiesModifier : ViewModifier {
     func body(content: Content) -> some View {
     content
         .accentColor(.accentColor)
         .navigationViewStyle(StackNavigationViewStyle())
     }
 }

 struct NavigationBarHiddenModifier : ViewModifier {
     func body(content: Content) -> some View {
     content
             .navigationBarHidden(true)
             .navigationBarBackButtonHidden(true)
     }
 }

 struct ScreenEdgesPaddingModifier : ViewModifier {
     func body(content: Content) -> some View {
     content
         .navigationBarHidden(true)
         .navigationBarBackButtonHidden(true)
         .padding(.top, saveAreaTop)
         .padding(.bottom, saveAreaBottom)
     }
 }




  
 struct TextTitleModifier : ViewModifier {
     func body(content: Content) -> some View {
     content
             .font(.title2)
             .multilineTextAlignment(.leading)
     }
 }

 struct TextDescriptionModifier : ViewModifier {
     func body(content: Content) -> some View {
     content
             .font(.caption)
             .multilineTextAlignment(.leading)
     }
 }

 struct InputModifier : ViewModifier {
     func body(content: Content) -> some View {
     content
             .font(.caption)
             .multilineTextAlignment(.leading)
     }
 }

 struct CommonIconModifier: ViewModifier {
     
     func body(content: Content) -> some View {
         content
             .frame(width: 25 , height: 25 )
             .aspectRatio(contentMode: .fit)
     }
 }




 struct ImageModifier: ViewModifier {
     
     func body(content: Content) -> some View {
         content
             .frame(width: 120 , height: 150 )
             .aspectRatio(contentMode: .fit)
             .cornerRadius(5)
     }
 }

 struct ImageFullScreenModifier: ViewModifier {
     
     func body(content: Content) -> some View {
         content
             .frame(width: screenSize.width * 0.9, height: screenSize.height - (saveAreaTop + saveAreaBottom) - 200)
             .scaledToFit()
             .cornerRadius(10)
     }
 }

 */
