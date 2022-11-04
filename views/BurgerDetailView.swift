//
//  BurgerDetailView.swift
//  BurgeR
//
//  Created by Albin Sander on 2022-11-04.
//

import SwiftUI

struct BurgerDetailView: View {
    let author: String
    var body: some View {
        VStack {
            Text("Author \(author)")
        }
        
    }
}

struct BurgerDetailView_Previews: PreviewProvider {
    static var previews: some View {
        BurgerDetailView(author: "Albin")
    }
}
