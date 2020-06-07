//
//  QuizService.swift
//  QuizApp1
//
//  Created by five on 10/05/2020.
//  Copyright © 2020 five. All rights reserved.
//

import Foundation
import UIKit

class QuizService {
    
    func fetchQuiz(urlString:String, completion: @escaping (([Quiz]?)-> Void)) {
        if let url=URL(string:urlString){
            var request=URLRequest(url:url)
            let dataTask=URLSession.shared.dataTask(with: request){
                (data,response, error) in
                if let data=data{
                    do{
                        let json=try JSONSerialization.jsonObject(with: data, options:[])
                        print(json)
                        if let jsonDict=json as? [String:Any],
                            let quizzes=jsonDict["quizzes"] as? [[String:Any]]{
                            var quizArray:[Quiz] = []
                            for quiz in quizzes{
                                let quiz=Quiz(json: quiz)
                                quizArray.append(quiz!)
                            }
                            completion(quizArray)
                               
                        }
                    }catch{
                        
                        completion(nil)
                    }
                }else{
                    completion(nil)
                }
            }
            dataTask.resume()
        }else{
            completion(nil)
        }
    }
    

}
