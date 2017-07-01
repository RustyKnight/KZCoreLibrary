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
	public func stringFromDate() -> String {
		return stringFromDate(withFormat: "dd/MM/yyyy")
	}
	
	public func stringFromDate(withFormat format: String) -> String {
		let formatter = DateFormatter()
		formatter.dateFormat = format
		return formatter.string(from: self)
	}

	/** 
	 * Convinence method to subtract a given value from date component
	 */
	public func subtrac(_ amount: Int, forComponent unit: Calendar.Unit) -> Date? {
		return add(amount * -1, forComponent: unit)
	}
	
	/**
	 * Method to add a given value from date component
	 */
	public func add(_ amount: Int, forComponent unit: Calendar.Unit) -> Date? {
		let calendar = Calendar.current
		let dateComponents: DateComponents = DateComponents()
		(dateComponents as NSDateComponents).setValue(amount, forComponent: unit)
		return calendar.date(
			byAdding: dateComponents,
			to: self,
			options: Calendar.Options(rawValue: 0))
	}
	
	/**
	 * Convinence method to subtract a number of months from a date
	 */
	public func subtract(months: Int) -> Date? {
		return add(months: months * -1)
	}
	
	/**
	 * Convinence method to add a number of months from a date
	 */
	public func add(months: Int) -> Date? {
		return add(months, forComponent: Calendar.Unit.month)
	}

	/**
	 * Convinence method to add a number of days from a date
	 */
	public func add(days: Int) -> Date? {
		return add(days, forComponent: Calendar.Unit.day)
	}
	
	/**
	 * Convinence method to subtract a number of days from a date
	 */
	public func subtract(days: Int) -> Date? {
		return add(days: days * -1)
	}
	
	/**
	* Convinence method to add a number of years from a date
	*/
	public func add(years: Int) -> Date? {
		return add(years, forComponent: Calendar.Unit.year)
	}
	
	/**
	* Convinence method to subtract a number of years from a date
	*/
	public func subtract(years: Int) -> Date? {
		return add(years: years * -1)
	}
	
	public func with(hour: Int, minute min: Int, seconds: Int, nanoSeconds nanos: Int) -> Date? {
		let calendar = Calendar.current
		var dateComponents: DateComponents = DateComponents()
		
		dateComponents.hour = hour
		dateComponents.minute = min
		dateComponents.second = seconds
		dateComponents.nanosecond = nanos
		
		return calendar.date(
			byAdding: dateComponents,
			to: self,
			options: Calendar.Options(rawValue: 0))
	}
	
	public func timeAtEndOfDay() -> Date? {
		return with(hour: 23, minute: 59, seconds: 59, nanoSeconds: 0)
	}
	
	public func timeAtStartOfDay() -> Date? {
		return with(hour: 0, minute: 0, seconds: 0, nanoSeconds: 1)
	}
	
	public func isAfter(_ dateToCompare: Date) -> Bool {
		//Declare Variables
		var isAfter = false
		
		//Compare Values
		if self.compare(dateToCompare) == ComparisonResult.orderedDescending {
			isAfter = true
		}
		
		//Return Result
		return isAfter
	}
	
	public func isBefore(_ dateToCompare: Date) -> Bool {
		//Declare Variables
		var isBefore = false
		
		//Compare Values
		if self.compare(dateToCompare) == ComparisonResult.orderedAscending {
			isBefore = true
		}
		
		//Return Result
		return isBefore
	}
	
	public func isEqualTo(_ dateToCompare: Date) -> Bool {
		//Declare Variables
		var isEqualTo = false
		
		//Compare Values
		if self.compare(dateToCompare) == ComparisonResult.orderedSame {
			isEqualTo = true
		}
		
		//Return Result
		return isEqualTo
	}
	
	public func excludingTimeIsBetween(startDate: Date, and endDate: Date) -> Bool {
		
		var isBetween = false
		if let startDate = startDate.timeAtStartOfDay() {
			if let endDate = endDate.timeAtEndOfDay() {
				
				if self.isAfter(startDate) && self.isBefore(endDate) {
					isBetween = true
				}
				
			}
		}
		
		return isBetween
		
	}

	public func excludingTimeIsBetweenOrEqual(to startDate: Date, and endDate: Date) -> Bool {
		
		var isBetweenOrEqualTo = false
		if let startDate = startDate.subtract(days: 1) {
			if let endDate = endDate.add(days: 1) {

				isBetweenOrEqualTo = excludingTimeIsBetween(startDate: startDate, and: endDate)
				
			}
		}
		
		return isBetweenOrEqualTo
		
	}
	
	public static func daysBetween(_ fromDate: Date, and toDate: Date) -> Int? {
		let calendar = Calendar.current
		var startDate: NSDate? = nil
		var endDate: NSDate? = nil
		calendar.range(of: Calendar.Unit.day, start: &startDate, interval: nil, for: fromDate)
		calendar.range(of: Calendar.Unit.day, start: &endDate, interval: nil, for: toDate)
		
		var days: Int? = nil
		
		guard let from = startDate as Date? else {
			return days
		}
		guard let to = endDate as Date? else {
			return days
		}
		
		let difference = calendar.components(
			Calendar.Unit.day,
			from: from,
			to: to,
			options: Calendar.Options(rawValue: 0))
		
		days = difference.day
		
		return days
	}
	
	public static func today(withSecondsSinceMidnight seconds: Int) -> Date? {
		if let today = Date().timeAtStartOfDay() {
			return today.addingTimeInterval(TimeInterval(seconds))
		}
		return nil
	}
	
	public func dayOfWeek() -> Int {
		return Date.dayOfWeekFor(self)
	}
	
	public func dayOfWeek(startinfFrom from: Int) -> Int {
		return Date.dayOfWeekFor(self, startingFrom: from)
	}
	
	public static func dayOfWeekFor(_ date: Date) -> Int {
		return Date.dayOfWeekFor(date, startingFrom: 1)
	}
	
	public static func dayOfWeekFor(_ date: Date, startingFrom: Int) -> Int {
		
		let calendar = Calendar.current()
		calendar.firstWeekday = startingFrom
		let dow = calendar.ordinality(of: Calendar.Unit.weekday, in: Calendar.Unit.weekOfMonth, for: date)
		
		return dow
		
	}
}
