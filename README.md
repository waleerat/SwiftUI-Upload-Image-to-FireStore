# SwiftUI Upload image to Firestore
### Xcode Version 13.0
###### SwiftUI, Firebase, Firestore

Example for Image picker, camera, upload/delete in Firestore.

## Screenshots
<img src="https://github.com/waleerat/GitHub-Photos-Shared/blob/main/SwiftUI-Upload-Image-to-FireStore/sample_index.JPG" width="30%" height="30%"> |
<img src="https://github.com/waleerat/GitHub-Photos-Shared/blob/main/SwiftUI-Upload-Image-to-FireStore/sample_update.JPG" width="30%" height="30%"> |
<img src="https://github.com/waleerat/GitHub-Photos-Shared/blob/main/SwiftUI-Upload-Image-to-FireStore/sample_imageSelector.JPG" width="30%" height="30%"> |
<img src="https://github.com/waleerat/GitHub-Photos-Shared/blob/main/SwiftUI-Upload-Image-to-FireStore/sample_takephoto.JPG" width="30%" height="30%"> |
<img src="https://github.com/waleerat/GitHub-Photos-Shared/blob/main/SwiftUI-Upload-Image-to-FireStore/sample_delete.JPG" width="30%" height="30%"> | 


## How to setup project
1. Clone project to your Mac
2. Setup firebase  [See](https://firebase.google.com/docs/ios/setup)
3. Enable Firebase and Firestore [See](https://console.firebase.google.com/)
4. import your own GoogleService-Info.plist to the project
5. run pod install in Terminal

```sh
 run pod install
```
5.  Close project and open again

<img src="https://github.com/waleerat/GitHub-Photos-Shared/blob/main/SwiftUI-Upload-Image-to-FireStore/finder.png" width="50%" height="50%">

7.  Set project info in `Supported interface orientations`

  - Privacy - Photo Library Usage Description
  - Privacy - Camera Usage Description

<img src="https://github.com/waleerat/GitHub-Photos-Shared/blob/main/SwiftUI-Upload-Image-to-FireStore/allow-device.png" width="50%" height="50%">

## Check these files

#### SwiftUI_Upload_Image_to_FireStoreApp.swift

if you want to separate to difference Firebase for development and production so you can use this code otherwise you can just use `FirebaseApp.configure()`

```sh
    private func setupFirebaseApp() {
        
       guard let plistPath = Bundle.main.path(
        forResource: "GoogleService-Info", ofType: "plist"),
             let options =  FirebaseOptions(contentsOfFile: plistPath)
                      else { return }
        
          if FirebaseApp.app() == nil{
              FirebaseApp.configure(options: options)
          }
    }
```

Example for Config 2 difference Firebase.


```sh
     private func setupFirebaseApp() {
        #if DEBUG
            let kGoogleServiceInfoFileName = "DEVELOPMENT-GoogleService-Info"
        #else
            let kGoogleServiceInfoFileName = "GoogleService-Info"
        #endif
        
       guard let plistPath = Bundle.main.path(
        forResource: kGoogleServiceInfoFileName, ofType: "plist"),
             let options =  FirebaseOptions(contentsOfFile: plistPath)
                      else { return }
        
          if FirebaseApp.app() == nil{
              FirebaseApp.configure(options: options)
          }
    }
```

#### Constants.swift 

The constants values that I use in the project. 

`public let kFileRefference = "gs://sample-project.appspot.com"`  Enter you Firestorage folder path  
`public let kFileStoreRootDirectory = "Example-Project/"` Root folder 
  
#### FCollectionReference.swift
Collections for firebase

```sh
  enum FCollectionReference: String {
    case User = "pia_user"
    case Common = "pia_common" 
} 


func FirebaseReference(_ collectionReference: FCollectionReference) -> CollectionReference {
    
    return Firestore.firestore().collection(collectionReference.rawValue)
} 
```
  
How to use :


```sh
FirebaseReference(.Common).document(objectId).delete() { error in }
```

#### CommonFormView.swift
You can use ShareFormPreviewView and ShareFormToolView for all CMS in your project but you need to binding variables to both views if you have more fields.

`collectionRefe: .Common` The collection Name
`selectedRow: commonVM.selectedRow` Optional value, (nill if new record)


```sh
                // Note: - preview section
                ScrollView(.vertical, showsIndicators: false) {
                    ShareFormPreviewView(
                        collectionRefe: .Common,
                        selectedRow: commonVM.selectedRow,
                        title: $title,
                        description: $description,
                        imageURL: $imageURL)
                        .environmentObject(imagePicker)
                }
                
                // Note: - input section
                ShareFormToolView(
                    title: $title,
                    description: $description, isCustomCamera: $isCustomCamera
                )
                .environmentObject(imagePicker)
                
```

#### FileManagerVM.swift
Manage local images

#### FileStorage.swift
Manage upload/download images from Firestore.

### Folder CostomImage and CostomCamera
`CostomImage` is the library for Image Picker.

`CostomCamera` is the library for Take photo.


