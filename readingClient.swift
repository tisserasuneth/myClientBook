//
//  readingClient.swift
//  myClientBook
//
//  Created by Suneth Tissera on 12/8/21.

//Variation of Client object with extra Identifier for ease of use
import Foundation

struct readingClient: Codable, Identifiable {
    var id = UUID().uuidString
    var identifier: String
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

