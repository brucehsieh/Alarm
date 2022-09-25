//
//  MainTabbarController.swift
//  alarm clock
//
//  Created by Bruce Hsieh on 2022/8/16.
//

import UIKit

class MainTabbarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let worldClockVC = WorldClockViewController()
        let alarmVC = AlarmViewController()
        let stopWatachVC = StopWatchViewController()
        let timerVC = TimerViewController()
        
        worldClockVC.tabBarItem.image = UIImage(systemName: "network")
        alarmVC.tabBarItem.image = UIImage(systemName: "alarm.fill")
        stopWatachVC.tabBarItem.image = UIImage(systemName: "stopwatch.fill")
        timerVC.tabBarItem.image = UIImage(systemName: "timer")
        
        worldClockVC.title = "世界時鐘"
        alarmVC.title = "鬧鐘"
        stopWatachVC.title = "碼表"
        timerVC.title = "計時器"
        
        let navAlarm = UINavigationController(rootViewController: alarmVC)
        
        navAlarm.navigationBar.isTranslucent = false
        navAlarm.navigationBar.barTintColor = .black
        navAlarm.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navAlarm.navigationBar.prefersLargeTitles = true
        navAlarm.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, .font: UIFont.boldSystemFont(ofSize: 40)]
        
        self.tabBar.barTintColor = .clear
        self.tabBar.tintColor = .orange
        
        setViewControllers([worldClockVC, navAlarm, stopWatachVC, timerVC], animated: false)
    }
}
