//
//  EventModel.swift
//  AndelaJsonTests
//
//  Created by Chukwuebuka Nwudo on 28/07/2022.
//

import Foundation

// MARK: - EventModel
struct EventModel: Codable {
    let id: Int
    let name: String
    let events: [Event]
    let children: [EventModel]
}

// MARK: - Event
struct Event: Codable,Identifiable {
    let id: Int
    let name, venueName, city: String
    let price: Int
    let distanceFromVenue: Double
    let date: String
    let dayOfWeek, url: String?
}
