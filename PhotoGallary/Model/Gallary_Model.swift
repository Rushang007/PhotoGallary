//
//  Gallary_Model.swift
//  PhotoGallary
//
//  Created by Rushang Patel (iOS Developer) on 24/08/21.
//

import Foundation

struct ResponseData:Codable {
    var Status:Bool? = nil
    var Message:String? = nil
    var Data:[Gallary] = []
}
struct Gallary :Codable
{
    var id:String
    var download_url:String
    var url:String
    var author:String
}
