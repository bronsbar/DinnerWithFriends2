//
//  dinnerModel.swift
//  DinnerWithFriends
//
//  Created by Bart Bronselaer on 7/11/17.
//  Copyright © 2017 Bart Bronselaer. All rights reserved.
//

import UIKit

class DinnerModel: Codable {
    
    var dinnerPicture : UIImage?
    var dinnerName : String
    var dinnerDescription : String
    var dinnerDate : String
    var dinnerFriends : [String]
    var dinnerRating : Int?
    var dinnerUrl : String?
    var dinnerNotes : String?
    
    init(dinnerPicture : UIImage?, dinnerName: String, dinnerDescription:String, dinnerDate: String, dinnerFriends : [String], dinnerRating: Int?, dinnerUrl: String?, dinnerNotes: String?) {
        self.dinnerPicture = dinnerPicture
        self.dinnerName = dinnerName
        self.dinnerDescription = dinnerDescription
        self.dinnerDate = dinnerDate
        self.dinnerFriends = dinnerFriends
        self.dinnerRating = dinnerRating
        self.dinnerUrl = dinnerUrl
        self.dinnerNotes = dinnerNotes
    }
    // Mark: Make object encodable to save to disk
    enum CodingKeys: String, CodingKey {
        case dinnerPicture = "dinnerPicture"
        case dinnerName = "dinnerName"
        case dinnerDescription = "dinnerDescription"
        case dinnerDate = "dinnerdate"
        case dinnerFriends = "dinnerFriends"
        case dinnerRating = "dinnerRating"
        case dinnerUrl = "dinnerUrl"
        case dinnerNotes = "dinnerNotes"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let dinnerPictureData = try values.decode(Data.self, forKey: .dinnerPicture)
        if let dinnerPicture = UIImage(data: dinnerPictureData) {
            self.dinnerPicture = dinnerPicture
        } else {
            self.dinnerPicture = nil
            
        }
        
        dinnerName = try values.decode(String.self, forKey: .dinnerName)
        dinnerDescription = try values.decode(String.self, forKey: .dinnerDescription)
        dinnerDate = try values.decode(String.self, forKey: .dinnerDate)
        dinnerFriends = try values.decode([String].self, forKey: .dinnerFriends)
        dinnerRating = try values.decode(Int?.self, forKey: .dinnerRating)
        dinnerUrl = try values.decode(String?.self, forKey: .dinnerUrl)
        dinnerNotes = try values.decode(String?.self, forKey: .dinnerNotes)
        
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        let dinnerPictureData = convertUIImageinJpeg(dinnerPicture!)
        
        try container.encode(dinnerPictureData, forKey: .dinnerPicture)
        try container.encode(dinnerName, forKey: .dinnerName)
        try container.encode(dinnerDescription, forKey: .dinnerDescription)
        try container.encode(dinnerDate, forKey: .dinnerDate)
        try container.encode(dinnerFriends, forKey: .dinnerFriends)
        try container.encode(dinnerRating, forKey: .dinnerRating)
        try container.encode(dinnerUrl, forKey: .dinnerUrl)
        try container.encode(dinnerNotes, forKey: .dinnerNotes)
    }
    
    static let DocumentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("dinnerwithfriends").appendingPathExtension("json")
    
    static func loadDinners() -> [DinnerModel]? {
        guard let codedDinners = try? Data(contentsOf: ArchiveURL) else {return nil}
        let jsonDecoder = JSONDecoder()
        return try? jsonDecoder.decode(Array<DinnerModel>.self, from: codedDinners)
    }
    static func saveDinners(_ dinners: [DinnerModel]) {
        let jsonEncoder = JSONEncoder()
        let codedDinners = try? jsonEncoder.encode(dinners)
        try? codedDinners?.write(to: ArchiveURL, options: .noFileProtection)
        
        
    }
    func convertUIImageinJpeg(_ image:UIImage) -> Data {
        
        return UIImageJPEGRepresentation(image, 0.8)!
    }
}

