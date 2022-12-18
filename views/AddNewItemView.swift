//
//  AddNewItemView.swift
//  BurgeR
//
//  Created by Albin Sander on 2022-11-06.
//

import CloudKit
import SwiftUI

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
        NavigationView {
            Form {
                
                
                Section(header:
                            VStack(alignment: .leading) {
                    Text("Name of resturant")
                        .font(.system(size: 15))
                }
                ) {
                    TextField("Enter name", text: $name)
                    PhotoPickerView(selectedImageData: $image)
                        .padding(.bottom, 20)
                        .padding(.top, 20)
                    
                }
                
                
                Section(header: Text("Describe your experience")
                    .font(.system(size: 15))
                ) {
                    TextField("Description", text: $description)
                    
                }
                Section(header: Text("Rating (1-5)")
                    .font(.system(size: 15))
                ) {
                    TextField("How many stars would you rate the burgers?", value: $stars, formatter: NumberFormatter())
                }
                
                Section(header: Text("Written by")
                    .font(.system(size: 15))
                ) {
                    TextField("Author", text: $author)
                }
                
                VStack() {
                    Button {
                        vm.saveItem(name: name, stars: stars, description: description, author: author, image: image!)
                        
                        self.name = ""
                        self.stars = 1
                        self.description = ""
                        self.author = ""
                    } label: {
                        Text("Save")
                            .padding(5)
                    }
                   
                    .background(Color.purple)
                    .buttonStyle(.bordered)
                    .cornerRadius(5)
                    .foregroundColor(Color.white)
                    .disabled(name.isEmpty || description.isEmpty || author.isEmpty)
                }
                .listRowBackground(Color.clear)
            }
            .padding()
            .navigationBarTitle("Add Review")
            .background(Color.gray.opacity(0.07))
        }
        
        .scrollContentBackground(.hidden)

       
        }
    
    }



struct AddNewItemView_Previews: PreviewProvider {
    static var previews: some View {
        AddNewItemView(vm: ItemListViewModel(container: CKContainer.default()))
    }
}
