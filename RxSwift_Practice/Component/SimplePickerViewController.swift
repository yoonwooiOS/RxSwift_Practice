//
//  SimplePickerViewController.swift
//  RxSwift_Practice
//
//  Created by 김윤우 on 7/30/24.
//

import UIKit
import RxCocoa
import RxSwift
import SnapKit

final class SimplePickerViewController: UIViewController {
    private let simplePickerView = {
        let pickerView = UIPickerView()
        pickerView.backgroundColor = .systemGreen
        return pickerView
    }()
    private let simpleLabel = {
            let label = UILabel()
        label.backgroundColor = .systemGray
        return label
    }()
    private let simpleTableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .darkGray
        return tableView
    }()
    
    private let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpHierarchy()
        setUpLayout()
        setUpView()
        setPicekrView()
       
    }
    private func setUpHierarchy() {
        view.addSubview(simplePickerView)
        view.addSubview(simpleLabel)
        view.addSubview(simpleTableView)
    }
    private func setUpLayout() {
        simplePickerView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(24)
           
        }
        simpleLabel.snp.makeConstraints { make in
            make.top.equalTo(simplePickerView.snp.bottom).offset(12)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(24)
            make.height.equalTo(40)
        }
        
    }
    private func setUpView() {
        view.backgroundColor = .white
    }
    private func setPicekrView() {
        
        let items = Observable.just([
            "영화",
            "애니메이션",
            "드라마",
            "기타"
        ])
        items
            .bind(to: simplePickerView.rx.itemTitles) {(row, elemnet) in
                return elemnet
            }
            .disposed(by: disposeBag)
        
        simplePickerView.rx.modelSelected(String.self)
            .debug("before")
//            .map { "\($0)" }
            .map { $0.description }
            .debug("after")
            .bind(to: simpleLabel.rx.text)
            .disposed(by: disposeBag)
    }
    
}

