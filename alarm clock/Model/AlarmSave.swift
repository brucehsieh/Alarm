//
//  Save.swift
//  alarm clock
//
//  Created by Bruce Hsieh on 2022/9/13.
//

import Foundation

// class, structure
struct AlarmSave{
    
    private let userDefault = UserDefaults.standard
    
    private (set) var alarms: [AlarmModel] = [] {
        didSet{
            alarms.sort{ $0.time < $1.time}
            save()
        }
    }
    
    var isEdit = false
    
    init() {
        load()
    }
    
    mutating func switchOn(_ index: Int,_ tableViewCellisOn:Bool){
        alarms[index].isOn = tableViewCellisOn
    }
    
    mutating func append(_ alarmData:AlarmModel){
        alarms.append(alarmData)
    }
    
    mutating func remove(_ index:Int){
        alarms.remove(at: index)
    }
    
    mutating func edit(_ alarmData:AlarmModel,_ index:Int){
        alarms[index] = alarmData
    }
    
    private func save() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(alarms) {
            let defaults = userDefault
            defaults.set(encoded, forKey: "data")
        }
    }
    
    private mutating func load() throws {
        if let save = userDefault.object(forKey: "data") as? Data {
            let decoder = JSONDecoder()
            if let loadedData = try? decoder.decode(Array<AlarmModel>.self, from: save) {
                alarms = loadedData
            }
        }
    }
}

