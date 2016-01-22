//
//  QPDBUtils.swift
//  CJWUtilsS
//
//  Created by Frank on 1/22/16.
//  Copyright © 2016 cen. All rights reserved.
//

import UIKit
import RealmSwift

public class QPDBUtils: NSObject {

	public let realm = try! Realm()

	public class var sharedInstance : QPDBUtils {
		struct Static {
			static var onceToken : dispatch_once_t = 0
			static var instance : QPDBUtils? = nil
		}
		dispatch_once(&Static.onceToken) {
			Static.instance = QPDBUtils()
		}
		return Static.instance!
	}

	public func addModel(model: QPModel) {
		if model.id == -1 {
			log.warning("model id is -1, not a valid model")
			return
		}
		try! realm.write() {
			realm.add(model, update: true)
		}
	}

	public func removeModel(modelType: QPModel.Type, predicate: NSPredicate) {
		try! realm.write {
			let result = query(modelType).filter(predicate)
			print("rec \(result.count)")
			realm.delete(result)
		}
	}

	public func query(modelType: QPModel.Type) -> Results<QPModel> {
		let result = realm.objects(modelType).filter("id > %d", -1)
		return result
	}

	public func lastId(modelType: QPModel.Type) -> Int {
		let result = query(modelType).last
		if let lastResult = result {
			return lastResult.id
		} else {
			return 0
		}
	}

	func debug() {
		log.info("db path : \(realm.path)")
	}
}

/// default model
public class QPModel : Object {

	public dynamic var id: Int = -1

	override public static func primaryKey() -> String? {
		return "id"
	}

	override public static func indexedProperties() -> [String] {
		return ["name"]
	}
}