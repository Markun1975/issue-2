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


class MemoTableViewModel{
    
    var myMemoArray = [String]()
    
    let realm = try! Realm()
    
    func fetchMemoTableArray(){
        myMemoArray.removeAll()
        let memoArray = realm.objects(MemoModel.self)
        print("メモモデル全体",memoArray)
        
        if memoArray.count != 0 {
        let memosCount = memoArray.count
            for n in 0 ... memosCount - 1 {
                myMemoArray.append(memoArray[n].title) //メモ要素に入れていく
                }
        }else{
            myMemoArray.append("メモはありません")
        }
        UserDefaults.standard.set(myMemoArray, forKey: "memoArray")
        }
    
    func removeMemoTableArray(memoNumber: Int){
           // 削除処理
        do {
            let memoArray = realm.objects(MemoModel.self)
            let memoNumberInt:Int = memoNumber
                try realm.write {
                    realm.delete(memoArray[memoNumberInt])
                }
            } catch {
                print(error)
            }
        }
    }
    

