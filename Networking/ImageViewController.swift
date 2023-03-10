//
//  ImageViewController.swift
//  Networking


import UIKit
import Alamofire

class ImageViewController: UIViewController {
    
    private let url = "https://applelives.com/wp-content/uploads/2016/03/iPhone-SE-11.jpeg"
    private let largeImageUrl = "https://i.imgur.com/3416rvI.jpg"
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var completedLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.isHidden = true
        activityIndicator.hidesWhenStopped = true
        progressView.isHidden = true
        completedLabel.isHidden = true
    }
    
    func fetchImage() {
        NetworkManager.downloadImage(url: url) { image in
            self.activityIndicator.stopAnimating()
            self.imageView.image = image
        }
    }
    
    func downloadImageWithProgress() {
        AlamofireNetwork.onProgress = { progress in
            self.progressView.isHidden = false
            self.progressView.progress = Float(progress)
        }
        AlamofireNetwork.completed = { completed in
            self.completedLabel.isHidden = false
            self.completedLabel.text = completed
        }
        AlamofireNetwork.downloadImageWithProgress(url: largeImageUrl) { image in
            self.activityIndicator.stopAnimating()
            self.progressView.isHidden = true
            self.completedLabel.isHidden = true
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
