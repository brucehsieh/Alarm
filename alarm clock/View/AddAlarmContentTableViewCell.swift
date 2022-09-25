//
//  addAlarmContentTableViewCell.swift
//  alarm clock
//
//  Created by Bruce Hsieh on 2022/8/18.
//

import UIKit
import SnapKit

class AddAlarmContentTableViewCell: UITableViewCell {

    static let identifier = "addAlarmContentTableViewCell"
    
    //MARK: - UI
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        return label
    }()

    let contentLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let detailIamgeView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "chevron.right"))
        imageView.tintColor = .lightGray
        return imageView
    }()
    
    //MARK: - init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.accessoryView = detailIamgeView
        setViews()
        setLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - setup UI
    func setViews() {
        self.addSubview(titleLabel)
        self.addSubview(contentLabel)
    }
    
    func setLayouts() {
        
        titleLabel.snp.makeConstraints { make in
            make.top.bottom.equalTo(self)
            make.leading.equalTo(self).offset(10)
        }
        
        contentLabel.snp.makeConstraints { make in
            make.top.bottom.equalTo(self)
            make.trailing.equalTo(self).offset(-50)
        }
    }

}


