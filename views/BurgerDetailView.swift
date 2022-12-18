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
    let description: String
    var body: some View {
        VStack {
            Text("\(name)")
                .font(.system(size: 36))
            Image(uiImage: image!)
                .resizable()
                .frame(width: 300, height: 300)
                .cornerRadius(15)
                .scaledToFit()
                .padding()
            
            Text("\(description)")
            
            Spacer()
             
            Text("Author: \(author)")
            
            Spacer()
        }
        
    }
}

struct BurgerDetailView_Previews: PreviewProvider {
    static var previews: some View {
        BurgerDetailView(name: "Mcdonalds", author: "Albin", image: nil, description: "Very good burgers")
    }
}
