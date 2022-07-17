//
//  DocumentsDirectory.swift
//  iFisherman
//
//  Created by Wuz Good on 08.07.2022.
//

import SwiftUI

extension View {
    func loadImage(for object: Fish) -> Image {
        let dummyImage = Image(systemName: "photo.fill")
        do {
            let filename = getDocumentsDirectory().appendingPathComponent(object.imageName)
            let data = try Data(contentsOf: filename)
            if let uiImage = UIImage(data: data) {
                return Image(uiImage: uiImage)
            }
        } catch {
            print("no image found in \(object.name)")
            return dummyImage
        }
        return dummyImage
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
}
