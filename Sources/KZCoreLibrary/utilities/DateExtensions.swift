//
//  DateUtilities.swift
//  KZCoreLibrary
//
//  Created by Shane Whitehead on 25/03/2016.
//  Copyright © 2016 KaiZen. All rights reserved.
//

import Foundation

public extension Date {
    /**
     This is itended mostly for simplicty when trying to dump the
     date value and one should use the stringFromDate(NSDate: withFormat:)
     method instead
     */
    func stringFromDate() -> String {
        return stringFromDate(withFormat: "dd/MM/yyyy")
    }
    
    func stringFromDate(withFormat format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
    
    /**
     * Convinence method to subtract a given value from date component
     */
    func subtrac(_ amount: Int, forComponent unit: Calendar.Component) -> Date? {
        return add(amount * -1, forComponent: unit)
    }
    
    /**
     * Method to add a given value from date component
     */
    func add(_ amount: Int, forComponent unit: Calendar.Component) -> Date? {
        let calendar = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.setValue(amount, for: unit)
        return calendar.date(
            byAdding: dateComponents,
            to: self
        )
    }
    
    /**
     * Convinence method to subtract a number of months from a date
     */
    func subtract(months: Int) -> Date? {
        return add(months: months * -1)
    }
    
    /**
     * Convinence method to add a number of months from a date
     */
    func add(months: Int) -> Date? {
        return add(months, forComponent: .month)
    }
    
    /**
     * Convinence method to add a number of days from a date
     */
    func add(days: Int) -> Date? {
        return add(days, forComponent: .day)
    }
    
    /**
     * Convinence method to subtract a number of days from a date
     */
    func subtract(days: Int) -> Date? {
        return add(days: days * -1)
    }
    
    /**
     * Convinence method to add a number of years from a date
     */
    func add(years: Int) -> Date? {
        return add(years, forComponent: .year)
    }
    
    /**
     * Convinence method to subtract a number of years from a date
     */
    func subtract(years: Int) -> Date? {
        return add(years: years * -1)
    }
    
    func with(hour: Int, minute min: Int, seconds: Int, nanoSeconds nanos: Int) -> Date? {
        let calendar = Calendar.current
        var dateComponents: DateComponents = DateComponents()
        
        dateComponents.hour = hour
        dateComponents.minute = min
        dateComponents.second = seconds
        dateComponents.nanosecond = nanos
        
        return calendar.date(
            byAdding: dateComponents,
            to: self
        )
    }
    
    func timeAtEndOfDay() -> Date? {
        return with(hour: 23, minute: 59, seconds: 59, nanoSeconds: 0)
    }
    
    func timeAtStartOfDay() -> Date? {
        return with(hour: 0, minute: 0, seconds: 0, nanoSeconds: 1)
    }
    
    func isAfter(_ dateToCompare: Date) -> Bool {
        //Declare Variables
        var isAfter = false
        
        //Compare Values
        if self.compare(dateToCompare) == ComparisonResult.orderedDescending {
            isAfter = true
        }
        
        //Return Result
        return isAfter
    }
    
    func isBefore(_ dateToCompare: Date) -> Bool {
        //Declare Variables
        var isBefore = false
        
        //Compare Values
        if self.compare(dateToCompare) == ComparisonResult.orderedAscending {
            isBefore = true
        }
        
        //Return Result
        return isBefore
    }
    
    func isEqualTo(_ dateToCompare: Date) -> Bool {
        //Declare Variables
        var isEqualTo = false
        
        //Compare Values
        if self.compare(dateToCompare) == ComparisonResult.orderedSame {
            isEqualTo = true
        }
        
        //Return Result
        return isEqualTo
    }
    
    func excludingTimeIsBetween(startDate: Date, and endDate: Date) -> Bool {
        guard let startDate = startDate.timeAtStartOfDay() else { return false }
        guard let endDate = endDate.timeAtEndOfDay() else { return false }
        guard self.isAfter(startDate) && self.isBefore(endDate) else { return false }
        return true
    }
    
    func excludingTimeIsBetweenOrEqual(to startDate: Date, and endDate: Date) -> Bool {
        guard let startDate = startDate.subtract(days: 1) else { return false }
        guard let endDate = endDate.add(days: 1) else { return false }
        return excludingTimeIsBetween(startDate: startDate, and: endDate)
    }
    
    static func daysBetween(_ fromDate: Date, and toDate: Date) -> Int? {
        let calendar = Calendar.current
        
        return calendar.dateComponents([.day], from: fromDate, to: toDate).day!
    }
    
    static func today(withSecondsSinceMidnight seconds: Int) -> Date? {
        if let today = Date().timeAtStartOfDay() {
            return today.addingTimeInterval(TimeInterval(seconds))
        }
        return nil
    }
    
    func dayOfWeek() -> Int {
        return Date.dayOfWeekFor(self)
    }
    
    func dayOfWeek(startinfFrom from: Int) -> Int {
        return Date.dayOfWeekFor(self, startingFrom: from)
    }
    
    static func dayOfWeekFor(_ date: Date) -> Int {
        return Date.dayOfWeekFor(date, startingFrom: 1)
    }
    
    static func dayOfWeekFor(_ date: Date, startingFrom: Int) -> Int {
        var calendar = Calendar.current
        calendar.firstWeekday = startingFrom
        return calendar.ordinality(of: .weekday, in: .weekOfMonth, for: date)!
    }
}
