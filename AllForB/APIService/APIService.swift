//
//  APIService.swift
//  AllForB
//
//  Created by Mirzoulugbek Yusupov on 2021/03/04.
//

import UIKit

class APIService {
    
    static let shared = APIService()
    
    func loginRequest(username: String, password: String, IsLoginSave: Bool, completion: @escaping ([String: Any]?, Error?) -> Void) {

            let parameters = ["AccountId": username, "PwdCrypt": password, "IsLoginSave": IsLoginSave] as [String : Any]
            let url = URL(string: "http://112.216.225.178:44362/api/userlogin/checkLogin")!
            let session = URLSession.shared
            var request = URLRequest(url: url)
            request.httpMethod = "POST"

            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            }
            
            catch let error {
                print(error.localizedDescription)
                completion(nil, error)
            }

            request.addValue("application/json;charset=utf-8", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            
            
        let task = session.dataTask(with: request, completionHandler: { data, response, error in
                
            guard error == nil else {
                completion(nil, error)
                return
            }

            guard let data = data else {
                completion(nil, NSError(domain: "dataNilError", code: -100001, userInfo: nil))
                return
            }
                        
            do {
                guard let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] else {
                    completion(nil, NSError(domain: "invalidJSONTypeError", code: -100009, userInfo: nil))
                    return
                }
                
                let data = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
                let decoder = JSONDecoder()
                let loginData = try decoder.decode(LoginData.self, from: data)
                
                DispatchQueue.main.async {
                    (UIApplication.shared.delegate as! AppDelegate).saveLoginDataToCoreData(data: loginData)
                }
                
                completion(json, nil)
                
            }
            catch let error {
                print(error.localizedDescription)
                completion(nil, error)
            }
        })
        
            task.resume()
    }
}


