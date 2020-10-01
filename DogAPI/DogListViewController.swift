//
//  DogListViewController.swift
//  DogAPI
//
//  Created by Vaibhav Anand on 2020-09-29.
//

import UIKit
import os.log

class DogListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var dogBreadTableView: UITableView!
    
    var dogList = DogList()
    var finalDogBreedList = [DogBreed]()
    
    override func viewDidLoad(){
        super.viewDidLoad()
        dogList.fetchAllDogs{
            (dogBreedResult) -> Void in
            switch dogBreedResult {
                case let .success(dogBreed):
                    self.finalDogBreedList.append(contentsOf: dogBreed)
                case let .failure(error):
                    print(error)
                }
            self.dogBreadTableView.reloadData() // very important this took me 3 hours
        }
        dogBreadTableView.dataSource = self
        dogBreadTableView.delegate = self
    }
    
    
    //MARK:- UITableView Method
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count = 0
        if self.finalDogBreedList[section].subBreeds.count == 0{
            count += 1
        }
        else {
            return self.finalDogBreedList[section].subBreeds.count
        }
        return count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.finalDogBreedList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "productstable")
        if cell == nil {
           cell = UITableViewCell(style: .subtitle, reuseIdentifier: "productstable")
        }
        if finalDogBreedList[indexPath.section].subBreeds.count == 0{
            cell?.textLabel?.text = finalDogBreedList[indexPath.section].name
        }
        else {
            cell?.textLabel?.text = finalDogBreedList[indexPath.section].subBreeds[indexPath.row] + " " + finalDogBreedList[indexPath.section].name
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return finalDogBreedList[section].name
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "detailImageView", sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailImageView" {
            if let secondVC = segue.destination as? DetailImageViewController{
                let indexPath = sender as? IndexPath
                secondVC.passedValue = self.finalDogBreedList[indexPath!.section]
//                if let indexPath = self.dogBreadTableView.indexPathForSelectedRow{
//                    secondVC.passedValue = self.finalDogBreedList[indexPath.row]
//                }
//                else{
//                    print("error in prepreare")
//                }
            }
        }
    }

}

