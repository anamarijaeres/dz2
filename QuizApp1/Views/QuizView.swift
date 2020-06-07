//
//  QuizView.swift
//  QuizApp1
//
//  Created by five on 11/05/2020.
//  Copyright © 2020 five. All rights reserved.
//

import UIKit

class QuizView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        
        
    }
    */
    
    var label: UILabel?
    
    override init(frame: CGRect){
        super.init(frame: frame)
    }
    
    init(frame: CGRect, quizzes: [Quiz]){
        super.init(frame: frame)
        label = UILabel(frame: CGRect(origin: CGPoint(x: 10, y: 10), size: CGSize(width: 40, height: 40)))
        label?.text = quizzes[0].title
        label?.lineBreakMode = .byWordWrapping
        label?.sizeToFit()
    
        
        if let label = label {
            self.addSubview(label)
        }
        //self.draw(frame)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
