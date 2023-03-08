//
//  AlamofireNetwork.swift
//  Networking
//
//  Created by Matvei Bykadorov on 05.03.2023.
//  Copyright © 2023 Alexey Efimov. All rights reserved.
//

import Foundation
import Alamofire

class AlamofireNetwork {
    
    class func sendRequest(url: String, completion: @escaping (_ courses: [Course])->()) {
        guard let url = URL(string: url) else {return}
        AF.request(url).validate().responseJSON{ response in
            
            switch response.result {
            case .success(let value):
                    guard let courseArr = Course.getArray(from: value) else {return}
                    completion(courseArr)
            case .failure(let error):
                print(error)
            }
//            guard let statusCode = response.response?.statusCode else {return}
//            print(statusCode)
//            if (200..<300).contains(statusCode) {
//                let value = response.value
//                print(value ?? "nil")
//            } else {
//                let error = response.error
//                print(error ?? "error")
//            }
        }
    }
}
