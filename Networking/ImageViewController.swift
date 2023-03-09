//
//  ImageViewController.swift
//  Networking


import UIKit
import Alamofire

class ImageViewController: UIViewController {
    
    private let url = "https://applelives.com/wp-content/uploads/2016/03/iPhone-SE-11.jpeg"
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.isHidden = true
        activityIndicator.hidesWhenStopped = true
    }
    
    func fetchImage() {
        
//        activityIndicator.isHidden = false
//        activityIndicator.startAnimating()
        
        NetworkManager.downloadImage(url: url) { image in
            self.activityIndicator.stopAnimating()
            self.imageView.image = image
        }
    }
    
    func alamofireFetchImage() {
        
        AF.request(url).responseData { responseData in
            
            switch responseData.result {
                case .success(let data):
                    guard let image = UIImage(data: data) else {return}
                    self.activityIndicator.stopAnimating()
                    self.imageView.image = image
                case .failure(let error):
                    print(error)
            }
        }
    }
    
}
