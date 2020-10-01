//
//  DetailImageViewController.swift
//  DogAPI
//
//  Created by Vaibhav Anand on 2020-09-30.
//

import UIKit

class DetailImageViewController: UIViewController {
    let dogList = DogList()

    @IBOutlet weak var dogImageView:UIImageView!
    var passedValue: DogBreed!
    override func viewDidLoad() {
        updateImageView(for: passedValue)
    }
    func updateImageView(for dogBreed: DogBreed){
        dogList.fetchImage(for: dogBreed){
            (imageResult) -> Void in
            switch imageResult {
            case let .success(image):
                let imageUrl = URL(string: image)!
                let imageData = try! Data(contentsOf: imageUrl)
                self .dogImageView.image = UIImage(data: imageData)
            case .failure(_):
                print("error in image loading")
                // add image not found label or something.
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
