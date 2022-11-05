//
//  BurgerDetailView.swift
//  BurgeR
//
//  Created by Albin Sander on 2022-11-04.
//

import SwiftUI

struct BurgerDetailView: View {
    let name: String
    let author: String
    let image: UIImage?
    var body: some View {
        VStack {
            Text("\(name)")
                .font(.headline)
            Image(uiImage: image!)
                .resizable()
                .frame(width: 300, height: 300)
                .cornerRadius(15)
                .scaledToFit()
                .padding()
             
            Text("Written by: \(author)")
        }
        
    }
}

struct BurgerDetailView_Previews: PreviewProvider {
    static var previews: some View {
        BurgerDetailView(name: "Mcdonalds", author: "Albin", image: nil)
    }
}
