//
//  NetworkController.swift
//  ImgurSearch
//
//  Created by Jake Gray on 11/20/18.
//  Copyright © 2018 Jake Gray. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireImage

class NetworkController {
    
    static let shared = NetworkController()
    let imageCache = NSCache<NSString, UIImage>()
    
    let baseURL = URL(string: "https://api.imgur.com/3/gallery/search/time")!
    let clientId = "Client­-ID 6979af486ec3498"
    func fetchPosts(withSearchTerm searchTerm: String, onPage page: Int, completion: @escaping ([Post]?) -> Void ) {
        let url = baseURL.appendingPathComponent(String(page))
        let params: [String: Any] = [
            "q" : searchTerm
        ]
        let headers: HTTPHeaders = [
            "Authorization": "Client-ID 126701cd8332f32"
        ]
        
        Alamofire.request(url, method: .get, parameters: params, headers: headers).responseJSON { (response) in
            
            if let error = response.error {
                print(error.localizedDescription)
                completion(nil)
                return
            }
            
            if let data = response.data {
                
                let jsonDecoder = JSONDecoder()
                
                do {
                    let jsonDict = try jsonDecoder.decode(JSONDictionary.self, from: data)
                    let posts = jsonDict.posts
                    let photoPosts = posts.filter({ (post) -> Bool in
                        if post.images != nil {
                            if let link = post.images?.first?.link{
                                if link.contains(".mp4") || link.contains(".gif"){
                                    return false
                                }
                            }
                        } else {
                            if let link = post.link {
                                if link.contains(".mp4") || link.contains(".gif"){
                                    return false
                                }
                            }
                        }
                        return true 
                    })
                    
                    completion(photoPosts)
                } catch let error{
                    print(error.localizedDescription)
                    completion(nil)
                    return
                }
            }
        }
    }
    
    
//    func fetchImage(withURLString urlString: String, completion: @escaping(UIImage?) -> Void) {
//        guard let url = URL(string: urlString) else {
//            print("Error making URL")
//            return
//        }
//        Alamofire.request(url, method: .get).responseImage { response in
//            guard let image = response.result.value else {
//                print("Error fetching image for url: \(url)")
//                completion(nil)
//                return
//            }
//            DispatchQueue.main.async {
//                completion(image)
//            }
//
//        }
//    }
}
