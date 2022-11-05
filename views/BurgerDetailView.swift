//
//  BurgerDetailView.swift
//  BurgeR
//
//  Created by Albin Sander on 2022-11-04.
//

import SwiftUI

struct BurgerDetailView: View {
    let author: String
    let image: UIImage?
    var body: some View {
        VStack {
            Image(uiImage: image!)
                .resizable()
                .scaledToFit()
            Text("Author \(author)")
        }
        
    }
}

struct BurgerDetailView_Previews: PreviewProvider {
    static var previews: some View {
        BurgerDetailView(author: "Albin", image: nil)
    }
}
