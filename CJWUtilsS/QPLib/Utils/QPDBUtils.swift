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

	public func query<T: QPModel>(modelType: T.Type) -> Results<T> {
		let result = realm.objects(modelType).filter("id > %d", -1)
		return result
	}

	public func lastId(modelType: QPModel.Type) -> Int {
		let result = query(modelType).sorted("id", ascending: true).last
		if let lastResult = result {
			return lastResult.id + 1
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
	public dynamic var name : String = ""

	override public static func primaryKey() -> String? {
		return "id"
	}

	override public static func indexedProperties() -> [String] {
		return ["name"]
	}
}

extension QPModel {
	class func newModel<T: QPModel>(modelType: T.Type) -> T {
		let instance = T()
		instance.id = QPDBUtils.sharedInstance.lastId(modelType)
		return instance
	}

	func save() {
		QPDBUtils.sharedInstance.addModel(self)
	}
}
