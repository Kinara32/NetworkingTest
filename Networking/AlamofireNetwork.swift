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
    
    class func sendRequest(url: String) {
        guard let url = URL(string: url) else {return}
        AF.request(url).responseJSON { response in
            print(response)
        }
    }
}
