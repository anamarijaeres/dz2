//
//  Category.swift
//  QuizApp1
//
//  Created by five on 11/05/2020.
//  Copyright © 2020 five. All rights reserved.
//

import Foundation
import UIKit
enum Category{
    
    case SCIENCE
    case SPORTS
    
    var color:UIColor{
        switch self{
        case .SPORTS:
            return .green
        case .SCIENCE:
            return .cyan
        }
    }
    var name:String{
        switch self {
        case .SPORTS:
            return "SPORTS"
        case .SCIENCE:
            return "SCIENCE"
    
        }
    }
}
