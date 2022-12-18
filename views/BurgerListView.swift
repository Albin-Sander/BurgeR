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
    @State var showAddView = false
    let container = CKContainer(identifier: "iCloud.com.sander.BurgeR")
    
    init(vm: ItemListViewModel) {
        _vm = StateObject(wrappedValue: vm)
        vm.populateItems()
    }
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom) {
                List {
                    ForEach(vm.items, id: \.recordId) { item in
                        NavigationLink(destination: BurgerDetailView(name: item.name, author: item.author, image: item.image, description: item.description)) {
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
                .scrollContentBackground(.hidden)
                HStack() {
                    NavigationLink(destination: AddNewItemView(vm: ItemListViewModel(container: container)), isActive: $showAddView) { EmptyView() }
                    Button {
                        let impactMed = UIImpactFeedbackGenerator(style: .medium)
                        impactMed.impactOccurred()
                        showAddView = true
                    } label: {
                        Image(systemName: "plus")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 15, height: 15)
                            .padding(20)
                    }
                    .background(.purple)
                    .foregroundColor(.white)
                    .cornerRadius(.infinity)
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .trailing)
                }
                
                
            }
            .refreshable {
                vm.populateItems()
            }
            .environment(\.defaultMinListRowHeight, 50)
            .padding()
            .padding(.top, 5)
            .navigationTitle("Wise Burgers")
            
            
        }
    }
}

struct BurgerListView_Previews: PreviewProvider {
    static var previews: some View {
        BurgerListView(vm: ItemListViewModel(container: CKContainer.default()))
    }
}
