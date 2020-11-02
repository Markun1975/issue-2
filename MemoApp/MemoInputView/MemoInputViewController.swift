//
//  ViewController.swift
//  MemoApp
//
//  Created by Masaki on R 2/10/28.

import UIKit
import RxSwift
import RxCocoa


class MemoInputViewController: UIViewController {
    
    
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var saveButton: UIButton!
    
    let disposeBag = DisposeBag()
    
    private let viewModel = MemoInputViewModel()
    
    var titleText = String()
    var memoText = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        observableTextField()
        saveProcess()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    
    
    private func observableTextField(){
        titleTextField.rx.text.asObservable()
            .subscribe { [unowned self] _ in
                viewModel.inputTitleMemo(title: self.titleTextField.text ?? "")
                }
                .disposed(by: disposeBag)
        
    }
    
    private func saveProcess(){
        saveButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                self?.viewModel.addMemo(title: self?.titleTextField.text ?? "")
                    }
            )
            .disposed(by: disposeBag)
    }
}

