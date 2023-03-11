//
//  AlamofireNetwork.swift
//  Networking
//
//  Created by Matvei Bykadorov on 05.03.2023.
//  Copyright © 2023 Alexey Efimov. All rights reserved.
//

import Foundation
import Alamofire
import UIKit

class AlamofireNetwork {
    
    static var onProgress: ((Double) -> ())?
    static var completed: ((String) -> ())?
    
    class func sendRequest(url: String, completion: @escaping (_ courses: [Course])->()) {
        guard let url = URL(string: url) else {return}
        AF.request(url).validate().responseDecodable { (response: AFDataResponse<[Course]>) in
            switch response.result {
                case .success(let value):
//                    guard let courseArr = Course.getArray(from: value) else {return}
                    completion(value)
                case .failure(let error):
                    print(error)
            }
        }
    }
    
    class func responseData(url: String) {
        AF.request(url).responseData { response in
            switch response.result {
                case .success(let data):
                    guard let string = String(data: data, encoding: .utf8) else {return}
                    print(string)
                case .failure(let error):
                    print(error)
            }
        }
    }
    
    class func responseString(url: String) {
        AF.request(url).responseString { response in
            switch response.result {
                case .success(let data):
                    print(data)
                case .failure(let error):
                    print(error)
            }
        }
    }
    
    class func responseAlamofireData(url: String) {
        AF.request(url).response{ response in
            guard let data = response.data, let string = String(data: data, encoding: .utf8) else {return}
            print(string)
        }
    }
    
    class func downloadImageWithProgress(url: String, completion: @escaping (_ image: UIImage) -> ()) {
        guard let url = URL(string: url) else {return}
        AF.request(url).validate().downloadProgress { progress in
            print("totalUnitCount:\n", progress.totalUnitCount)
            print("completedUnitCount:\n", progress.completedUnitCount)
            print("fractionCompleted:\n", progress.fractionCompleted)
            print("localizedDescription:\n", progress.localizedDescription!)
            self.onProgress?(progress.fractionCompleted)
            self.completed?(progress.localizedDescription)
        }.response { response in
            guard let data = response.data, let image = UIImage(data: data) else {return}
            DispatchQueue.main.async {
                completion(image)
            }
        }
    }
    
    class func postRequest(url: String, completion: @escaping (_ courses: [Course])->()) {
        guard let url = URL(string: url) else {return}
        
        let userData: [String: Any] = ["name": "Network Request",
                                       "link": "https://swiftbook.ru/contents/our-first-applications/",
                                       "imageUrl": "https://swiftbook.ru/wp-content/uploads/sites/2/2018/08/notifications-course-with-background.png"]
//                                       "numberOfLessons": 18]
//                                       "numberOfTests": 10]
        AF.request(url, method: .post, parameters: userData).responseDecodable { (response: AFDataResponse<Course>) in
            guard let statusCode = response.response?.statusCode else {return}
            print(statusCode)
            switch response.result {
                case .success(let value):
                    print(value)
                    var courseArr = [Course]()
                    courseArr.append(value)
                    completion(courseArr)
                case .failure(let error):
                    print(error)
            }
        }
    }
    
    class func putRequest(url: String, completion: @escaping (_ courses: [Course])->()) {
        guard let url = URL(string: url) else {return}
        
        let userData: [String: Any] = ["name": "Network Request with Alamofire",
                                       "link": "https://swiftbook.ru/contents/our-first-applications/",
                                       "imageUrl": "https://swiftbook.ru/wp-content/uploads/sites/2/2018/08/notifications-course-with-background.png"]
//                                       "numberOfLessons": 18]
//                                       "numberOfTests": 10]
        AF.request(url, method: .put, parameters: userData).responseDecodable { (response: AFDataResponse<Course>) in
            guard let statusCode = response.response?.statusCode else {return}
            print(statusCode)
            switch response.result {
                case .success(let value):
                    print(value)
                    var courseArr = [Course]()
                    courseArr.append(value)
                    completion(courseArr)
                case .failure(let error):
                    print(error)
            }
        }
    }
}
