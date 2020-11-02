//
//  CollectionViewController.swift
//  MemoApp
//
//  Created by Masaki on R 2/10/28.
//

import UIKit
import RxSwift
import RxCocoa
import RealmSwift

private let reuseIdentifier = "Cell"

enum Section {
    case myMemo
}


class MemoCollectionViewController: UICollectionViewController {
    
    private let disposeBag = DisposeBag()
    
    let memoCollectionViewModel = MemoCollectionViewModel()
    var memoTitle = ""
    var myMemoArray = [String]() //この配列（アレイ）内の最初の文字列は、セクションのタイトルです
    var collectionViewDataSource: UICollectionViewDiffableDataSource<Section, String>!

    override func viewDidLoad() {
        super.viewDidLoad()

        var layoutConfig = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        let layout = UICollectionViewCompositionalLayout.list(using: layoutConfig)
        collectionView.collectionViewLayout = layout
//        layoutConfig.headerMode = UICollectionLayoutListConfiguration.HeaderMode.firstItemInSection
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        self.collectionViewDataSource = tableDataSource(collectionView: self.collectionView)
        collectionView.dataSource = self.collectionViewDataSource
        
        fetchMemoData()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        reloadMemoList()
    }
    
    
    
    
    class tableDataSource: UICollectionViewDiffableDataSource<Section, String> {

        init(collectionView: UICollectionView) {
            let cell = UICollectionView.CellRegistration<UICollectionViewListCell, String> { (cell, indexPath, item) in
                var content = cell.defaultContentConfiguration()
                content.text = item
                cell.contentConfiguration = content
            }
            super.init(collectionView: collectionView, cellProvider: { (collectionView, indexPath, item) -> UICollectionViewCell? in
                return collectionView.dequeueConfiguredReusableCell(using: cell, for: indexPath, item: item)
            })
        }

    }
    
    
    func reloadMemoList(){
        
        let realm = try! Realm()
        let memoCollection = realm.objects(MemoModel.self)
        for memo in memoCollection {
            print("タイトル:",memo.title)
            myMemoArray.append(memo.title)
        }
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, String>()
        snapshot.appendSections([Section.myMemo])
        snapshot.appendItems(myMemoArray, toSection: .myMemo)
        self.collectionViewDataSource.apply(snapshot)
        self.collectionView.reloadData()
    }
    
    
    func fetchMemoData(){
                rx.sentMessage(#selector(viewWillAppear(_:)))
                .subscribe(onNext: { _ in
                self.memoCollectionViewModel.fetchMemoCollectionArray()
                })
//                .addDisposableTo(disposeBag)
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    
        // Configure the cell
    
        return cell
    }
    
    func catchMemoData(title: String){
        self.myMemoArray.append(title)
        
    }

}
