//
//  AddingNumbersViewController.swift
//  RxSwift_Practice
//
//  Created by 김윤우 on 7/31/24.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class AddingNumbersViewController: BaseViewController {
   private var firstNumberTextField = {
        let tf = UITextField()
        tf.borderStyle = .roundedRect
        tf.layer.borderWidth = 1
        return tf
    }()
    private var secondNumberTextField = {
        let tf = UITextField()
        tf.borderStyle = .roundedRect
        tf.layer.borderWidth = 1
        return tf
    }()
    private let sepratorLine = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    private var thirdNumberTextField = {
        let tf = UITextField()
        tf.borderStyle = .roundedRect
        tf.layer.borderWidth = 1
        return tf
    }()
    private let resultLabel = {
        let label = UILabel()
        
        return label
    }()
    let disposebag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNumberCalc()
    }
    override func setUpHierarchy() {
        view.addSubview(firstNumberTextField)
        view.addSubview(secondNumberTextField)
        view.addSubview(thirdNumberTextField)
        view.addSubview(sepratorLine)
        view.addSubview(resultLabel)
    }
    
    override func setUpLayout() {
        firstNumberTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(40)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(40)
            make.height.equalTo(40)
        }
        secondNumberTextField.snp.makeConstraints { make in
            make.top.equalTo(firstNumberTextField.snp.bottom).offset(12)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(40)
            make.height.equalTo(40)
        }
        thirdNumberTextField.snp.makeConstraints { make in
            make.top.equalTo(secondNumberTextField.snp.bottom).offset(12)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(40)
            make.height.equalTo(40)
        }
        sepratorLine.snp.makeConstraints { make in
            make.top.equalTo(thirdNumberTextField.snp.bottom).offset(12)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(40)
            make.height.equalTo(1)
        }
        resultLabel.snp.makeConstraints { make in
            make.top.equalTo(sepratorLine.snp.bottom).offset(12)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(40)
            make.height.equalTo(40)
        }
        
    }
    
    private func setUpNumberCalc() {
        Observable.combineLatest(firstNumberTextField.rx.text.orEmpty, secondNumberTextField.rx.text.orEmpty, thirdNumberTextField.rx.text.orEmpty) { firstValue, secondValue, thirdValue -> Int in
                return (Int(firstValue) ?? 0) + (Int(secondValue) ?? 0) + (Int(thirdValue) ?? 0)
            }
        .map{ $0.description }
        .bind(to: resultLabel.rx.text)
        .disposed(by: disposebag)
    }
    
}
