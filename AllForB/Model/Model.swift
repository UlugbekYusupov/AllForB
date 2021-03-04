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
