//
//  ItemListViewModel.swift
//  BurgeR
//
//  Created by Albin Sander on 2022-11-01.
//

import Foundation
import CloudKit
import SwiftUI

enum RecordType: String {
    case establishment = "Establishment"
}


class ItemListViewModel: ObservableObject {
    
    private var database: CKDatabase
    private var container: CKContainer
    
    @Published var items: [ItemViewModel] = []
    
    init(container: CKContainer) {
        self.container = container
        self.database = self.container.publicCloudDatabase
    }
    
    
    func saveItem(name: String, stars: Int64, description: String, author: String) {
        
        let record = CKRecord(recordType: RecordType.establishment.rawValue)
        let imageName = UIImage(named: "mcdonalds")!
        let itemListing = ItemListing(name: name, author: author, stars: stars, image: imageName, description: description)
        
        record.setValuesForKeys(itemListing.toDictionary())
        
        // saving to database
        self.database.save(record) { newRecord, error in
            if let error = error {
                print(error)
            } else {
                if let newRecord = newRecord {
                    print("Saved")
                }
            }
        }
        
    }
    
    
    
    func populateItems() {
        var items: [ItemListing] = []
        let query = CKQuery(recordType: RecordType.establishment.rawValue, predicate: NSPredicate(value: true))
        
        database.fetch(withQuery: query) { result in
            switch result {
            case .success(let result):
                result.matchResults.compactMap{ $0.1 }
                    .forEach {
                        switch $0 {
                        case .success(let record):
                            if let itemListing = ItemListing.fromRecord(record) {
                                items.append(itemListing)
                            }
                        case .failure(let error):
                            print(error)
                        }
                    }
                
                DispatchQueue.main.async {
                    self.items = items.map(ItemViewModel.init)
                }
                
                
            case .failure(let error):
                print(error)
            }
    
        }
    }
}

struct ItemViewModel {
    let itemListing: ItemListing
    
    var recordId: CKRecord.ID? {
        itemListing.recordId
    }
    
    var name: String {
        itemListing.name
    }
    
    var author: String {
        itemListing.author
    }
    
    var stars: Int64 {
        itemListing.stars
    }
    
    var image: UIImage {
        itemListing.image
    }
    
    var description: String {
        itemListing.description
    }
}
