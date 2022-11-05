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
                List {
                    ForEach(vm.items, id: \.recordId) { item in
                        NavigationLink(destination: BurgerDetailView(author: item.author, image: item.image)) {
                            HStack {
                                Text(item.name)
                                ForEach(1...Int(item.stars), id: \.self) {_ in
                                    Image(systemName: "star.fill")
                                        .foregroundColor(Color.yellow)
                                        .font(.system(size: 15))
                                }
                                
                            }
                            
                        }
                    }
                }
                .refreshable {
                    vm.populateItems()
                }
                .environment(\.defaultMinListRowHeight, 50)
            .padding()
            .padding(.top, 5)
            .navigationTitle("BurgeR")
            
        }
    }
}

struct BurgerListView_Previews: PreviewProvider {
    static var previews: some View {
        BurgerListView(vm: ItemListViewModel(container: CKContainer.default()))
    }
}
