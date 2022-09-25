//
//  WakeUpTableViewCell.swift
//  alarm clock
//
//  Created by Bruce Hsieh on 2022/8/31.
//

import UIKit
import SnapKit

class WakeUpTableViewCell: UITableViewCell {

    static let identifier = "wakeUpTableViewCell"
    
    //MARK: - UI
    let wakeUpLabel: UILabel = {
        let label = UILabel()
        label.text = "沒有鬧鐘"
        label.textColor = .gray
        return label
    }()
    
    let settingButton: UIButton = {
        let button = UIButton()
        button.setTitle("設定", for: .normal)
        button.setTitleColor(.orange, for: .normal)
        return button
    }()
    
    //MARK: - init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .clear
        setViews()
        setLayouts()
        }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder) hase not been implemented")
    }
   
    //MARK: - setup UI
    func setViews() {
        self.addSubview(wakeUpLabel)
        self.addSubview(settingButton)
    }
    
    func setLayouts() {
        wakeUpLabel.snp.makeConstraints { make in
            make.top.equalTo(self).offset(20)
            make.bottom.equalTo(self).offset(-20)
            make.leading.equalTo(self).offset(10)
        }
        
        settingButton.snp.makeConstraints { make in
            make.top.bottom.equalTo(self)
            make.trailing.equalTo(self).offset(-10)
        }
    }
}
