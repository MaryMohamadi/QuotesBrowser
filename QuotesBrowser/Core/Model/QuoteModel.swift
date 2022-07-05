//
//  QuotModel.swift
//  QuotesBrowser
//
//  Created by Maryam Alimohammadi on 18.06.22.
//

import Foundation
import SwiftUI
import UIKit

struct QuoteModel: Codable, Equatable {
    var tags: [String]
    var dialogue: Bool
    var body: String
    var id: Int
    var author: String
    var url: String?
    var color: String = ""
    
    
    init(tags: [String], dialogue: Bool, body: String, id: Int, author: String, url: String? = nil, color: String) {
        self.tags = tags
        self.dialogue = dialogue
        self.body = body
        self.id = id
        self.author = author
        self.url = url
        self.color = color
    }
     
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.tags = try container.decode([String].self, forKey: .tags)
        self.dialogue = try container.decode(Bool.self, forKey: .dialogue)
        self.body = try container.decode(String.self, forKey: .body)
        self.id = try container.decode(Int.self, forKey: .id)
        self.author = try container.decode(String.self, forKey: .author)
        self.url = try container.decodeIfPresent(String.self, forKey: .url)
        self.color = generateRandomColor()

    }

    func generateRandomColor() -> String {
        let redValue = CGFloat.random(in: 0.2...1)
        let greenValue = CGFloat.random(in: 0.2...1)
        let blueValue = CGFloat.random(in: 0.2...1)
        
        let randomColor = Color(UIColor(red: redValue, green: greenValue, blue: blueValue, alpha: 1.0))
        
        return randomColor.toHex() ?? "#C7FFC7"
    }
    
#if DEBUG
    static let addData = QuoteModel(tags: ["aaa", "bbbb"],
                                     dialogue: false,
                                     body: "“The Lord gave us two ends - one to sit on and the other to think with. Success depends on which one we use the most.”",
                                     id: 1,
                                     author: "Omar Khayyam",
                                     url: nil,
                                     color: "#C7FFC7")
#endif

}

