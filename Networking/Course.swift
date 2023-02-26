//
//  Course.swift
//  Networking
//
//  Created by Matvei Bykadorov on 26.02.2023.
//  Copyright © 2023 Alexey Efimov. All rights reserved.
//

import Foundation

struct Course: Codable {
    
    let id: Int?
    let name: String?
    let link: String?
    let imageUrl: String?
    let number_of_lessons: Int?
    let number_of_tests: Int?
}

struct WebsiteDescription: Codable {
    
    let websiteDescription: String?
    let websiteName: String?
    let courses: [Course]
}
