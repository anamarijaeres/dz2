//
//  InitialViewController.swift
//  QuizApp1
//
//  Created by five on 10/05/2020.
//  Copyright © 2020 five. All rights reserved.
//

import UIKit

class InitialViewController: UIViewController {
    
    var allQuizzes: [Quiz] = []
    var hiddenError: Bool=true
    @IBOutlet weak var funFactLabel: UILabel!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var dohvatiButton: UIButton!
   
    @IBOutlet weak var quizImageView: UIImageView!
    @IBOutlet weak var questionViewContainer: UIView!
    @IBAction func dohvatiButtonTapped(_ sender: UIButton) {
        fetchQuiz()
            if(self.hiddenError==false){
             
                print(self.errorLabel.isHidden)
                
        }
    }
    @IBOutlet weak var quizViewContainer: UIView!
    
    func fetchQuiz(){
        let urlString="https://iosquiz.herokuapp.com/api/quizzes"
        let quizService=QuizService()
        print("calling fetch quiz")

        quizService.fetchQuiz(urlString: urlString){(quizzes) in
            
            if let quizzes=quizzes{
            print("fetching quiz")
            DispatchQueue.main.async {
                self.allQuizzes=[]
                //guard let quiz=quiz else {return}
                for quiz in quizzes{
                    print("Ovo je naslov: \(quiz.title)")
                    self.allQuizzes.append(quiz)
                }
                DispatchQueue.main.async{
                    self.addQuizView()
                    self.showPicture()
                    self.addQuestionView()
                    self.numOfNbaQuestions()
                    
                }
            }
            }else{
                DispatchQueue.main.sync {
                    self.errorLabel.isHidden=false
                }
            }
           
        }
               
    }
    func showPicture(){
        var urlString: String? {
            return allQuizzes[2].image
        }
        let quizPictureService=QuizPictureService()
        print("calling fetch image")
        guard let urlS=urlString else{return }
        quizPictureService.fetchImage(urlString: urlS){(image) in
            print("setting image")
            DispatchQueue.main.async {
                self.quizImageView.backgroundColor=self.allQuizzes[2].c?.color
                self.quizImageView.image=image
                self.quizViewContainer.addSubview(self.quizImageView)
            }
            print("image set")
            
        }
        
    }
    func numOfNbaQuestions(){
        var sum = 0
        for quiz in allQuizzes{
            var hasNba: [Question] = []
            hasNba = quiz.allquestions.filter{
                ($0.question?.contains("NBA") ?? false)
            }
            sum += hasNba.count
        }
        funFactLabel?.text! = ""
        funFactLabel?.text! += "Fun Fact: \(sum)"
    }
    
    func addQuestionView(){
        
        let questionView = QuestionView(frame: CGRect(origin: CGPoint(x: 10, y: 10), size: CGSize(width: 300, height: 700)), question: self.allQuizzes[0].allquestions[0])
        questionViewContainer.isHidden=false
        questionViewContainer?.addSubview(questionView)
    }
    
    func addQuizView(){
        
        let quizView = QuizView(frame: CGRect(origin: CGPoint(x: 10, y: 10), size: CGSize(width: 100, height: 100)), quizzes: self.allQuizzes)
        quizViewContainer?.backgroundColor=allQuizzes[2].c?.color
        quizViewContainer?.addSubview(quizView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
