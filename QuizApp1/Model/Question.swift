//
//  Question.swift
//  QuizApp1
//
//  Created by five on 10/05/2020.
//  Copyright © 2020 five. All rights reserved.
//

import Foundation

class Question{
    var answers:[String]?=[]
    let correctAnswer: Int?
    let question: String?
    
    
    init(json:Any){
        if let questions=json as? [String:Any],
            let question=questions["question"] as? String,
            let answers=questions["answers"] as? [String],
            let correctAnswer=questions["correct_answer"] as? Int{
            self.question=question
            self.answers=answers
            self.correctAnswer=correctAnswer ?? -1
        }else{
            self.answers=nil
            self.correctAnswer=nil
            self.question=nil
            
        }
    }
        
    init(correctAnswer: String, answers: [String], question: String){
        self.correctAnswer = Int(correctAnswer) ?? -1
        self.question=question
        for a in answers{
            self.answers?.append(a)
        }
    }
}
