//
//  RxSimpleTableViewController.swift
//  RxSwift_Practice
//
//  Created by 김윤우 on 7/31/24.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

final class RxSimpleTableViewController: BaseViewController {
    private let tableView = {
        let tableView = UITableView()
        
        return tableView
    }()
    private let disposedBag = DisposeBag()
    override func setUpHierarchy() {
        view.addSubview(tableView)
    }
    override func setUpLayout() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    override func setUpTableView() {
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        let items = Observable.just(
            (0..<20).map { "\($0)"}
        )
        items
            .bind(to: tableView.rx.items(cellIdentifier: "Cell", cellType: UITableViewCell.self)) { (row, element, cell) in
                
                cell.textLabel?.text = "\(element) @ row \(row)"
            }
            .disposed(by: disposedBag)
        
        tableView.rx
            .modelSelected(String.self)
            .subscribe { value in
                DefaultWireframe.presentAlert("Tapped `\(value)`")
            }
            .disposed(by: disposedBag)
        tableView.rx
            .itemAccessoryButtonTapped
            .subscribe { indexPath in
                DefaultWireframe.presentAlert("Tapped Detail @ \(indexPath.section), \(indexPath.row)")
            }
            .disposed(by: disposedBag)
        
    }
}
