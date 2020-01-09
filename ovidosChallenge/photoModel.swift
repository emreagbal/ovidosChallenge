//
//  postModel.swift
//  ovidosChallenge
//
//  Created by Emre Ağbal on 8.01.2020.
//  Copyright © 2020 Emre Ağbal. All rights reserved.
//

import UIKit

struct photoModel: Identifiable, Decodable {
    let albumId      : Int
    let id           : Int
    let title        : String
    let url          : String
    let thumbnailUrl : String
}
