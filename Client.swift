//
//  Client.swift
//  myClientBook
//
//  Created by Suneth Tissera on 12/6/21.
//
//Client Object

import Foundation

struct Client: Codable, Identifiable {
    var id = UUID().uuidString
    var firstName: String
    var lastName: String
    var emailAddress: String
    var phoneNumber: String
    var streetName: String
    var city: String
    var state: String
    var zipcode: String
    var country: String
    var birthday = Date()
}
