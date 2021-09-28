//
//  FileManager.swift
//  Sawasdee By WGO
//
//  Created by Waleerat Gottlieb on 2021-08-27.
//

import SwiftUI
import Foundation

class FileManagerVM {
    
    class func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
       let size = image.size

       let widthRatio  = targetSize.width  / size.width
       let heightRatio = targetSize.height / size.height

       // Figure out what our orientation is, and use that to form the rectangle
       var newSize: CGSize
       if(widthRatio > heightRatio) {
           newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
       } else {
           newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
       }

       // This is the rect that we've calculated out and this is what is actually used below
       let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)

       // Actually do the resizing to the rect using the ImageContext stuff
       UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
       image.draw(in: rect)
       let newImage = UIGraphicsGetImageFromCurrentImageContext()
       UIGraphicsEndImageContext()

       return newImage!
    }
    
    class func deleteFile(url : URL){
        do {
            // Note: - deleting that recording .
            try FileManager.default.removeItem(at : url)
            //print(">>> DELETEFILE : \(url)")
        } catch {
            print(">>> Can't delete")
        }
    }
    
    class func getFileNameWithRootDocument(filename: String) -> URL{
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let localFile = path.appendingPathComponent(filename)
        return localFile
    } 

    class func getDocumentsURL() -> URL {
        let documentURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last
        return documentURL!
    }


    class func fileInDocumentsDirectory(filename: String) -> String {
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let fileURL = path.appendingPathComponent(filename)
        return fileURL.path
    }

    // Note: - Can include file path too ex. audio/filename.mp3
    class func fileExistsAt(filename: String) -> Bool {
        return FileManager.default.fileExists(atPath: fileInDocumentsDirectory(filename: filename))
    }
    
    
    class func deleteLocalTempFile(filename: String){
        if FileManagerVM.fileExistsAt(filename: filename) {
            let localFile = FileManagerVM.getFileNameWithRootDocument(filename: filename)
            FileManagerVM.deleteFile(url: localFile)
        }
    }

}
