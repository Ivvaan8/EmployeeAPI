//
//  ErrorViewController.swift
//  EmployeeAPI
//
//  Created by Иван Майоров on 10.05.2023.
//

import UIKit

final class ErrorViewController: UIViewController {
    
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var errorImage: UIImageView!
    
    private let networkManager = NetworkManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        loadData()
    
    }
    
    private func loadData() {
        networkManager.fechImage(from: Link.networkErrorImage.url) { [weak self] result in
            switch result {
                
            case .success(let imageData):
                self?.errorImage.image = UIImage(data: imageData)
                self?.activityIndicator.stopAnimating()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    

   

}
