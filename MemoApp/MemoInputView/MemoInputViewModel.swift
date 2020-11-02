//
//  MemoModel.swift
//  MemoApp
//
//  Created by Masaki on R 2/10/28.
//

import Foundation
import UIKit
import RxSwift
import RealmSwift


class MemoInputViewModel {
        var titleString = String()

        func inputTitleMemo(title:String){
            self.titleString = title
        }
    
    func addMemo(title: String) {
            do {
                let realm = try Realm()
                let newMemo = MemoModel(value: ["title": title])
                try realm.write {
                    realm.add(newMemo)
                }
            } catch {
                // 例外
            }
        }
}


