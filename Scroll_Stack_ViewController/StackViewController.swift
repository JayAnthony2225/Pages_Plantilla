//
//  StackViewController.swift
//  Scroll_Stack_ViewController
//
//  Created by Marco Cruz Velázquez on 2/24/22.
//

import UIKit

class StackViewController: UIViewController {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var imageView: UIImageView!
    
    var imageService: ImageService!
    var horizontalStackView: UIStackView!
    
    func updateUI(){
        horizontalStackView = UIStackView()
        horizontalStackView.axis = .horizontal
        horizontalStackView.spacing = 5.0
        horizontalStackView.alignment = .top
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(horizontalStackView)
        
        let label = UILabel()
        label.text = "Kodemia"
        let dateLabel = UILabel()
        dateLabel.text = Date().formatted()
        
        horizontalStackView.addArrangedSubview(label)
        horizontalStackView.addArrangedSubview(dateLabel)
        
        NSLayoutConstraint.activate([
            horizontalStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            horizontalStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50.0)
        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.startAnimating()
        updateUI()
        imageService = ImageService(delegate: self)
        imageService.downloadImage()
        // Do any additional setup after loading the view.
    }
}

extension StackViewController: ImageServiceDelegate {
    func didFinishedWith(_ result: Result<Data, Error>) {
        //Grand Central Dispatch
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            switch result {
            case .failure(_): //handle error
                break
            case .success(let data):
                self.imageView.image = UIImage(data: data)
            }
        }
    }
    
    func serviceNeedsURL() -> URL {
        return URL(
                  string: "https://upload.wikimedia.org/wikipedia/en/2/27/Face_of_Praying_Mantis.jpg")!
    }
}
