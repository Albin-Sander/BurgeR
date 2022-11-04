//
//  ContentView.swift
//  BurgeR
//
//  Created by Albin Sander on 2022-11-01.
//

import SwiftUI
import CloudKit

struct ContentView: View {
    let container = CKContainer(identifier: "iCloud.com.sander.BurgeR")
    var body: some View {
        VStack {
            BurgerListView(vm: ItemListViewModel(container: container))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
