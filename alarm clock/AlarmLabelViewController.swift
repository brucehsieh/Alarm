//
//  AlarmLabelViewController.swift
//  alarm clock
//
//  Created by Bruce Hsieh on 2022/8/24.
//

import UIKit
import SnapKit

class AlarmLabelViewController: UIViewController {
    
    weak var updateAlarmLabelDelegate: UpdateAlarmLabelDelegate?
    
    //MARK: - UI
    let alarmLabelTextField: UITextField = {
        let textField = UITextField()
        textField.text = "鬧鐘"
        textField.clearButtonMode = .whileEditing
        textField.borderStyle = .roundedRect
        textField.font = UIFont.systemFont(ofSize: 20)
        return textField
    }()
    
    //MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        setViews()
        setLayouts()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if let text = alarmLabelTextField.text {
            if text == "" {
                updateAlarmLabelDelegate?.updateAlarmLabel(alarmLabelText: "鬧鐘")
            }else {
                updateAlarmLabelDelegate?.updateAlarmLabel(alarmLabelText: text)
            }
        }
    }
        func initView() {
            self.view.backgroundColor = .secondarySystemBackground
            self.overrideUserInterfaceStyle = .dark
            self.title = "標籤"
            self.navigationController?.navigationBar.tintColor = .orange
        }
    
    //MARK: - setup UI
        func setViews() {
            self.view.addSubview(alarmLabelTextField)
        }
        
        func setLayouts() {
            alarmLabelTextField.snp.makeConstraints { make in
                make.top.equalTo(self.view).offset(300)
                make.centerX.equalTo(self.view)
                make.width.equalTo(self.view)
                make.height.equalTo(50)
            }
        }
       
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        navigationController?.popViewController(animated: true)
//        return true
//    }
}
    


