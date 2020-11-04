//
//  MemoTableViewController.swift
//  MemoApp
//
//  Created by Masaki on R 2/11/04.
//
import UIKit
import RxSwift
import RxCocoa
import RealmSwift

class MemoTableViewController: UITableViewController {
    
    @IBOutlet var memoTableView: UITableView!
    
    
    private let disposeBag = DisposeBag()
    let memoTableViewModel = MemoTableViewModel()
    var myMemoArray = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchMemoData()
    }
    
    override func didReceiveMemoryWarning() {
           super.didReceiveMemoryWarning()
       }
    
    
    
    func fetchMemoData(){
                rx.sentMessage(#selector(viewWillAppear(_:)))
                .subscribe(onNext: { _ in
                    self.myMemoArray.removeAll()
                    self.memoTableViewModel.fetchMemoTableArray()
                    self.setMemoList()
                })
                .addDisposableTo(disposeBag)
    }
    
    func setMemoList(){
        myMemoArray = UserDefaults.standard.object(forKey: "memoArray") as! [String]
        self.tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myMemoArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "memoCell", for: indexPath)
        cell.textLabel!.text = myMemoArray[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let memoCount:Int = indexPath.row
        let alert: UIAlertController = UIAlertController(title: "メモ削除", message: "メモを削除してもいいですか？", preferredStyle:  UIAlertController.Style.alert)
            // OKボタン
        let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.destructive, handler:{
                // ボタンが押された時の処理を書く（クロージャ実装）
                (action: UIAlertAction!) -> Void in
            self.memoTableViewModel.removeMemoTableArray(memoNumber: memoCount)
            self.memoTableViewModel.fetchMemoTableArray()
            self.setMemoList()
            })
            // キャンセルボタン
        let cancelAction: UIAlertAction = UIAlertAction(title: "キャンセル", style: UIAlertAction.Style.cancel, handler:{
                // ボタンが押された時の処理を書く（クロージャ実装）
                (action: UIAlertAction!) -> Void in
                print("Cancel")
            })
            alert.addAction(cancelAction)
            alert.addAction(defaultAction)
            present(alert, animated: true, completion: nil)
    }

    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
}
