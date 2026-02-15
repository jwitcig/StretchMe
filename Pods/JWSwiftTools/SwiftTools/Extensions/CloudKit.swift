//
//  CloudKit.swift
//  SwiftTools
//
//  Created by Developer on 3/8/16.
//  Copyright © 2016 JwitApps. All rights reserved.
//

import CloudKit

public extension CKQuery {
    convenience init(recordType: String) {
        self.init(recordType: recordType, predicate: NSPredicate.all)
    }
}

public extension CKRecord {
    func propertyForName<T>(_ name: String, defaultValue: T) -> T {
        return value(forKey: name) as? T ?? defaultValue
    }

    func referenceForName(_ name: String) -> CKRecord.Reference? {
        return self[name] as? CKRecord.Reference
    }

    func referencesForName(_ name: String) -> Set<CKRecord.Reference> {
        return (self[name] as? [CKRecord.Reference] ?? []).set
    }
}

public extension Collection where Iterator.Element: CKRecord {
    var recordIDs: [CKRecord.ID] { return map { $0.recordID } }
}

public extension Collection where Iterator.Element: CKRecord.ID {
    var recordNames: [String] {
        return map { $0.recordName }
    }
    var references: [CKRecord.Reference] {
        return map { CKRecord.Reference(recordID: $0, action: .none) }
    }
}

public extension Collection where Iterator.Element: CKRecord.Reference {
    var recordIDs: [CKRecord.ID] { return map { $0.recordID } }
}

public extension Collection where Iterator.Element: CKNotification {
    var IDs: [CKNotification.ID] {
        return filter { $0.notificationID != nil }.map { $0.notificationID! }
    }
}
