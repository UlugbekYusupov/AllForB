//
//  DailyListModel.swift
//  AllForB
//
//  Created by Mirzoulugbek Yusupov on 2021/03/12.
//

import UIKit

struct DailyList: Decodable {
    let ReturnCode: Int
    let ThrownException: String?
    let ResultList: [ResultList]
}

struct ResultList: Decodable {
    let InDateTime: String?
    let InOutTimeInfo: String?
    let IssueDate: String?
    let OutDateTime: String?
    let ToInDateTime: String?
    let ToOutDateTime: String?
    let ToWorkTimeInfo: String
}

extension APIService {
    func getDailyList(userId: Int, fromDate: String, toDate: String, completion: @escaping ([ResultList]?, Error?) -> Void) {

        let parameters = ["UserId": userId, "FromDate": fromDate, "ToDate": toDate] as [String : Any]
            let url = URL(string: "http://112.216.225.178:44362/api/attendance/getDailyList")!
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
                let rootJSON = try JSONDecoder().decode(DailyList.self, from: data)
                completion(rootJSON.ResultList, nil)
            }
            
            catch let error {
                print(error.localizedDescription)
                completion(nil, error)
            }
        })
            task.resume()
    }
}
