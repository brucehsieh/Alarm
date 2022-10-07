//
//  RepeatAlarmViewController.swift
//  alarm clock
//
//  Created by Bruce Hsieh on 2022/8/24.
//

import UIKit
import SnapKit

class RepeatAlarmViewController: UIViewController {
    
    weak var repeatAlarmDelegate: UpadteRepeatLabelDelegate?
    
    var selectedDays:Set<Day> = []

    //MARK: - UI
    let repeatTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(RepeatAlarmTableViewCell.self, forCellReuseIdentifier: RepeatAlarmTableViewCell.identifier)
        tableView.bounces = false
        return tableView
    }()
    
    //MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        setViews()
        setLayouts()
        overrideUserInterfaceStyle = .dark
        }
    
    override func viewWillDisappear(_ animated: Bool) {
        repeatAlarmDelegate?.updateRepeatLabel(selectedDay: selectedDays)
        
    }
    func initView() {
        self.navigationController?.navigationBar.tintColor = .orange
        self.view.backgroundColor = .black
        self.repeatTableView.delegate = self
        self.repeatTableView.dataSource = self
    }
    
    
    
    //MARK: - setup UI
    func setViews() {
        self.view.addSubview(repeatTableView)
    }
    
    func setLayouts() {
        repeatTableView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(50)
            make.centerX.equalTo(self.view)
            make.width.equalTo(self.view)
            make.height.equalTo(350)
            }
        
//        saveButton.center = view.center
//        saveButton.addTarget(self, action: #selector(saveTapped), for: .touchUpInside)
    }
    
//    @objc private func saveTapped() {
//        repeatAlarmDelegate?.updateRepeatLabel(selectedDay: selectedDays)
//        print("SAVEDDD")
//    }
}

    // MARK: - Extension
extension RepeatAlarmViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Day.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RepeatAlarmTableViewCell.identifier, for: indexPath) as? RepeatAlarmTableViewCell else { return UITableViewCell() }
        let day = Day.allCases[indexPath.row]
        let isSelected = selectedDays.contains(day)
        cell.textLabel?.text = day.dayString
        cell.accessoryType = isSelected ? .checkmark : .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let day = Day.allCases[indexPath.row]
        if selectedDays.contains(day){
            selectedDays.remove(day)
        }else {
            selectedDays.insert(day)
        }
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
}


