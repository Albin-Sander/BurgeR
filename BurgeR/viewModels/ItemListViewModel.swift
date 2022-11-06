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
    
    
    func saveItem(name: String, stars: Int64, description: String, author: String, image: Data) {
        
        let record = CKRecord(recordType: RecordType.establishment.rawValue)
        
        guard let imageName = UIImage(data: image), let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first?.appendingPathComponent("hej.jpg"), let data = imageName.jpegData(compressionQuality: 1.0) else { return }
        
        let asset: CKAsset
        
        do {
            try data.write(to: url)
            asset = CKAsset(fileURL: url)
            
            let itemListing = ItemListing(name: name, author: author, stars: stars, image: asset, description: description)
            
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
        } catch let error {
            print(error)
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
        
        let data = NSData(contentsOf: itemListing.image.fileURL!)
        return UIImage(data: data as! Data)!
        
    }
    
    var description: String {
        itemListing.description
    }
}
