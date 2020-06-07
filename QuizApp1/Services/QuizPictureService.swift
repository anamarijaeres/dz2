//
//  QuizPictureService.swift
//  QuizApp1
//
//  Created by five on 11/05/2020.
//  Copyright © 2020 five. All rights reserved.
//

import Foundation
import UIKit

class QuizPictureService {
    
    func fetchImage(urlString:String, completion: @escaping ((UIImage?)-> Void)) {
        if let url=URL(string: urlString){
            let request=URLRequest(url:url)
            
            let dataTask=URLSession.shared.dataTask(with: request){
                (data,response,error) in
                print("fetched image")
                if let data=data{
                    let image=UIImage(data:data)
                    completion(image)
                    print("completion called")
                }else{
                    completion(nil)
                }
            }
            print("resuming fetching image")
            dataTask.resume()
        }else{
            completion(nil)
        }
    }
}
