//
//  DogList.swift
//  DogAPI
//
//  Created by Vaibhav Anand on 2020-09-29.
//

import UIKit

enum ImageResult{
    case success(String)
    case failure(Error)
}

enum PhotoError: Error{
    case imageCreationError
}

enum DogBreedsResult {
    case success([DogBreed])
    case failure(Error)
}

// create a wrapper of API response
class DogList{
    // init URL session to create task
    private let session : URLSession = {
        let config = URLSessionConfiguration.default
        return URLSession(configuration: config)
    }()
    
    // method to fetch data
    func fetchAllDogs(completion: @escaping (DogBreedsResult) -> Void){
        let url = DogAPI.listURL()
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request){
            (data, response, error) -> Void in
            let result = self.processDogBreedRequest(data: data, error: error)
            OperationQueue.main.addOperation {
                completion(result)
            }
            print(result)
        }
        task.resume()
    }
    
    private func processDogBreedRequest(data: Data?, error: Error?) -> DogBreedsResult{
        guard let jsonData = data else {
            return .failure(error!)
        }
        return DogAPI.dogBreeds(fromJSON: jsonData)
    }
    
    func fetchImage(for dogBreed: DogBreed, competion: @escaping (ImageResult) -> Void){
        let dogBreedURL = dogBreed.remoteUrl
        let request = URLRequest(url: dogBreedURL)
        let task = session.dataTask(with: request){
            (data, response, error) -> Void in
            let result = self.processImageRequest(data: data, error: error)
            OperationQueue.main.addOperation {
                competion(result)
            }
        }
        task.resume()
    }
    
    private func processImageRequest(data: Data?, error: Error?) -> ImageResult {
        guard let jsonObject = data else {
            return .failure(error!)
        }
        return DogAPI.dogImage(fromJSON: data!)
    }
}
