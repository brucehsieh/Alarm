//
//  AlarmOtherTableViewCell.swift
//  alarm clock
//
//  Created by Bruce Hsieh on 2022/9/1.
//

import UIKit
import SnapKit

class AlarmOtherTableViewCell: UITableViewCell {

    static let identifier = "alarmOtherTableViewCell"
    
    var callBackSwitchState:((Bool) -> (Void))?
    
    //MARK: - UI
    lazy var accessorySwitch: UISwitch = {
        let uiSwitch = UISwitch(frame: .zero)
        uiSwitch.backgroundColor = .lightGray
        uiSwitch.layer.cornerRadius = uiSwitch.frame.height / 2.0
        uiSwitch.addTarget(self, action: #selector(switchChanged), for: .valueChanged)
        return uiSwitch
    }()
    
    //MARK: - init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .clear
        self.accessoryView = accessorySwitch
        //self.editingAccessoryType = .disclosureIndicator
        textLabel?.textColor = .lightGray
        textLabel?.font = UIFont.systemFont(ofSize: 50)
        detailTextLabel?.textColor = .lightGray
        detailTextLabel?.font = UIFont.systemFont(ofSize: 20)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

@objc func switchChanged(_ sender : UISwitch){
    callBackSwitchState?(sender.isOn)
    if sender.isOn{
        textLabel?.textColor = .white
        detailTextLabel?.textColor = .white
        
    }else{
        textLabel?.textColor = .lightGray
        detailTextLabel?.textColor = .lightGray
    }
}
}
