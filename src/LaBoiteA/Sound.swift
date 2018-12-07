//
//  Podcast.swift
//  PodcastMenu
//
//  Created by Guilherme Rambo on 11/11/16.
//  Copyright © 2016 Guilherme Rambo. All rights reserved.
//

import Foundation

struct Sound: Equatable {
    
    let name: String
    let link: URL
    
    static func == (lhs: Sound, rhs: Sound) -> Bool {
        return lhs.name == rhs.name && lhs.link == rhs.link
    }
    
    static func ConvertTo(input: File) -> Sound {
        return Sound(name: input.name, link: input.url)
    }
}
