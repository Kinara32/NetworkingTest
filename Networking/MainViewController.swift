//
//  MainViewController.swift
//  Networking
//
//  Created by Matvei Bykadorov on 01.03.2023.
//  Copyright © 2023 Alexey Efimov. All rights reserved.
//

import UIKit

enum Actions: String, CaseIterable {
    case downloadImage = "Download Image"
    case get = "GET"
    case post = "POST"
    case ourCourses = "Our Courses"
    case uploadImage = "Upload Image"
    case downloadFile = "Download File"
}

private let reuseIdentifier = "Cell"
private let url = "https://jsonplaceholder.typicode.com/posts"

class MainViewController: UICollectionViewController {

    let actions = Actions.allCases

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return actions.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CollectionViewCell
    
        cell.label.text = actions[indexPath.row].rawValue
    
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let action = actions[indexPath.row]
        switch action {
        case .downloadImage:
            performSegue(withIdentifier: "ShowImage", sender: self)
        case .get:
            NetworkManager.getRequest(url: url)
        case .post:
            NetworkManager.postRequest(url: url)
        case .ourCourses:
            performSegue(withIdentifier: "OurCourses", sender: self)
        case .uploadImage:
            print("upload")
        case .downloadFile:
            print(action.rawValue)
        }
    }
}