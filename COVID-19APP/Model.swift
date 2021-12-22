//
//  Model.swift
//  COVID-19APP
//
//  Created by Motoki Onayama on 2021/12/17.
//

import Foundation

struct Country: Decodable {
    
    var country: String
    var date: String
    var latitude: Double
    var longitude: Double
    var provinces: [Provinces]
    
    struct Provinces: Decodable {
        var active: Int?
        var confirmed: Int?
        var deaths: Int?
        var province: String?
        var recovered: Int?
        
        private enum CodingKeys: String, CodingKey {
            case active = "active"
            case confirmed = "confirmed"
            case deaths = "deaths"
            case province = "province"
            case recovered = "recovered"
        }
    }
    
    private enum CodingKeys: String, CodingKey {
        case country = "country"
        case date = "date"
        case latitude = "latitude"
        case longitude = "longitude"
        case provinces = "provinces"
    }
}
