//
//  QRCodeModel.swift
//  AllForB
//
//  Created by Mirzoulugbek Yusupov on 2021/03/09.
//

import UIKit

struct QRCodeModel: Decodable {
    let ReturnCode: Int?
    let ThrownException: String?
    let ExpireDateTime: String
    let ExceptionMessage: String?
    let InoutQRValue: String
}


extension APIService {
    func qrCodeCreate(userId: Int, companyId: Int, phoneNo: String, inOutTypeId: Int, completion: @escaping (QRCodeModel?, Error?) -> Void) {

        let parameters = ["UserId": userId, "CompanyId": companyId, "PhoneNo": phoneNo, "InoutTypeId": inOutTypeId] as [String : Any]
            let url = URL(string: "http://112.216.225.178:44362/api/attendance/createQR")!
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
                let rootJSON = try JSONDecoder().decode(QRCodeModel.self, from: data)
                completion(rootJSON, nil)
            }
            
            catch let error {
                print(error.localizedDescription)
                completion(nil, error)
            }
        })
            task.resume()
    }
    
    
    func qrCodeCheck(userId: Int, companyId: Int, qrCode: String, completion: @escaping ([String: Any]?, Error?) -> Void) {

        let parameters = ["UserId": userId, "CompanyId": companyId, "QRCode": qrCode] as [String : Any]
            let url = URL(string: "http://112.216.225.178:44362/api/attendance/checkQR")!
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
                guard let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any]
                    else {
                        completion(nil, NSError(domain: "invalidJSONTypeError", code: -100009, userInfo: nil))
                    return
                }
                print(json)
//                let data = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
//                let decoder = JSONDecoder()
//                let qrCodeModel = try decoder.decode(QRCodeModel.self, from: data)
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
