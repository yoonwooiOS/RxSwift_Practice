//
//  RxSimplePickerViewController.swift
//  RxSwift_Practice
//
//  Created by 김윤우 on 7/31/24.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

final class RxSimplePickerViewController: BaseViewController {
    private let firstPicekrView = {
        let pv = UIPickerView()
        return pv
    }()
    private let secondPicekrView = {
        let pv = UIPickerView()
        return pv
    }()
    private let thirdPicekrView = {
        let pv = UIPickerView()
        return pv
    }()
    private let disposeBag = DisposeBag()
    private let numberData = [1,2,3]
    private let colorData = [UIColor.systemRed, UIColor.systemGreen, UIColor.systemBlue]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpPickerview()
    }
    override func setUpHierarchy() {
        view.addSubview(firstPicekrView)
        view.addSubview(secondPicekrView)
        view.addSubview(thirdPicekrView)
    }
    override func setUpLayout() {
        firstPicekrView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
           
        }
        secondPicekrView.snp.makeConstraints { make in
            make.top.equalTo(firstPicekrView.snp.bottom).offset(12)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            
        }
        thirdPicekrView.snp.makeConstraints { make in
            make.top.equalTo(secondPicekrView.snp.bottom).offset(12)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            
        }
    }
    private func setUpPickerview() {
        Observable.just(numberData)
            .bind(to: firstPicekrView.rx.itemTitles) { _, item in
            return "\(item)"
            }
            .disposed(by: disposeBag)
        firstPicekrView.rx.modelSelected(Int.self)
            .subscribe { models in
                print("models selected1 1: \(models)")
            }
            .disposed(by: disposeBag)
        
        Observable.just(numberData)
            .bind(to: secondPicekrView.rx.itemAttributedTitles) { _, item in
                return NSAttributedString(string: "\(item)", attributes: [
                    NSAttributedString.Key.foregroundColor: UIColor.cyan,
                    NSAttributedString.Key.underlineStyle: NSUnderlineStyle.double.rawValue
                ])
            }
            .disposed(by: disposeBag)
        secondPicekrView.rx.modelSelected(Int.self)
            .subscribe { models in
                print("models selected1 2: \(models)")
            }
            .disposed(by: disposeBag)
        
        Observable.just(colorData)
            .bind(to: thirdPicekrView.rx.items) { _, item, _ in
            let view = UIView()
                view.backgroundColor = item
                return view
            }
            .disposed(by: disposeBag)
        
        thirdPicekrView.rx.modelSelected(UIColor.self)
            .subscribe { models in
                print("models selected1 3: \(models)")
            }
            .disposed(by: disposeBag)
    }
}
