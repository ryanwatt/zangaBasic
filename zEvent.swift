//
//  zEvent.swift
//  RexEvents
//
//  Created by Paul O'Neill on 2/16/16.
//  Copyright © 2016 Paul O'Neill. All rights reserved.
//

import Foundation
import UIKit

class zEvent : AnyObject {
    var title : String?
    var date : NSString
    var price : NSNumber = 0
    var eDescription : NSString?
    var image : NSString
    var location: NSString
    var id: NSNumber = 0
    
    init() {
        title = ""
        date = ""
        price = 0
        eDescription = ""
        image = ""
        location = ""
        id = 0
    }
    
    func emptyEvent() {
        title = ""
        date = ""
        price = 0
        eDescription = ""
        image = ""
        location = ""
        id = 0
    }
}