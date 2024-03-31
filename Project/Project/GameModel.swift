//
//  GameModel.swift
//  Project
//
//  Created by Adrian Will on 3/13/24.
//

import Foundation
import UIKit
import SwiftUI

struct bigboard: Hashable {
    var name: String
    var position: String
    var school: String
    var hlogopic: Image { // calculable property not used by hashing
           Image(name)
        }
}

struct draftteam: Hashable {
    var name: String
    var abrevname: String
    var winloss: String
    var sos: String
    var hlogopic: Image { // calculable property not used by hashing
           Image(name)
        }
}

struct singlegame: Hashable {
    var home: String
    var away: String
    var homefull: String
    var awayfull: String
    var hscore: String
    var ascore: String
    var hlogopic: Image { // calculable property not used by hashing
           Image(homefull)
        }
    var alogopic: Image { // calculable property not used by hashing
           Image(awayfull)
        }
    var time: String
}

struct favgame {
    var home: String
    var away: String
    var homefull: String
    var awayfull: String
    var hscore: String
    var ascore: String
    var hlogopic: Image { // calculable property not used by hashing
           Image(homefull)
        }
    var alogopic: Image { // calculable property not used by hashing
           Image(awayfull)
        }
    var time: String
    var hrecord: String
    var arecord: String
}
