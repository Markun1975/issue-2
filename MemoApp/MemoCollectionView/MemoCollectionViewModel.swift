//
//  MemoCollectionViewModel.swift
//  MemoApp
//
//  Created by Masaki on R 2/10/28.
//

import Foundation
import UIKit
import CoreData
import RealmSwift
import RxSwift


class MemoCollectionViewModel{
    
    func fetchMemoCollectionArray(){
        
        let realm = try! Realm()
        
        let memoCollection = realm.objects(MemoModel.self)
  }
}
    

