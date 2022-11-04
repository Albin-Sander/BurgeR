//
//  BurgerListView.swift
//  BurgeR
//
//  Created by Albin Sander on 2022-11-04.
//

import SwiftUI
import CloudKit

struct BurgerListView: View {
    @StateObject private var vm: ItemListViewModel
    
    init(vm: ItemListViewModel) {
        _vm = StateObject(wrappedValue: vm)
        vm.populateItems()
    }
    var body: some View {
        NavigationView {
            VStack {
                Text("Hello World")
                List {
                    ForEach(vm.items, id: \.recordId) { item in
                        NavigationLink(destination: BurgerDetailView(author: item.author)) {
                            Text(item.name)
                        }
                    }
                }
            }
            .padding()
        }
    }
}

struct BurgerListView_Previews: PreviewProvider {
    static var previews: some View {
        BurgerListView(vm: ItemListViewModel(container: CKContainer.default()))
    }
}
