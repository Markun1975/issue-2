//
//  MemoModel.swift
//  MemoApp
//
//  Created by Masaki on R 2/10/28.
//

import Foundation
import RealmSwift

    
    class MemoModel: Object {
        @objc dynamic var title: String = String()
        @objc dynamic var id: String = NSUUID().uuidString
        /// 作成日時
        @objc dynamic var createDate: Date = Date()
        /// IDをプライマリキーに設定
        override static func primaryKey() -> String? {
        return "id"
    }
}
