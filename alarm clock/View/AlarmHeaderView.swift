//
//  AlarmHeaderView.swift
//  alarm clock
//
//  Created by Bruce Hsieh on 2022/8/30.
//

import UIKit
import SnapKit

class AlarmHeaderView: UIView {

    //MARK: - UI
    let headerViewLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    //MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .black
        setViews()
        setLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - setupUI
    func setViews() {
        self.addSubview(headerViewLabel)
    }
    
    func setLayouts() {
        headerViewLabel.snp.makeConstraints { make in
            make.top.bottom.equalTo(self)
            make.leading.equalTo(self).offset(10)
        }
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
