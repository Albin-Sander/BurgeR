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
    let stars: Int64
   
    
    
    init(recordId: CKRecord.ID? = nil, name: String, author: String, stars: Int64) {
        self.recordId = recordId
        self.name = name
        self.author = author
        self.stars = stars
    }
    
    static func fromRecord(_ record: CKRecord) -> ItemListing? {
        guard let name = record.value(forKey: "name") as? String, let author = record.value(forKey: "author") as? String, let stars = record.value(forKey: "stars") as? Int64
        else {
            return nil
        }
        
        return ItemListing(recordId: record.recordID, name: name, author: author, stars: stars)
    }
}
