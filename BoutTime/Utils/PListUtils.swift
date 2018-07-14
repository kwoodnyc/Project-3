//
//  PListUtils.swift
//  BoutTime
//
//  Created by Kristopher Wood on 7/12/18.
//  Copyright © 2018 Kristopher Wood. All rights reserved.
//

import Foundation

/* Handling Errors

 - invalidResource: file does not exist
 - conversionFailure: file does not have correct syntax
 
 */

enum ReaderError: String, Error {
    case invalidResource = "Invalid Resource"
    case conversionFailure = "Conversion Failure"
}


class PListConvertor {
    static func array(fromFile name: String, ofType type: String) throws -> [[String: AnyObject]] {
        guard let path = Bundle.main.path(forResource: name, ofType: type) else {
            throw ReaderError.invalidResource
        }
        
        guard let array = NSArray(contentsOfFile: path) as? [[String: AnyObject]] else {
            throw ReaderError.conversionFailure
        }
        
        return array
    }
}

class EventListBuilder {
    static func eventList(fromArray array: [[String: AnyObject]]) throws -> [Event] {
        var events: [Event] = []
        
        for event in array {
            if let eventName = event["event"] as? String, let eventYear = event["year"] as? Int, let eventUrl = event["url"] as? String {
                let createdEvent = Event(eventDescription: eventName, eventYear: eventYear, eventURL: eventUrl)
                events.append(createdEvent)
            }
        }
        
        return events
    }
}
