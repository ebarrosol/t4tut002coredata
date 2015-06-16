//
//  Lista.swift
//  T4Tut002Coredata
//
//  Created by Efren Alejandro Barroso Llanes on 16/06/15.
//  Copyright (c) 2015 EBL. All rights reserved.
//

import UIKit
import CoreData

@objc(Lista)

class Lista: NSManagedObject
{

    @NSManaged var elemento: String
    @NSManaged var cantidad: String
    @NSManaged var info: String

}
