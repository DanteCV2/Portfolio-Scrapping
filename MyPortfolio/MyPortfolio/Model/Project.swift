//
//  Project.swift
//  MyPortfolio
//
//  Created by Dante Cervantes Vega on 17/01/20.
//  Copyright © 2020 Dante Cervantes Vega. All rights reserved.
//

import Foundation

class Project{
    
    var title : String
    var description : String
    var imageUrl : String
    var gitUrl : String
    
    init(title : String, description : String, imageUrl : String, gitUrl : String) {
        self.title = title
        self.description = description
        self.imageUrl = imageUrl
        self.gitUrl = gitUrl
    }
}
