//
//  Event.swift
//  BoutTime
//
//  Created by Kristopher Wood on 7/12/2018.
//  Copyright © 2018 Kristopher Wood. All rights reserved.
//

protocol Events {
    var eventDescription: String { get }
    var eventYear: Int { get }
    var eventURL: String { get }
}

struct Event: Events, Equatable {
    let eventDescription: String
    let eventYear: Int
    let eventURL: String
    
    static func ==(lhs: Event, rhs: Event) -> Bool {
        return lhs.eventDescription == rhs.eventDescription && lhs.eventYear == rhs.eventYear
    }
}
