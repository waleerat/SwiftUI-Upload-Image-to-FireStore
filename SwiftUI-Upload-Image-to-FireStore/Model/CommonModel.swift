//
//  CommonModel.swift
//  WhatIsThis-WGO
//
//  Created by Waleerat Gottlieb on 2021-09-18.
//

import Foundation

struct CommonModel: Identifiable, Hashable, Codable {
    var id: String
    var title: String
    var description: String
    var imageURL: String
    
     
    // Note: - CMS Data
    init(_id: String,
         _title: String,
         _description: String,
         _imageURL: String
         
    ) {
        id = _id
        title = _title
        description = _description
        imageURL = _imageURL
    }
    
}
