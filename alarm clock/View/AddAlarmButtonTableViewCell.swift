//
//  AddAlarmButtonTableViewCell.swift
//  alarm clock
//
//  Created by Bruce Hsieh on 2022/8/23.
//

import UIKit
import SnapKit

//製作UISwitch
class AddAlarmButtonTableViewCell: UITableViewCell {

    static let identifier = "addAlarmButtonTableViewCell"
    
    //MARK: - UI
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        return label
    }()
    
    //MARK: - setup UI
    func setLayouts() {
        titleLabel.snp.makeConstraints { make in
            make.top.bottom.equalTo(self)
            make.leading.equalTo(self).offset(10)
        }
    }
    
    func setViews() {
        self.addSubview(titleLabel)
    }
    
    //MARK: - init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.accessoryView = UISwitch(frame: .zero)
        setViews()
        setLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
