//
//  ListOfQuizzesViewController.swift
//  QuizApp1
//
//  Created by five on 07/06/2020.
//  Copyright © 2020 five. All rights reserved.
//

import UIKit


struct QuizStruct {
    var title:String?
    var description: String?
    var level:String?
    var image:String?
    var category: Category?
    var allquestions: [Question]=[]
}
class ListOfQuizzesViewController: UIViewController {
    
    var allQuizzes: [Quiz] = []
       var hiddenError: Bool=true
    var quizzes1:[QuizStruct]=[]
    var quizzes2:[QuizStruct]=[]
    var sectionQuizzes:[[QuizStruct]]=[[]]
    let dispatchGroup=DispatchGroup()
    
    
           
    var refreshControl: UIRefreshControl!
    //var tableFooterView: ReviewsTableViewFooterView!
       
    let cellReuseIdentifier = "cellReuseIdentifier"
    
    @IBOutlet weak var quizTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupData()
        
       
       
        // Do any additional setup after loading the view.
    }
    func setupTableView(){
        quizTableView.backgroundColor = UIColor.lightGray
              quizTableView.delegate = self
              quizTableView.dataSource = self
              quizTableView.separatorStyle = .none
              
              refreshControl = UIRefreshControl()
              refreshControl.addTarget(self, action: #selector(ListOfQuizzesViewController.refresh), for: UIControl.Event.valueChanged)
              quizTableView.refreshControl = refreshControl

              quizTableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: cellReuseIdentifier)
              
              
        
    }
     func setupData() {
           fetchQuiz()
            dispatchGroup.notify(queue: .main){
                print("ZADNJE")
                self.refresh()
            }
       }
       
       @objc func refresh() {
           DispatchQueue.main.async {
            self.sectionQuizzes.append(self.quizzes1)
            self.sectionQuizzes.append(self.quizzes2)
            self.quizTableView.reloadData()
            self.refreshControl.endRefreshing()
           }
       }
       
  

  func fetchQuiz(){
    dispatchGroup.enter()
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
            
            for quiz in self.allQuizzes{
                
                var newQuiz = QuizStruct()
                newQuiz.title = quiz.title
                newQuiz.description=quiz.description
                newQuiz.image=quiz.image
                newQuiz.category=quiz.c
                newQuiz.allquestions=quiz.allquestions
                if quiz.level==1{
                    newQuiz.level="*"
                }
                else if quiz.level==2{
                    newQuiz.level="**"
                }else{
                    newQuiz.level="***"
                }
                switch quiz.c{
                case .SPORTS:
                    self.quizzes1.append(newQuiz)
                case .SCIENCE:
                    self.quizzes2.append(newQuiz)
                case .none:
                    break
                }
            }
          }
          }else{
          }
        self.dispatchGroup.leave()
      }
     
    }
    }
   
extension ListOfQuizzesViewController: UITableViewDataSource, UITableViewDelegate {
   
        func numberOfSections(in tableView: UITableView) -> Int {
            return sectionQuizzes.count
        }
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return sectionQuizzes[section].count
        }
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 150
        }
        func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 50))
            let label = UILabel()
            label.frame = CGRect.init(x: 5, y: 5, width: headerView.frame.width-10, height: headerView.frame.height-10)
            if(section==0){
                label.text = "Quizzes"
                headerView.backgroundColor=UIColor.white
            }else {
            label.text = sectionQuizzes[section][0].category?.name
            headerView.backgroundColor = sectionQuizzes[section][0].category?.color
            }
            headerView.addSubview(label)
            return headerView
        }
        func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return 50
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! TableViewCell
            cell.titleLabel?.text=sectionQuizzes[indexPath.section][indexPath.row].title
            cell.descriptionTextView?.text=sectionQuizzes[indexPath.section][indexPath.row].description
            cell.levelLabel?.text=sectionQuizzes[indexPath.section][indexPath.row].level
            cell.setup(quiz: sectionQuizzes[indexPath.section][indexPath.row])
            cell.backgroundColor=sectionQuizzes[indexPath.section][0].category?.color
            return cell
        }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
          tableView.deselectRow(at: indexPath, animated: true)
          
        let quiz = sectionQuizzes[indexPath.section][indexPath.row]
              let singleQuizViewController = SingleQuizViewController()
              singleQuizViewController.quiz=quiz
              navigationController?.pushViewController(singleQuizViewController, animated: true)
            self.present(singleQuizViewController, animated: true, completion: nil)
      }

    }



