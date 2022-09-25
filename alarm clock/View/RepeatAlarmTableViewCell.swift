//
//  RepeatAlarmTableViewCell.swift
//  alarm clock
//
//  Created by Bruce Hsieh on 2022/8/24.
//

import UIKit

class RepeatAlarmTableViewCell: UITableViewCell {

    static let identifier = "repeatAlarmTableViewCell"

// MARK: - UI
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        return label
    }()

// MARK: - init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .darkGray
        setViews()
        setLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setViews() {
        self.addSubview(titleLabel)
    }
    
    func setLayouts() {
        titleLabel.snp.makeConstraints { make in
            make.top.bottom.equalTo(self)
            make.leading.equalTo(self).offset(10)
        }
    }
}
