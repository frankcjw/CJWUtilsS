//
//  QPEventUtils.swift
//  CJWUtilsS
//
//  Created by Frank on 10/8/16.
//  Copyright © 2016 cen. All rights reserved.
//

import UIKit

import EventKit
import EventKitUI

public class QPEventUtils: NSObject {

	let eventStore = EKEventStore()
	var yourReminderCalendar: EKCalendar?

	public func addCalendar(title: String, note: String = "", startDate: NSDate, endDate: NSDate, calendar: EKCalendar?) -> Bool {
		let event = EKEvent(eventStore: eventStore)
		event.title = title
		event.startDate = startDate
		event.endDate = endDate

		if !note.isEmpty {
			event.notes = note
		}

		if let calendar = calendar {
			event.calendar = calendar
		} else {
			event.calendar = eventStore.defaultCalendarForNewEvents
		}
		do {
			try eventStore.saveEvent(event, span: .ThisEvent, commit: true)
			return true
		} catch {
			log.error("add event fail")
		}
		return false
	}

	public func addCalendatTitle(title: String, block: (calendar: EKCalendar) -> ()) -> EKCalendar {
		let calendars = eventStore.calendarsForEntityType(EKEntityType.Event)
		if (yourReminderCalendar == nil) {
			for calendar in calendars {
				if calendar.title == title {
					print("calendar.title \(calendar.title )")
					yourReminderCalendar = (calendar as EKCalendar)
					block(calendar: yourReminderCalendar!)
					return yourReminderCalendar!
					break
				}
			}

			if (yourReminderCalendar == nil) {
				yourReminderCalendar = EKCalendar(forEntityType: EKEntityType.Event, eventStore: eventStore)
				yourReminderCalendar!.title = title
				yourReminderCalendar!.source = eventStore.defaultCalendarForNewReminders().source

				do {
					try eventStore.saveCalendar(yourReminderCalendar!, commit: true)
					block(calendar: yourReminderCalendar!)
					return yourReminderCalendar!
				} catch {
					log.error("add calendar title fail")
					block(calendar: yourReminderCalendar!)
				}

			}
		}
		return eventStore.defaultCalendarForNewEvents
	}

	public class func verifyUserAuthorization(type: EKEntityType, success: QPNormalBlock, fail: QPNormalBlock) {
		let eventStore = EKEventStore()

		switch EKEventStore.authorizationStatusForEntityType(type) {
		case .Authorized:
			// print("Authorized")
			success()
		case .Denied:
			// print("Denied")
			fail()
		case .NotDetermined:
			eventStore.requestAccessToEntityType(.Event, completion: { (granted, error) in
				if granted {
					// print("granted")
					success()
				}
				else {
					// print("not granted")
					fail()
				}
			})
		case .Restricted:
			// print("Restricted")
			fail()
		}
	}
}