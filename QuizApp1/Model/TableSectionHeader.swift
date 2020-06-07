//
//  TableSectionHeader.swift
//  QuizApp1
//
//  Created by five on 07/06/2020.
//  Copyright © 2020 five. All rights reserved.
//

import UIKit

class TableSectionHeader: UIView {

    var titleLabel: UILabel!
       
       override init(frame: CGRect) {
           super.init(frame: frame)
           
           backgroundColor = UIColor.lightGray
           titleLabel = UILabel()
           titleLabel.text = "Reviews"
           titleLabel.font = UIFont.systemFont(ofSize: 20)
           titleLabel.textColor = UIColor.darkGray
           self.addSubview(titleLabel)
       
       }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
