//
//  QuestionView.swift
//  QuizApp1
//
//  Created by five on 11/05/2020.
//  Copyright © 2020 five. All rights reserved.
//

import UIKit



protocol QuestionViewDelegate: class {
    func nextQuestion(_ correct: Bool)
}

class QuestionView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    var delegate: QuestionViewDelegate?
    var label: UILabel?
    var answer1: UIButton?
    var answer2: UIButton?
    var answer3: UIButton?
    var answer4: UIButton?
    var question1: Question?
    var dispatchGroup=DispatchGroup()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(frame: CGRect, question: Question){
        super.init(frame: frame)
        
        question1 = question
        
        label = UILabel(frame: CGRect(origin: CGPoint(x: 10, y: 10), size: CGSize(width: 200, height: 10)))
        label?.textAlignment = NSTextAlignment.center
        label?.text=""
        label?.text = question.question
        label?.lineBreakMode = .byWordWrapping
        label?.sizeToFit()
        
        
        if let label = label {
            self.addSubview(label)
        }
        
        answer1 = UIButton(frame: CGRect(origin: CGPoint(x: 10, y: 50), size: CGSize(width: 200, height: 30)))
        answer1?.backgroundColor = .gray
        answer1?.setTitle(question.answers?[0], for: .normal)
        answer1?.addTarget(self, action: #selector(answer1Action), for: .touchUpInside)
        
        if let answer1 = answer1{
            self.addSubview(answer1)
        }
        
        answer2 = UIButton(frame: CGRect(origin: CGPoint(x: 10, y: 90), size: CGSize(width: 200, height: 30)))
        answer2?.backgroundColor = .gray
        answer2?.setTitle(question.answers?[1], for: .normal)
        answer2?.addTarget(self, action: #selector(answer2Action), for: .touchUpInside)
        
        if let answer2 = answer2{
            self.addSubview(answer2)
        }
        
        answer3 = UIButton(frame: CGRect(origin: CGPoint(x: 10, y: 130), size: CGSize(width: 200, height: 30)))
        answer3?.backgroundColor = .gray
        answer3?.setTitle(question.answers?[2], for: .normal)
        answer3?.addTarget(self, action: #selector(answer3Action), for: .touchUpInside)
        
        
        if let answer3 = answer3{
            self.addSubview(answer3)
        }
        
        answer4 = UIButton(frame: CGRect(origin: CGPoint(x: 10, y: 170), size: CGSize(width: 200, height: 30)))
        answer4?.backgroundColor = .gray
        answer4?.setTitle(question.answers?[3], for: .normal)
        answer4?.addTarget(self, action: #selector(answer4Action), for: .touchUpInside)
        
        
        if let answer4 = answer4{
            self.addSubview(answer4)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func answer1Action(sender: UIButton!){
        if question1?.correctAnswer == 0 {
            answer1?.backgroundColor = .green
        }else{
            answer1?.backgroundColor = .red
        }
        delegate?.nextQuestion(question1?.correctAnswer==0)
    }
    
    @objc func answer2Action(sender: UIButton!){
    
        dispatchGroup.enter()
        DispatchQueue.main.async {
    
            if self.question1?.correctAnswer == 1 {
                self.answer2?.backgroundColor = .green
                self.dispatchGroup.leave()
            }else{
                self.answer2?.backgroundColor = .red
                self.dispatchGroup.leave()
            }
            
        }
        dispatchGroup.notify(queue: .main){
            self.answered(self.question1?.correctAnswer == 1 )
        }
        
        
    }
    func answered(_ correct:Bool){
       
        delegate?.nextQuestion(correct)
    }
    @objc func answer3Action(sender: UIButton!){
        if question1?.correctAnswer == 2 {
            answer3?.backgroundColor = .green
        }else{
            answer3?.backgroundColor = .red
        }
        delegate?.nextQuestion(question1?.correctAnswer==2)
    }
    
    @objc func answer4Action(sender: UIButton!){
        if question1?.correctAnswer == 3 {
            answer4?.backgroundColor = .green
        }else{
            answer4?.backgroundColor = .red
        }
        delegate?.nextQuestion(question1?.correctAnswer==3)
    }

    
}
