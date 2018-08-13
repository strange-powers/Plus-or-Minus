//
//  WeeksViewController.swift
//  Plus or Minus
//
//  Created by Julian Vöst on 03.08.18.
//  Copyright © 2018 Julian Vöst. All rights reserved.
//

import UIKit

class WeeksViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    var weeks = [[Day]]()
    @IBOutlet weak var collection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collection.dataSource = self
        collection.delegate = self
        
        let weekDates = Calendar.current.getWeekDates(from: Date())
        let curWeek = weekDates.map({ Day(date: $0) })
        weeks.append(curWeek)
        
        for index in 0..<10 {
            if let firstWeekDay = weeks[index].first?.date {
                if let lastDayOfLastWeek = Calendar.current.date(byAdding: .day, value: -1, to: firstWeekDay) {
                    let lastWeek = Calendar.current.getWeekDates(from: lastDayOfLastWeek)
                    let week = lastWeek.map({ Day(date: $0) })
                    weeks.append(week)
                } else {
                    // TODO: Do some error handling ... but what error handling ?
                }
            } else {
                // TODO: Do some error handling ... but what error handling ?
            }
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let collectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "lol", for: indexPath)
        
        UIView.makeCircleFrom(collectionCell)
        
        return collectionCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let currentWeekVC = navigationController?.viewControllers[0] as? CurrentWeekViewController {
            currentWeekVC.week = weeks[indexPath.row]
        }
        
        navigationController?.popToRootViewController(animated: true)
    }

}
