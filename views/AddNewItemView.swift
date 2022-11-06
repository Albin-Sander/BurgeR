//
//  AddNewItemView.swift
//  BurgeR
//
//  Created by Albin Sander on 2022-11-06.
//

import SwiftUI
import CloudKit

struct AddNewItemView: View {
    @State var name: String
    @State var stars: Int64
    @State var description: String
    @State var author: String
    @State var image: Data?
    @StateObject private var vm: ItemListViewModel
    
    init(vm: ItemListViewModel) {
        _vm = StateObject(wrappedValue: vm)
        vm.populateItems()
        name = ""
        stars = 1
        description = ""
        author = ""
    }
    var body: some View {
        Form {
            VStack {
                Spacer()
                Section(header: Text("Enter the name of the burger resturant")
                    .font(.system(size: 15))
                ) {
                    TextField("Enter name", text: $name)
                        .textFieldStyle(.roundedBorder)
                }
            
                PhotoPickerView(selectedImageData: $image)
                    .padding(.bottom, 20)
                    .padding(.top, 20)
                Section(header: Text("Describe your experience")
                    .font(.system(size: 15))
                ) {
                    TextField("Description", text: $description)
                        .textFieldStyle(.roundedBorder)
                }
                Spacer()
                Section(header: Text("How many stars would you rate the burgers?")
                    .font(.system(size: 15))
                ) {
                    TextField("How many stars would you rate the burgers?", value: $stars, formatter: NumberFormatter())
                        .textFieldStyle(.roundedBorder)
                }
                Spacer()
                Section(header: Text("Written by")
                    .font(.system(size: 15))
                ) {
                    TextField("Author", text: $author)
                        .textFieldStyle(.roundedBorder)
                }
                Spacer()
                Button {
                    vm.saveItem(name: name, stars: stars, description: description, author: author, image: image!)
                    
                    self.name = ""
                    self.stars = 1
                    self.description = ""
                    self.author = ""
                } label: {
                    Text("Save")
                }
                .background(Color.purple)
                .buttonStyle(.bordered)
                .foregroundColor(Color.white)
                .disabled(name.isEmpty || description.isEmpty || author.isEmpty)
                
                
                
                
            }
            .padding()
        }
    }
}

struct AddNewItemView_Previews: PreviewProvider {
    static var previews: some View {
       AddNewItemView(vm: ItemListViewModel(container: CKContainer.default()))
    }
}
