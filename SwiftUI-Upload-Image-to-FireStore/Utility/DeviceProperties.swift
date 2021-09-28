//
//  DeviceProperties.swift
//  StampBank
//
//  Created by Waleerat Gottlieb on 2021-07-18.
//

import SwiftUI

// MARK: - Screen

public var screenSize = UIScreen.main.bounds
public var isSmallDevice : Bool {  return  screenSize.height < 750 }
public let saveAreaTop: CGFloat = (UIApplication.shared.windows.first?.safeAreaInsets.top)!
public var saveAreaBottom: CGFloat{
                        #if os(iOS)
                        return UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 10
                        #else
                        return 10
                        #endif
                    }


// MARK: - Devices
enum Device{
   case iPhone
   case iPad
   case macOS
}

func getDevice()->Device{
    #if os(iOS)
    // Since There is No Direct For Getting iPad OS...
    // Alternative Way...
    if UIDevice.current.model.contains("iPad"){
        return .iPad
    }
    else{
        return .iPhone
    }
    #else
    return .macOS
    #endif
}

// MARK: - check what device ?
public var isIpadAndMacOS: Bool {
    return  getDevice() == .iPad || getDevice() == .macOS ? true : false
}

public var isIpadAndIphone: Bool{
    return  getDevice() == .iPad || getDevice() == .iPhone ? true : false
}

public var isIpad: Bool {
    return  getDevice() == .iPad ? true : false
}

public var isIphone: Bool {
    return  getDevice() == .iPhone ? true : false
}

// MARK: - Get front size
enum FontStyle{
    case header
    case title
    case description
    case caption
    case button
    case textinput
    case common
}

func getIconSize() -> CGFloat {
    return isIpad ? 30 : 20
}

func getFontSize(fontStyle: FontStyle) -> CGFloat {
    var fontSize: CGFloat = 14
    switch fontStyle {
    case .header:
        fontSize = isIpad ? 50 : 30
    case .title:
        fontSize = isIpad ? 30 : 20
    case .caption:
        fontSize = isIpad ? 15 : 11
    case .button:
        fontSize = isIpad ? 20 : 15
    case .textinput:
        fontSize = isIpad ? 20 : 15
    case .description:
        fontSize = isIpad ? 18 : 15
    case .common:
        fontSize = isIpad ? 18 : 15
    }
    return fontSize
}

