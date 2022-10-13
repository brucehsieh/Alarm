//
//  AlarmViewController.swift
//  alarm clock
//
//  Created by Bruce Hsieh on 2022/8/16.
//

import UIKit
import SnapKit

class AlarmViewController: UIViewController {
    
    private let sections: [Section] = [.wakeUp, .alarms]
    
    var alarmSave = AlarmSave() {
        didSet {
            alarmTableView.reloadData()
        }
    }
    // access control
    //MARK: - UI
    private let alarmTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .black
        tableView.register(WakeUpTableViewCell.self, forCellReuseIdentifier: WakeUpTableViewCell.identifier)
        tableView.register(AlarmOtherTableViewCell.self, forCellReuseIdentifier: AlarmOtherTableViewCell.identifier)
        tableView.backgroundColor = .black
        return tableView
    }()
    
    //MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayouts()
        setNavigation()
        setTableView()
    }
    
    //MARK: - autolayouts
    private func setLayouts() {
        self.view.addSubview(alarmTableView)
        alarmTableView.snp.makeConstraints { make in make.edges.equalToSuperview() }
    }
    
    //MARK: - set navigation
    private func setNavigation() {
        let editButton = UIBarButtonItem(title: "編輯",
                                         style: .plain,
                                         target: self,
                                         action: #selector(editAlarm))
        editButton.tintColor = .orange
        navigationItem.leftBarButtonItem = editButton
        
        let addButton = UIBarButtonItem(image:UIImage(systemName: "plus"),
                                        style: .plain,
                                        target: self,
                                        action: #selector(addAlarm))
        addButton.tintColor = .orange
        navigationItem.rightBarButtonItem = addButton
    }
    
    // MARK: - Action
    @objc private func editAlarm(_ sender: UIBarButtonItem) {
        alarmTableView.isEditing.toggle()
        sender.title = (alarmTableView.isEditing) ? "完成" : "編輯"
    }
    
    @objc private func addAlarm() {
        let vc = AddAlarmViewController()
        vc.updateAlarmListDelegate = self
        let nv = UINavigationController(rootViewController: vc)
        present(nv, animated: true, completion: nil)
    }
    
    private func setTableView() {
        alarmTableView.delegate = self
        alarmTableView.dataSource = self
    }
}

// MARK: - UITableViewDataSource
extension AlarmViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch sections[section] {
        case .wakeUp:  return 1
        case .alarms : return alarmSave.alarms.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch sections[indexPath.section] {
        case .wakeUp: return configureWakeUpTableViewCell(tableView, cellForRowAt: indexPath)
        case .alarms: return configureAlarmTableViewCell(tableView, cellForRowAt: indexPath)
        }
    }
    
    private func configureWakeUpTableViewCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WakeUpTableViewCell.identifier, for: indexPath) as? WakeUpTableViewCell else { return UITableViewCell() }
        return cell
    }
    
    private func configureAlarmTableViewCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AlarmOtherTableViewCell.identifier, for: indexPath) as? AlarmOtherTableViewCell else { return UITableViewCell() }
        let alarm = alarmSave.alarms[indexPath.row]
        cell.configure(alarm)
        // ARC, retain cycle, weak owned
        cell.callBackSwitchState = { [weak self](isOn) in
            self?.alarmSave.switchOn(indexPath.row, isOn)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerTitle = sections[section].headerTitle
        let view = AlarmHeaderView()
        view.headerViewLabel.text = headerTitle
        return view
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if indexPath.section == 1{ return true}
        return false
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            alarmSave.remove(indexPath.row)
        }
    }
}

// MARK: - UITableViewDelegate
extension AlarmViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1{
            alarmSave.isEdit = true
            let rootVC = AddAlarmViewController()
            rootVC.updateAlarmListDelegate = self
            
            let alarm = alarmSave.alarms[indexPath.row]
            rootVC.alarmModel = alarm
            rootVC.tempIndex = indexPath.row
            
            let navVC = UINavigationController(rootViewController: rootVC)
            present(navVC, animated: true)
            
            tableView.deselectRow(at: indexPath, animated: false)
        }
    }
}
// MARK: - UpdateAlaramListDelegate
extension AlarmViewController: UpdateAlaramListDelegate {
    func updateAlarmList(alarmData: AlarmModel, index: Int) {
        if alarmSave.isEdit == false{
            alarmSave.append(alarmData)
        }else{
            alarmSave.edit(alarmData, index)
        }
    }
}

// MARK: - Nested Types
extension AlarmViewController {
    
    // enum
    enum Section: Int, CaseIterable {
        case wakeUp = 0, alarms
        
        var headerTitle: String? {
            switch self {
            case .wakeUp: return "睡眠 ｜ 起床鬧鐘"
            case .alarms: return "其他"
            }
        }
    }
}

