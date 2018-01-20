//
//  Pais.swift
//  DesafioRealm
//
//  Created by Swift on 19/01/2018.
//  Copyright © 2018 Swift. All rights reserved.
//

import Foundation
import RealmSwift

class Pais : Object {
    
    @objc dynamic var nome = ""
    
    let latitude = RealmOptional<Float>()
    
    let longitude = RealmOptional<Float>()
    
    
}
