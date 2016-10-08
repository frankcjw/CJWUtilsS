//
//  QPEventUtils.swift
//  CJWUtilsS
//
//  Created by Frank on 10/8/16.
//  Copyright © 2016 cen. All rights reserved.
//

import UIKit
//import

import EventKit
import EventKitUI

class QPEventUtils: NSObject {

	let eventStore = EKEventStore()
	var yourReminderCalendar: EKCalendar?

	func addCalendar(title: String, startDate: NSDate, endDate: NSDate, calendar: EKCalendar?) {
		let event = EKEvent(eventStore: eventStore)
		event.title = title
		event.startDate = startDate
		event.endDate = endDate

		if let calendar = calendar {
			event.calendar = calendar
		} else {
			event.calendar = eventStore.defaultCalendarForNewEvents
		}

		do {
			try eventStore.saveEvent(event, span: .ThisEvent, commit: true)
		} catch {
			log.error("add event fail")
		}
	}

	func addCalendatTitle(title: String, block: (calendar: EKCalendar) -> ()) {
		let calendars = eventStore.calendarsForEntityType(EKEntityType.Event)
		if (yourReminderCalendar == nil) {
			for calendar in calendars {
				if calendar.title == title {
					print("calendar.title \(calendar.title )")
					yourReminderCalendar = (calendar as EKCalendar)
					block(calendar: yourReminderCalendar!)
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
				} catch {
					log.error("add calendar title fail")
					block(calendar: yourReminderCalendar!)
				}

			}
		}
	}

	class func verifyUserAuthorization(type: EKEntityType, success: QPNormalBlock, fail: QPNormalBlock) {
		let eventStore = EKEventStore()

		switch EKEventStore.authorizationStatusForEntityType(type) {
		case .Authorized:
//			print("Authorized")
			success()
		case .Denied:
//			print("Denied")
			fail()
		case .NotDetermined:
			eventStore.requestAccessToEntityType(.Event, completion: { (granted, error) in
				if granted {
//					print("granted")
					success()
				}
				else {
//					print("not granted")
					fail()
				}
			})
		case .Restricted:
//			print("Restricted")
			fail()
		}
	}
}