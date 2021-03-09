//
//  APIService.swift
//  AllForB
//
//  Created by Mirzoulugbek Yusupov on 2021/03/04.
//

import UIKit
import Alamofire

class APIService {
    
    static let shared = APIService()
    
    func featuredList_fetch(completion: @escaping (LoginData?, Error?) -> ()) {
        
        let featured_listURL = "http://112.216.225.178:44362/api/userlogin/checkLogin"
        
        guard let url = URL(string: featured_listURL) else { return }
        
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            
            if let err = err {
                print("Failed to fetch dat: ", err)
                completion(nil,nil)
                return
            }
            
            guard let data = data else {return}
            
            do {
                let rootJSON = try JSONDecoder().decode(LoginData.self, from: data)
                completion(rootJSON.self, nil)
            }
                
            catch let jsonErr {
                print("failed to decode json: ", jsonErr)
                completion(nil,jsonErr)
            }
            
            }.resume()
    }

}
