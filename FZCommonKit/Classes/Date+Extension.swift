//
//  UIDate+Extension.swift
//  DXCommonServiceKit
//
//  Created by Jack on 2021/10/8.
//

import Foundation

// MARK: -  日期简单处理
extension Date {
    
    /// 时间戳
    public var dx_Timestamp: TimeInterval {
        return timeIntervalSince1970
    }
    
    /// 通过时间戳创建实例
    ///
    /// - Parameter timestamp: 时间戳
    public init(timestamp: TimeInterval) {
        self.init(timeIntervalSince1970: timestamp)
    }
    
    /// 年
    public var dx_Year: Int {
        return NSCalendar.current.component(.year, from: self)
    }
    
    /// 月
    public var dx_Month: Int {
        return NSCalendar.current.component(.month, from: self)
    }
    
    /// 日
    public var dx_Day: Int {
        return NSCalendar.current.component(.day, from: self)
    }
    
    /// 时
    public var dx_Hour: Int {
        return NSCalendar.current.component(.hour, from: self)
    }
    
    /// 分
    public var dx_Minute: Int {
        return NSCalendar.current.component(.minute, from: self)
    }
    
    /// 秒
    public var dx_Second: Int {
        return NSCalendar.current.component(.second, from: self)
    }
    
    /// 星期几，数字(1~7)
    public var dx_Weekday: Int {
        return NSCalendar.current.component(.weekday, from: self)
    }
    
    /// 星期几，中文名称（星期一、星期二...星期日）
    public var dx_WeekdayName: String {
        guard let weekdayName = Weekday(rawValue: dx_Weekday)?.description else {
            fatalError("Error: weekday:\(dx_Weekday)")
        }
        return weekdayName
    }
    
    /// 是否是今天
    public var dx_IsToday: Bool {
        return NSCalendar.current.isDateInToday(self)
    }
    
    /// 是否是昨天
    public var dx_IsYesterday: Bool {
        return NSCalendar.current.isDateInYesterday(self)
    }
    
}

// MARK: -  格式化
extension Date {
    
    /// 时间格式化成字符串
    ///
    /// - Parameter dateFormat: 格式
    /// - Returns: 时间字符串
    public func dx_String(with dateFormat: String = "yyyy-MM-dd HH:mm:ss") -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        return formatter.string(from: self)
    }
    
    /// 通过字符串创建实例
    ///
    /// - Parameters:
    ///   - string: 字符串
    ///   - dateFormat: 格式
    public init?(string: String, dateFormat: String = "yyyy-MM-dd HH:mm:ss") {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        guard let date = formatter.date(from: string) else { return nil }
        self = date
    }
    
    /// 类似微信聊天消息的时间格式化，静态方法
    ///
    /// - Parameters:
    ///   - timestamp: 时间戳
    ///   - showHour: 是否显示时分
    /// - Returns: 格式化后的字符串
    public static func dx_StringWithFormat(timestamp: TimeInterval, showHour: Bool = true) -> String {
        let date = Date(timestamp: timestamp)
        return date.dx_StringWithFormat(showHour: showHour)
    }
    
    /// 类似微信聊天消息的时间格式化，实例
    ///
    /// - Parameter showHour: 是否显示时分
    /// - Returns: 格式化后的字符串
    public func dx_StringWithFormat(showHour: Bool = true) -> String {
        let dateFormatter = DateFormatter()
        if dx_IsToday {
            /// 如果是今天
            dateFormatter.dateFormat = "HH:mm"
        } else if dx_IsYesterday {
            /// 如果是昨天
            dateFormatter.dateFormat = showHour ? "昨天 HH:mm" : "昨天"
        } else if dx_numberOfdays(to: Date()) < 7 {
            /// 如果在一周内
            dateFormatter.dateFormat = showHour ? "\(dx_WeekdayName) HH:mm" : "\(dx_WeekdayName)"
        } else {
            /// 如果是今年
            if dx_Year == Date().dx_Year {
                dateFormatter.dateFormat = showHour ? "MM月dd日 HH:mm" : "MM月dd日"
            } else {
                dateFormatter.dateFormat = showHour ? "yyyy年MM月dd日 HH:mm" : "yyyy年MM月dd日"
            }
        }
        return dateFormatter.string(from: self)
    }
    
    
    /// 获取两个日期之间相隔的天数，self为起始日期，date为截止日期
    ///
    /// - Parameter date: 截止日期
    /// - Returns: 相隔天数
    public func dx_numberOfdays(to date: Date) -> Int {
        let components = Calendar.current.dateComponents([.day], from: self, to: date)
        return components.day ?? 0
    }
    
}

// MARK: -  Weekday简单封装
public enum Weekday: Int {
    
    case sunday    = 1
    case monday    = 2
    case tuesday   = 3
    case wednesday = 4
    case thursday  = 5
    case friday    = 6
    case saturday  = 7
    
    init?(weekdayString: String) {
        switch weekdayString {
        case Weekday.sunday.description:     self = .sunday
        case Weekday.monday.description:     self = .monday
        case Weekday.tuesday.description:    self = .tuesday
        case Weekday.wednesday.description:  self = .wednesday
        case Weekday.thursday.description:   self = .thursday
        case Weekday.friday.description:     self = .friday
        case Weekday.saturday.description:   self = .saturday
        default: return nil
        }
    }
    
    var description: String {
        switch self {
        case .sunday:     return "星期日"
        case .monday:     return "星期一"
        case .tuesday:    return "星期二"
        case .wednesday:  return "星期三"
        case .thursday:   return "星期四"
        case .friday:     return "星期五"
        case .saturday:   return "星期六"
        }
    }
    
}
