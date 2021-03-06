//
//  EventManager.swift
//  BoutTime
//
//  Created by Kristopher Wood on 7/12/18.
//  Copyright © 2018 Kristopher Wood. All rights reserved.
//

import GameKit

protocol Sortable {
    func sort() -> [Event]
}

class EventManager: Resetable {
    let eventList: [Event]
    var roundSet: [EventSet] = []
    
    init() {
        do {
            let plistEventList = try PListConvertor.array(fromFile: "Albums", ofType: "plist")
            eventList = try EventListBuilder.eventList(fromArray: plistEventList)
        } catch let error as ReaderError {
            fatalError("Failed to Load Albums, \(error.rawValue)")
        } catch {
            fatalError("Unknown error, \(error.localizedDescription)")
        }
    }
    
    func doesMatchFor(array: [Event], round: Int) -> Bool {
        let eventArray = getEventSetFor(round: round).sort()
        
        for index in 0..<eventArray.count {
            if eventArray[index] != array [index] {
                return false
            }
        }
        
        return true
    }
    
    func getEventSetFor(round: Int) -> EventSet {
        return roundSet[round - 1]
    }
    
    // Generate New Random Album List
    func newGame() {
        var toSort = eventList
        var createdEventSet: [Event] = []
        
        while !toSort.isEmpty {
            if createdEventSet.count == 4 {
                roundSet.append(EventSet(eventSet: createdEventSet))
                createdEventSet = []
            }
            
            let selectedIndex = GKRandomSource.sharedRandom().nextInt(upperBound: toSort.count)
            createdEventSet.append(toSort[selectedIndex])
            toSort.remove(at: selectedIndex)
        }
    }
}

struct EventSet: Sortable {
    let eventSet: [Event]
    
    func sort() -> [Event] {
        var unsortedList = eventSet
        var sortedList: [Event] = []
        
        var earliestIndex: Int = -1
        while unsortedList.count != 0 {
            for index in 0..<unsortedList.count {
                if earliestIndex == -1 {
                    earliestIndex = index
                } else {
                    if unsortedList[index].eventYear < unsortedList[earliestIndex].eventYear {
                        earliestIndex = index
                    }
                }
            }
            
            sortedList.append(unsortedList[earliestIndex])
            unsortedList.remove(at: earliestIndex)
            earliestIndex = -1
        }
        
        return sortedList
    }
}
