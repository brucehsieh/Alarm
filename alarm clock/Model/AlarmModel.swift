//
//  AddAlarmInfo.swift
//  alarm clock
//
//  Created by Bruce Hsieh on 2022/9/1.
//

import Foundation
import UserNotifications

struct AlarmModel: Codable {
    
    // store property
    var time: Date = Date()
    var annotation: String = "鬧鐘"
    var selectDays:Set<Day> = []
    var isOn: Bool = true
    
    // 計算屬性
    var timeString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: time)
    }
    
    var noteLabel: String {
        if selectDays.isEmpty {
            return annotation
        } else {
            return annotation + "," + repeatDay
        }
    }
    
    var isEdit = false
    
    var repeatDay: String {
    switch selectDays{
    case [.sat, .sun]:
        return "週末"
    case [.sun, .mon, .tues, .wed, .thur, .fri, .sat]:
        return "每日"
    case [.mon, .tues, .wed, .thur, .fri]:
        return "平日"
    case []:
        return "從不"
    default:
        let day = selectDays
            .sorted(by: {$0.rawValue < $1.rawValue})
            //排序
            .map{$0.dayText}
            //型態轉換
            .joined(separator: " ")
            //將選到的資料組合起來
        return day
        }
    }
}

enum Day: Int, CaseIterable, Codable {
    case sun = 0,mon,tues,wed,thur,fri,sat
    
    var dayString: String {
        switch self {
        case .sun:
            return "星期日"
        case .mon:
            return "星期一"
        case .tues:
            return "星期二"
        case .wed:
            return "星期三"
        case .thur:
            return "星期四"
        case .fri:
            return "星期五"
        case .sat:
            return "星期六"
        }
    }
    
    var dayText: String {
        switch self {
    case .sun:
        return "每週日"
    case .mon:
        return "每週一"
    case .tues:
        return "每週二"
    case .wed:
        return "每週三"
    case .thur:
        return "每週四"
    case .fri:
        return "每週五"
    case .sat:
        return "每週六"
        }
    }
}
