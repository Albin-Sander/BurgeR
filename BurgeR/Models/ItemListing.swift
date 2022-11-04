//
//  ItemListing.swift
//  BurgeR
//
//  Created by Albin Sander on 2022-11-01.
//

import Foundation
import UIKit
import CoreLocation
import CloudKit

struct ItemListing {
    let recordId: CKRecord.ID?
    let name: String
    let author: String
   
    
    
    init(recordId: CKRecord.ID? = nil, name: String, author: String) {
        self.recordId = recordId
        self.name = name
        self.author = author
    }
    
    static func fromRecord(_ record: CKRecord) -> ItemListing? {
        guard let name = record.value(forKey: "name") as? String, let author = record.value(forKey: "author") as? String
        else {
            return nil
        }
        
        return ItemListing(recordId: record.recordID, name: name, author: author)
    }
}
