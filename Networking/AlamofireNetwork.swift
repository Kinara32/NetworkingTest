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
    
//    class responseAlamofireData(url: String) {
//        AF.request(url).response{ response in
//            guard let data = response.data, let string = String(data: data, encoding: .utf8) else {return}
//        }
//    }
    
}
