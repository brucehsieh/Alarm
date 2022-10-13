//
//  AddAlarmViewController.swift
//  alarm clock
//
//  Created by Bruce Hsieh on 2022/8/16.
//

import UIKit
import SnapKit

// git
protocol UpdateAlaramListDelegate: AnyObject{
    func updateAlarmList(alarmData: AlarmModel, index: Int)
}

protocol UpdateAlarmLabelDelegate: AnyObject {
    func updateAlarmLabel(alarmLabelText: String)
}

protocol UpadteRepeatLabelDelegate:AnyObject{
    func updateRepeatLabel(selectedDay:Set<Day>)
}

protocol EdingModelWithIndexPath: AnyObject{
    func update(alarm: AlarmModel, indexPath:IndexPath)
}

class AddAlarmViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: - UI
    let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .time
        datePicker.locale = Locale(identifier: "NL")
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.tintColor = .orange
        return datePicker
    }()
    
    let timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "時間"
        return label
    }()
    
    let addAlarmTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(AddAlarmContentTableViewCell.self, forCellReuseIdentifier: AddAlarmContentTableViewCell.identifier)
        tableView.register(AddAlarmButtonTableViewCell.self, forCellReuseIdentifier: AddAlarmButtonTableViewCell.identifier)
        tableView.bounces = false
        return tableView
    }()
    
    let titles = AddAlarmCell.allCases
    
    var tempIndex: Int = 0
    
    var alarmModel = AlarmModel() {
        didSet{
            addAlarmTableView.reloadData()
        }
    }
    
   weak var updateAlarmListDelegate: UpdateAlaramListDelegate?
    
    //MARK: - checkmode
    var indexPath: IndexPath?
    
    //MARK: - tableview
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
        let row = titles[indexPath.row]
        
        switch row {
        case .repeatAlarm:
            cell.detailTextLabel?.text = alarmModel.repeatDay
            cell.accessoryType = .disclosureIndicator
        case .addAlarm:
            cell.detailTextLabel?.text = alarmModel.annotation
            cell.accessoryType = .disclosureIndicator
        case .sound:
            cell.detailTextLabel?.text = "雷達"
            cell.accessoryType = .disclosureIndicator
        case .snooze:
            cell.accessoryView = UISwitch()
        }
        cell.textLabel?.text = row.title
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = titles[indexPath.row]
        switch row {
        case .repeatAlarm:
            let vc = RepeatAlarmViewController()
            vc.selectedDays = alarmModel.selectDays
            vc.repeatAlarmDelegate = self
            self.navigationController?.pushViewController(vc, animated: true)
            tableView.deselectRow(at: indexPath, animated: true)
        case .addAlarm:
            let vc = AlarmLabelViewController()
            vc.updateAlarmLabelDelegate = self
            vc.alarmLabelTextField.text = alarmModel.annotation
            self.navigationController?.pushViewController(vc, animated: true)
        default:
            break
        }
    }
    
    //MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setNavigation()
        setLayouts()
        setupTableView()
        datePicker.addTarget(self, action: #selector(changeDate), for: .valueChanged)
        datePicker.date = alarmModel.time
    }
    
    //MARK: - set navigation
    func setNavigation() {
        self.title = "加入鬧鐘"
        
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]
        
        self.navigationController?.navigationBar.barTintColor = .black
        
        let cancelButton = UIBarButtonItem(title: "取消",
                                           style: .plain,
                                           target: self,
                                           action: #selector(backToMain))
        cancelButton.tintColor = .orange
        self.navigationItem.leftBarButtonItem = cancelButton
        
        let saveButton = UIBarButtonItem(title: "儲存",
                                         style: .plain,
                                         target: self,
                                         action: #selector(saveAlarm))
        saveButton.tintColor = .orange
        self.navigationItem.rightBarButtonItem = saveButton
    }
    
    func setupTableView() {
        self.addAlarmTableView.delegate = self
        self.addAlarmTableView.dataSource = self
    }
    
    @objc func backToMain () {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func changeDate(_ sender: UIDatePicker) {
        alarmModel.time = sender.date
    }
    
    @objc func saveAlarm () {
        updateAlarmListDelegate?.updateAlarmList(alarmData: alarmModel, index: tempIndex)
        self.dismiss(animated: true, completion: nil)
        
    }

    
    //MARK: - Auto layout
    func setLayouts() {
 
        // stackView
        let timeStackView = UIStackView(arrangedSubviews: [timeLabel, datePicker])
        timeStackView.axis = .horizontal
        timeStackView.spacing = 8
        
        self.view.addSubview(timeStackView)
        self.view.addSubview(addAlarmTableView)

        timeStackView.snp.makeConstraints { make in
            make.top.equalTo(120)
            make.leading.equalTo(24)
            make.centerX.equalToSuperview()
        }
        
        addAlarmTableView.snp.makeConstraints { make in
            make.top.equalTo(timeStackView.snp.bottom).offset(50)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}

    //MARK: - delegate extension
extension AddAlarmViewController: UpdateAlarmLabelDelegate {
    func updateAlarmLabel(alarmLabelText: String) {
        alarmModel.annotation = alarmLabelText
    }
}

extension AddAlarmViewController: UpadteRepeatLabelDelegate{
    func updateRepeatLabel(selectedDay: Set<Day>) {
        alarmModel.selectDays = selectedDay
    }
}

    //MARK: - Nested type
extension AddAlarmViewController {
    enum AddAlarmCell: Int, CaseIterable {
        case repeatAlarm = 0, addAlarm, sound, snooze
        
        var title: String{
            switch self {
            case .repeatAlarm:
                return "重複"
            case .addAlarm:
                return "標籤"
            case .sound:
                return "提示聲"
            case .snooze:
                return "稍後提醒"
                
            }
            
        }
    }
    
//    enum Status: Int, CaseIterable {
//        case edit = 0, add
//    }
}

