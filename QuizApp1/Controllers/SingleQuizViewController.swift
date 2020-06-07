//
//  SingleQuizViewController.swift
//  QuizApp1
//
//  Created by five on 07/06/2020.
//  Copyright © 2020 five. All rights reserved.
//

import UIKit

class SingleQuizViewController: UIViewController {
    
    @IBOutlet weak var questionViewContainer: UIView!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var questionScrollView: UIScrollView!
    var quiz: QuizStruct?
    var counter:Int=0
    var noOfRightAnswers:Int=0

    override func viewDidLoad() {
        super.viewDidLoad()
        questionScrollView.isHidden=true
        titleLabel.text = quizTitle
        image.kf.setImage(with: imageUrl)
    }
    @IBAction func startButtonTapped(_ sender: UIButton) {
        DispatchQueue.main.async {
            self.questionScrollView.isHidden=false
            self.addQuestionView(self.counter)
        }
        
    }
    
    var quizTitle: String {
        return quiz?.title!.uppercased() ?? ""
    }
    

    var imageUrl: URL? {
        if let urlString = quiz?.image {
            return URL(string: urlString)
        }
        return nil
    }
    
    func addQuestionView(_ number:Int){
        
        let questionView = QuestionView(frame: CGRect(origin: CGPoint(x: 10, y: 10), size: CGSize(width: 300, height: 700)), question: self.quiz!.allquestions[number])
        questionView.delegate=self
        questionScrollView.addSubview(questionView)
       
    }
    func quizFinished(){
        
    }

  

}
extension SingleQuizViewController: QuestionViewDelegate {
    func nextQuestion(_ correct: Bool) {
        
        if correct{noOfRightAnswers=noOfRightAnswers+1}
        counter=counter+1
        if counter==quiz?.allquestions.count {
            quizFinished()
        }else{
                self.addQuestionView(self.counter)
            
        }
    }

}
