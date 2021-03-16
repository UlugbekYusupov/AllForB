//
//  GetInfoModel.swift
//  AllForB
//
//  Created by Mirzoulugbek Yusupov on 2021/03/15.
//

import UIKit


struct UserInfo: Decodable {
    let DutyCodeName: String
    let PersonId: Int
    let DutyCodeId: Int
    let CompanyName: String
    let UserId: Int
    let AttendanceTypeName: String?
    let ThrownException: String?
    let CompanyId: Int
    let ReturnCode: Int
    let JobRankCodeId: Int
    let ExceptionMessage: String?
    let JobRankCodeName: String
    let AttendanceTypeId: Int?
    let PersonName: String
    let SiteId: Int
}


extension APIService {
    func getInfo(userId: Int, companyId: Int, completion: @escaping (UserInfo?, Error?) -> Void) {

        let parameters = ["UserId": userId, "CompanyId": companyId] as [String : Any]
            let url = URL(string: "http://112.216.225.178:44362/api/userinfo/getInfo")!
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
                let rootJSON = try JSONDecoder().decode(UserInfo.self, from: data)
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
