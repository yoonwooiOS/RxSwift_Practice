//
//  SimpleTableViewController.swift
//  RxSwift_Practice
//
//  Created by 김윤우 on 7/30/24.
//

import UIKit
import SnapKit
import RxCocoa
import RxSwift
import SnapKit

class SimpleTableViewController: UIViewController {
    private let simpleTableView = UITableView()
    private let simpleLabel = {
            let label = UILabel()
        label.backgroundColor = .systemGray
        return label
    }()
    private let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        setUpTableView()
    }
    private func setUpView() {
        view.backgroundColor = .white
        view.addSubview(simpleLabel)
        view.addSubview(simpleTableView)
       
        simpleLabel.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(40)
        }
        simpleTableView.snp.makeConstraints { make in
            make.top.equalTo(simpleLabel.snp.bottom).offset(12)
            make.bottom.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
        }
        
    }
    private func setUpTableView() {
        
        simpleTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        let items = Observable.just([
            "First Item",
            "second Item",
            "Third Item",
        ])
        items
            .bind(to: simpleTableView.rx.items) { (tableView, row, element) in
                let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
                cell.textLabel?.text = "\(element) @ row \(row)"
                
                return cell
            }
            .disposed(by: disposeBag)
        
        simpleTableView.rx.modelSelected(String.self)
            .map { data in
                "\(data)를 클릭했습니다."
            }
            .bind(to: simpleLabel.rx.text)
            .disposed(by: disposeBag)
    }
    
    
}

