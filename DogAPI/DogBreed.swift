//
//  DogBreed.swift
//  DogAPI
//
//  Created by Vaibhav Anand on 2020-09-29.
//

import Foundation

class DogBreed{
    let name: String
    let remoteUrl: URL
    let subBreeds: [String]
    
    init(name: String, remoteUrl:String, subBreeds:[String]) {
        self.name = name
        if let url = URL(string: remoteUrl){
            self.remoteUrl = url
        } else{
            self.remoteUrl = URL(string: "")!
        }
        self.subBreeds = subBreeds
    }
}
