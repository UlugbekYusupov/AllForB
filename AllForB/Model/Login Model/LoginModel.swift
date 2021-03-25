//
//  Model.swift
//  AllForB
//
//  Created by Mirzoulugbek Yusupov on 2021/03/04.
//

import UIKit

struct LoginData: Decodable {
    let LoginToken: String?
    let UserId : Int?
    let PersonId: Int?
    let AccountId: String?
    let NewExpireDateTime: String?
    let ReturnCode: Int?
    let ExceptionMessage: String?
    let ThrownException: String?
}

extension APIService {
    func loginRequest(username: String, password: String, IsLoginSave: Bool, completion: @escaping (LoginData?, Error?) -> Void) {

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
                let rootJSON = try JSONDecoder().decode(LoginData.self, from: data)
                if rootJSON.ReturnCode == 0 {
                    application.saveLoginDataToCoreData(data: rootJSON)
                    userId = (application.getAnyValueFromCoreData(application.getCurrentLoginToken()!, "userId") as! Int)
                }
                completion(rootJSON, nil)
            }
            
            catch let error {
                print(error.localizedDescription)
                completion(nil, error)
            }
        })
            task.resume()
    }
}
