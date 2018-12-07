//
//  SoundClass.swift
//  LaBoiteA
//
//  Created by Pier-Lionel Sgard on 06/12/2018.
//  Copyright © 2018 Diple. All rights reserved.
//

import Foundation

class File {
    var id: String
    var name: String
    var url: URL
    
    init(id: String, name: String, url: String) {
        self.name = name
        let urlString = url + id
        self.url = URL.init(string: urlString)!
        self.id = id
    }
}
