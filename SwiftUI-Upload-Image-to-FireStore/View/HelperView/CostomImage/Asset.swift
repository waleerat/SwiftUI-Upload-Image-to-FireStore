//
//  Asset.swift
//  WhatIsThis-WGO
//
//  Created by Waleerat Gottlieb on 2021-09-16.
//

import SwiftUI
import Photos

struct ImageAsset: Identifiable {
    var id = UUID().uuidString
    var asset: PHAsset
    var image: UIImage
}

