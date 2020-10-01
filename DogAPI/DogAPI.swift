//
//  DogAPI.swift
//  DogAPI
//
//  Created by Vaibhav Anand on 2020-09-29.
//

import Foundation

//enum method: String{
//     //case of methods if required by API URL
//}

enum DogApiError: Error {
    case invalidJSONData
}

struct DogAPI {
    // baseURL String
    // static to use the variable outside the function without creating the instance, private so that it cannot be edited
    private static let baseURL = "https://dog.ceo/api/"
    
    static func listURL() -> URL {
        let path:String = "breeds/list/all/"
        return URL(string: baseURL + path)!
    }
    
    static func dogImage(fromJSON data:Data) -> ImageResult {
        do {
            let jsonObject = try JSONSerialization.jsonObject(with: data, options: []) as? [String:String]
            let message = jsonObject!["message"]
            return .success(message!)
        } catch let error {
            return .failure(error)
        }
    }
    
    static func dogBreeds(fromJSON data: Data) ->  DogBreedsResult {
        do{
            let jsonObject = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any];
            guard
                let jsonDictionary = jsonObject as? [String: Any],
                let dogBreed = jsonDictionary["message"] as? [String:[String]]
                else {
                    return .failure(DogApiError.invalidJSONData)
                }
            var finalDogBreeds = [DogBreed]()
            for dogBreedJSON in dogBreed {
                guard
                    let name:String = dogBreedJSON.key,
                    let subBreeds:[String] = dogBreedJSON.value else {
                        return .failure(DogApiError.invalidJSONData)
                    }
                let url = "https://dog.ceo/api/breed/\(name)/images/random"
                let dogBreed = DogBreed(name: name, remoteUrl: url, subBreeds: subBreeds)
                finalDogBreeds.append(dogBreed)
            }
            return .success(finalDogBreeds)
    
        } catch let error {
            return .failure(error)
        }
    }
}
