//
//  WordVM.swift
//  WhatIsThis-WGO
//
//  Created by Waleerat Gottlieb on 2021-09-17.
//

import Foundation
import SwiftUI

class CommonVM: ObservableObject {
    @Published var contentRows: [CommonModel] = []
    @Published var countRow: Int = 0
    @Published var selectedRow: CommonModel?
    
    @State var contentRowsByCategory : [CommonModel] = []
    
    init() {
       getRecords()
    }
    
    func getRecords() {
        self.contentRows = []
        FirebaseReference(.Common).getDocuments { [self] (snapshot, error) in
            
            guard let snapshot = snapshot else { return }
            
            if !snapshot.isEmpty {
                for snapshot in snapshot.documents {
                    let rowData = snapshot.data()
                    let rowStructure = dictionaryToStructrue(rowData)
                    self.contentRows.append(rowStructure)
                }
                
                self.contentRowsByCategory = self.contentRows
            }
        }
         
    }
    
    func getSelectedRow(selectedRow: CommonModel) {
        self.selectedRow = selectedRow
    }
    
    // Note: - Create/Update Record
    func SaveRecord(objectId: String, modelData: CommonModel, completion: @escaping (_ isCompleted: Bool?) -> Void) {
        
        let dictionaryRowData = self.structureToDictionary(modelData)
        FirebaseReference(.Common).document(objectId).setData(dictionaryRowData) {
            error in
            if error != nil {
                completion(false)
                return
            }
            completion(true)
        }
    }
    
    func updateByFieldName(objectId: String, someFields: [String : Any] , completion : @escaping (_ isUpdated: Bool?) -> Void) {
        
        FirebaseReference(.Common).document(objectId).updateData(someFields) {
            error in
            if error != nil {
                completion(false)
                return
            }
            completion(true)
        }
    }
    
    // Note: - Delete Record
    func removeRecord(selectedRow: CommonModel?, completion: @escaping (_ isCompleted:Bool?) -> Void) {
        
        if let row = selectedRow {
            FirebaseReference(.Common).document(row.id).delete() { error in
                if let _ = error {
                    completion(false)
                } else {
                    if !row.imageURL.isEmpty {
                        DispatchQueue.main.async {
                            FileStorage.removeFileFromFirestore(fileURL: row.imageURL)
                        }
                    }
                    completion(true)
                }
            }
        }
        
        
    }
    
    func doUploadImage(objectId: String, selectedUIImage: UIImage?){
        if let selectedUIImage = selectedUIImage {
            let fileDirectory = "\(kFileStoreRootDirectory)/Common/Image_\(objectId).jpg"
            // Note: - Remove the old file
            if let row = self.selectedRow {
                DispatchQueue.main.async {
                    FileStorage.removeFileFromFirestore(fileURL: row.imageURL)
                    self.deleteFileStorageFile(fieldName: "imageURL")
                }
            }
            // Note: - Upload Image
            FileStorage.uploadImage(selectedUIImage, directory: fileDirectory) { (uploadedImageURL) in
                
                if let newImageURL = uploadedImageURL {
                    // Note: - Update Record
                    let someFields = ["imageURL" : newImageURL]
                    self.updateByFieldName(objectId: objectId, someFields: someFields) { _ in
                       
                    }
                }
            }
        }
        
    }
     
    
    func deleteFileStorageFile(fieldName: String){
        if let currentRow = self.selectedRow {
            let dictionaryRow = self.structureToDictionary(currentRow)
            
            let fileURL = dictionaryRow[fieldName] as! String
            if fileURL != "" {
                FileStorage.removeFileFromFirestore(fileURL: fileURL)
            }
        }
    }
    
    
    func structureToDictionary(_ row : CommonModel) -> [String : Any] {
        return NSDictionary(
            objects:
                [row.id,
                 row.title,
                 row.description,
                 row.imageURL
                ],
            forKeys: [
                "id" as NSCopying,
                "title" as NSCopying,
                "description" as NSCopying,
                "imageURL" as NSCopying
            ]
        ) as! [String : Any]
    }
    
    func dictionaryToStructrue(_ dictionaryRow : [String : Any]) -> CommonModel {
        return CommonModel(_id: dictionaryRow["id"] as? String ?? "",
                           _title: dictionaryRow["title"] as? String ?? "",
                           _description: dictionaryRow["description"] as? String ?? "",
                           _imageURL: dictionaryRow["imageURL"] as? String ?? "")
    }
     
    
}
