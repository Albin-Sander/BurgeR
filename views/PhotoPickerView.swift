//
//  PhotoPickerView.swift
//  BurgeR
//
//  Created by Albin Sander on 2022-11-06.
//

import SwiftUI
import PhotosUI

struct PhotoPickerView: View {
    
    @State private var selectedItem: PhotosPickerItem? = nil
    @Binding var selectedImageData: Data?
    @State private var uiImages: UIImage? = nil
    
    
    var body: some View {
        PhotosPicker(selection: $selectedItem, matching: .images, photoLibrary: .shared()) {
            Text("Select a photo")
        }
        .onChange(of: selectedItem) { newItem in
            Task {
                if let data = try? await newItem?.loadTransferable(type: Data.self) {
                    selectedImageData = data
                }
            }
        }
        
        if let selectedImageData,
           let uiImage = UIImage(data: selectedImageData) {
            Image(uiImage: uiImage)
                .resizable()
                .scaledToFit()
                .frame(width: 250, height: 250)
        }
    }
}


