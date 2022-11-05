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
import SwiftUI

struct ItemListing {
    let recordId: CKRecord.ID?
    let name: String
    let author: String
    let stars: Int64
    let image: UIImage
   
    
    
    init(recordId: CKRecord.ID? = nil, name: String, author: String, stars: Int64, image: UIImage) {
        self.recordId = recordId
        self.name = name
        self.author = author
        self.stars = stars
        self.image = image
    }
    
    static func fromRecord(_ record: CKRecord) -> ItemListing? {
        guard let name = record.value(forKey: "name") as? String, let author = record.value(forKey: "author") as? String, let stars = record.value(forKey: "stars") as? Int64, let image = record.value(forKey: "image") as? CKAsset
        else {
            return nil
        }
        guard let data = try? Data(contentsOf: (image.fileURL!)) else { return nil }
        guard let hej = UIImage(data: data) else { return nil }
        return ItemListing(recordId: record.recordID, name: name, author: author, stars: stars, image: hej)
    }
}
