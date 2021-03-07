//
//  RealmModel.swift
//  homework 14
//
//  Created by Aleksandr Mayyura on 04.03.2021.
//



import Foundation
import RealmSwift

class Task: Object {

    @objc dynamic var notes = ""
    @objc dynamic var isCompleted = false
}

