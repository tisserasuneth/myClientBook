//
//  Appointment.swift
//  myClientBook
//
//  Created on 12/9/21.
//
//Appointment Object for creating new Appointments
import Foundation

struct Appointment: Codable, Hashable, Identifiable {
    let id: Int
    let text: String
    var date: String
    var timeStamp = Date()
}
