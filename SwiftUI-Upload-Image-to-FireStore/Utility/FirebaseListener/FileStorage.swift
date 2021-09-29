//
//  FileStorage.swift
//  LetsMeet
//
//  Created by David Kababyan on 05/07/2020.
//

import Foundation
import SwiftUI
import UIKit
import FirebaseStorage
 

let storage = Storage.storage()

class FileStorage {
    
    //var userListener = UserListener()
    class func uploadImage(_ image: UIImage, directory: String, completion: @escaping (_ documentLink: String?) -> Void) {
        
        let storageRef = storage.reference(forURL: kFileRefference).child(directory)
       
        let  newImageSize = FileManagerVM.resizeImage(image: image, targetSize: CGSize(width: 500, height: 500))
        let imageData =   newImageSize.jpegData(compressionQuality: 0.5)
        
        var task: StorageUploadTask!
        
        task = storageRef.putData(imageData!, metadata: nil, completion: { (metaData, error) in
            
            task.removeAllObservers()
            //ProgressHUD.dismiss()
            if error != nil {
                print("error uploading image", error!.localizedDescription)
                return
            }
            
            storageRef.downloadURL { (url, error) in
                
                guard let downloadUrl = url else {
                    completion(nil)
                    return
                }
                print("we have uploaded image to ", downloadUrl.absoluteString)
                completion(downloadUrl.absoluteString)
            }
        })
        
        
        task.observe(StorageTaskStatus.progress) { (snapshot) in
            
            let _ = snapshot.progress!.completedUnitCount / snapshot.progress!.totalUnitCount
            //ProgressHUD.showProgress(CGFloat(progress))
        }
    }
    
    class func uploadFile(filename : String,rootDirectory: String,  directory: String, completion: @escaping (_ documentLink: String?) -> Void) {
        
        //let orignalName = filename.components(separatedBy: ".").first!
        //let orginalFileType = filename.components(separatedBy: ".").first!
       
        let storagePath = "\(rootDirectory)/\(directory)/\(filename)"
        
        let localFile = FileManagerVM.getFileNameWithRootDocument(filename: filename)
        
       // let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
       // let localFile = path.appendingPathComponent(filename)
            
        // Create a root reference
        let storageRef = storage.reference(forURL: kFileRefference).child(storagePath)
        
        var task: StorageUploadTask!
        task = storageRef.putFile(from: localFile, metadata: nil) { metadata, error in
            task.removeAllObservers()
          
            if error != nil {
                print(">>> error uploading image", error!.localizedDescription)
                return
            }
            
            storageRef.downloadURL { (url, error) in
                
                guard let downloadUrl = url else {
                    completion(nil)
                    return
                }
                //print("we have uploaded image to ", downloadUrl.absoluteString)
                completion(downloadUrl.absoluteString)
            }
        }
        
        
        task.observe(StorageTaskStatus.progress) { (snapshot) in
            let _ = snapshot.progress!.completedUnitCount / snapshot.progress!.totalUnitCount
        }
        
    }
    
    class func downloadImage(imageUrl: String, completion: @escaping (_ image: UIImage?) -> Void) {
                
        let imageFileName = ((imageUrl.components(separatedBy: "_").last!).components(separatedBy: "?").first)!.components(separatedBy: ".").first!

        if FileManagerVM.fileExistsAt(filename: imageFileName) {
            
            if let contentsOfFile = UIImage(contentsOfFile: FileManagerVM.fileInDocumentsDirectory(filename: imageFileName)) {
                completion(contentsOfFile)
            } else {
                print("couldnt generate image from local image")
                completion(nil)
            }
            
        } else {

            if imageUrl != "" {
                
                let documentURL = URL(string: imageUrl)
                
                let downloadQueue = DispatchQueue(label: "downloadQueue")

                downloadQueue.async {
                    
                    let data = NSData(contentsOf: documentURL!)
                    
                    if data != nil {
                        
                        let imageToReturn = UIImage(data: data! as Data)
                        
                        FileStorage.saveImageLocally(imageData: data!, fileName: imageFileName)
                        
                        completion(imageToReturn)
                        
                    } else {
                        print("no image in database")
                        completion(nil)
                    }
                }

            } else {
                completion(nil)
            }
        }
    }
    
    class func saveImageLocally(imageData: NSData, fileName: String) {
       // var docURL = FileManagerVM.getDocumentsURL()
       // docURL = docURL.appendingPathComponent(fileName, isDirectory: false)
       // imageData.write(to: docURL, atomically: true)
        
        let imageURL = FileManagerVM.getFileNameWithRootDocument(filename: fileName)
        imageData.write(to: imageURL, atomically: true)
    }
    
    class func removeFileFromFirestore(fileURL:String){
        if !fileURL.isEmpty {
            let storage = Storage.storage()
            let storageRef = storage.reference(forURL: fileURL)
            storageRef.delete { error in
                if let error = error {
                    print(error)
                } else {
                    print(">> File deleted successfully!")
                }
            }
        }
    }
    
}

