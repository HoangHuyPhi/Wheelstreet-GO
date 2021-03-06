//
//  GoBikes.swift
//  Wheelstreet
//
//  Created by JOGENDRA on 07/12/17.
//  Copyright © 2017 Kush Taneja. All rights reserved.
//

import Foundation

class GoBike {
    var goBikeId: Int
    var regNo: String
    var location: GOLocation?
    var bikeModelName: String
    var bikeMakeName: String
    var bikeModelImageUrl: String
    var fareDetail: GoFareDetails?
    
    init(goBikeId: Int, regNo: String, location: GOLocation?, bikeModelName: String, bikeMakeName: String,  bikeModelImageUrl: String, fareDetail: GoFareDetails?) {
        self.goBikeId = goBikeId
        self.regNo = regNo
        self.location = location
        self.bikeModelName = bikeModelName
        self.bikeMakeName = bikeMakeName
        self.bikeModelImageUrl = bikeModelImageUrl
        self.fareDetail = fareDetail
    }


    convenience init(data: JSON) {
        guard let goBikeId = data[GoKeys.goBikeIdKey].hardInt, let regNo = data[GoKeys.bikeRegNoKey].string, let bikeModelName = data[GoKeys.bikeModelNameKey].string, let bikeModelImageUrl = data[GoKeys.bikeImageURLKey].string else {
            fatalError("Bike ID not found to intiialise bike")
        }

        let bikeMakeName = data[GoKeys.bikeMakeNameKey].string ?? ""

        self.init(goBikeId: goBikeId, regNo: regNo, location: GOLocation(locationData: data), bikeModelName: bikeModelName, bikeMakeName: bikeMakeName, bikeModelImageUrl: bikeModelImageUrl, fareDetail: GoFareDetails(baseRate: data["baseRate"].hardInt ?? 0, kmRate: data["kmRate"].hardInt ?? 0, minRate: data["minuteRate"].hardInt ?? 0))
    }
}

extension JSON {
  public var hardInt: Int? {
    get {
      switch self.type {
      case .string:
        let stringObject = self.object as? String
        return stringObject?.toInt()
      case .number:
        return self.object as? Int
      default:
        return nil
      }
    }
  }
}
