//
//  ViewController.swift
//  CJWUtilsS
//
//  Created by cen on 8/12/14.
//  Copyright (c) 2014 cen. All rights reserved.
//

import UIKit
import SVProgressHUD
import SugarRecord
import CoreData
import RealmSwift

class ViewController: UITableViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		self.tableView.registerClass(CJWCell.self, forCellReuseIdentifier: "CJWCell")

		log.outputLogLevel = .Debug

		realmTesting()

//		let stringObject: String = "testing"
//		let stringArrayObject: [String] = ["one", "two"]
//		let viewObject = UIView()
//		let anyObject: Any = "testing"
//
//		let stringMirror = Mirror(reflecting: stringObject)
//		let stringArrayMirror = Mirror(reflecting: stringArrayObject)
//		let viewMirror = Mirror(reflecting: viewObject)
//		let anyMirror = Mirror(reflecting: anyObject)
//
//		anyMirror.subjectType
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return 1
	}

	override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 1
	}

	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCellWithIdentifier("CJWCell") as! CJWCell
		cell.setup()
		cell.label.setNeedsUpdateConstraints()
		cell.label.updateConstraintsIfNeeded()
		return cell
	}

	override func viewDidAppear(animated: Bool) {
		super.viewDidAppear(animated)

//        QPKeyChainUtils.sharedInstance.cache("aaaa", forKey: "cjw")
//        cacheToDisk("aaaa", forKey: "cjw")
		if let value = QPKeyChainUtils.sharedInstance.cacheBy("cjw") {
			print("value \(value)")
		}
	}

	override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
	}

	override func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
		return UITableViewAutomaticDimension
	}

	override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
		return UITableViewAutomaticDimension
	}

	lazy var db: RealmDefaultStorage = {
		var configuration = Realm.Configuration()
		configuration.path = self.databasePath("realm-basic")
		let _storage = RealmDefaultStorage(configuration: configuration)
		return _storage
	}()

	func userDidSelectAdd() {
		db.operation { (context, save) -> Void in
			let _object: RealmBasicObject = try! context.new()
			_object.date = NSDate()
			_object.name = "cjw2"
			try! context.insert(_object)
			save()
			log.debug("save")
			print("save")
		}
		updateData()
	}

	// model: Entity, key: String, value: String
	func remove<T: Entity>(object: T) {

		db.operation { (context, save) -> Void in

			let john: RealmBasicObject? = try! context.request(RealmBasicObject.self).filteredWith("name", equalTo: "1234").fetch().first

			// if let john = john {
//				try! context.remove([john])
//				save()
//			} else {
//				log.error("no such model")
//			}
		}
	}

	// MARK: - Private

	private func updateData() {
		let entities = try! db.fetch(Request<RealmBasicObject>()).map(RealmBasicEntity.init)
		let entities2 = try! db.fetch(Request<RealmBasicObject>()).filter({ (obj) -> Bool in
			return true
		})
//		for entity in entities {
//			log.debug("entities \(entity.dateString)")
//			log.debug("entities \(entity.testing)")
//		}

		for entity2 in entities2 {
			log.debug("entities \(entity2.name)")
			log.debug("entities \(entity2.date)")
		}
	}

	func databasePath(name: String) -> String {
		let documentsPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true) [0] as String
		return documentsPath.stringByAppendingString("/\(name)")
	}

	var entities: [RealmBasicEntity] = [] {
		didSet {
			self.tableView.reloadData()
		}
	}
}

extension ViewController {
	func realmTesting() {

		for _ in 0...10 {
			let model = QPModel.newModel(QPModel.self)
			model.id = 1100.random()
            model.save()
		}
		QPDBUtils.sharedInstance.debug()
	}

	func rrr(type: Object.Type) {
		let realm = try! Realm()
		let ppp = realm.objects(type).filter(NSPredicate(format: "age < %d ", 300)).sorted("age", ascending: false)
		for person in ppp {
			if let ps = person as? RealmBasicObject {
				print("person \(ps.name) \(ps.age)")
			}
		}
	}
}
class CJWCell : QPBaseTableViewCell {
	let label = UILabel()
	let label2 = UILabel()

	override func setupViews(view: UIView) {
		view.addSubview(label)
		label.text = ".php?url=github.com/frankcjw/CJWOCLib/.php?url=github.com/frankcjw/CJWOCLib/.php?url=github.com/frankcjw/CJWOCLib/.php?url=github.com/frankcjw/CJWOCLib/.php?url=github.com/frankcjw/CJWOCLib/.php?url=github.com/frankcjw/CJWOCLib/.php?url=github.com/frankcjw/CJWOCLib/.php?url=github.com/frankcjw/CJWOCLib/.php?url=github.com/frankcjw/CJWOCLib/.php?url=github.com/frankcjw/CJWOCLib/"
		label.backgroundColor = UIColor.yellowColor()
		label.numberOfLines = 0

		view.addSubview(label2)
		label2.backgroundColor = UIColor.lightGrayColor()
		label2.numberOfLines = 0
		label2.text = "CJWOCLibCJWOCLibCJWOCLibCJWOCLibCJWOCLibCJWOCLibCJWOCLib"
	}

	override func setupConstrains(view: UIView) {
		label.alignTop("20", leading: "20", bottom: "<=-20", trailing: "-20", toView: view)
//		label.alignLeading("30", trailing: "-30", toView: view)
//		label.alignTopEdgeWithView(view, predicate: "30")
//		label.heightConstrain(">=200")
		label2.constrainTopSpaceToView(label, predicate: "30")

		label2.leadingAlign(view, predicate: "0")
		label2.trailing(view, predicate: "-30")
		label2.bottom(view, predicate: "-20")
	}
}

class RealmBasicObject: Object {
	dynamic var date: NSDate = NSDate()
	dynamic var name: String = ""
	dynamic var age: Int = 0
	dynamic var id: Int = 0

	override static func primaryKey() -> String? {
		return "id"
	}

	override static func indexedProperties() -> [String] {
		return ["name"]
	}
}

class RealmBasicEntity {
	let dateString: String
	let name: String
	let testing: String

	init(object: RealmBasicObject) {
		let dateFormater = NSDateFormatter()
		dateFormater.timeStyle = NSDateFormatterStyle.ShortStyle
		dateFormater.dateStyle = NSDateFormatterStyle.ShortStyle
		self.dateString = dateFormater.stringFromDate(object.date)
		self.name = object.name
		self.testing = "[]\(object.name)"
	}
}
