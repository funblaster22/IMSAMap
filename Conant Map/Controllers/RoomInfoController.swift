//
//  RoomInfoController.swift
//  Conant Map
//
//  Created by Johnny Waity on 8/17/18.
//  Copyright © 2018 Johnny Waity. All rights reserved.
//

import UIKit

class RoomInfoController: UIViewController {
    
    let room:String
    
    init(room:String) {
        self.room = room
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Not Supported")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = room
        view = UIScrollView()
        
        setupView()
    }

    func setupView(){
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 8
        var roomClasses:[Class] = []
        for c in Global.classes {
            if c.location.lowercased() == room.lowercased() {
                roomClasses.append(c)
            }
        }
        var sorted:[String:[Class]] = [:]
        for c in roomClasses {
            print(c.name)
            print(c.period)
            print(c.location)
            if let pList = sorted[c.period]{
                var isDuplicate = false
                for c1 in pList{
                    if(c.period == c1.period && c.staff.name == c1.staff.name){
                        //Duplicate
                        isDuplicate = true
                    }
                }
                if !isDuplicate{
                    sorted[c.period]?.append(c)
                }
                
            }
            else{
                sorted[c.period] = [c]
            }
        }
        var fullySorted:[Class] = []
        if let p1 = sorted["1"]{
            fullySorted.append(contentsOf: p1)
        }
        if let p2 = sorted["2"]{
            fullySorted.append(contentsOf: p2)
        }
        if let p3 = sorted["3"]{
            fullySorted.append(contentsOf: p3)
        }
        if let p4 = sorted["4"]{
            fullySorted.append(contentsOf: p4)
        }
        if let p5 = sorted["5"]{
            fullySorted.append(contentsOf: p5)
        }
        if let p6 = sorted["6"]{
            fullySorted.append(contentsOf: p6)
        }
        if let p7 = sorted["7"]{
            fullySorted.append(contentsOf: p7)
        }
        if let p8 = sorted["8"]{
            fullySorted.append(contentsOf: p8)
        }
        if let ac = sorted["AC"]{
            fullySorted.append(contentsOf: ac)
        }
        
        let scroll = view as! UIScrollView
        scroll.contentSize = CGSize(width: view.bounds.width, height: CGFloat(50 * fullySorted.count + 200))
        let scheduleBackground = UIView()
        scheduleBackground.backgroundColor = UIColor(red: 239/255, green: 239/255, blue: 239/255, alpha: 239/255)
        scheduleBackground.translatesAutoresizingMaskIntoConstraints = false
        scheduleBackground.layer.cornerRadius = 8
        scheduleBackground.clipsToBounds = true
        view.addSubview(scheduleBackground)
        scheduleBackground.topAnchor.constraint(equalTo: view.topAnchor, constant: 75).isActive = true
        scheduleBackground.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9).isActive = true
        scheduleBackground.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        scheduleBackground.heightAnchor.constraint(equalToConstant: CGFloat(50 * fullySorted.count)).isActive = true
        
        
        var lastView = scheduleBackground
        for c in fullySorted {
            let listingContainer = UIView()
            listingContainer.backgroundColor = UIColor.clear
            listingContainer.translatesAutoresizingMaskIntoConstraints = false
            
            let periodLabel = UILabel()
            periodLabel.text = ("Period " + c.period) + ":"
            periodLabel.translatesAutoresizingMaskIntoConstraints = false
            periodLabel.adjustsFontSizeToFitWidth = true
            periodLabel.textColor = UIColor.lightGray
            
            listingContainer.addSubview(periodLabel)
            periodLabel.leftAnchor.constraint(equalTo: listingContainer.leftAnchor, constant: 5).isActive = true
            periodLabel.centerYAnchor.constraint(equalTo: listingContainer.centerYAnchor).isActive = true
            periodLabel.widthAnchor.constraint(equalTo: listingContainer.widthAnchor, multiplier: 0.4).isActive = true
            
//            let nameLabel = UILabel()
//            nameLabel.text = c.name
//            nameLabel.translatesAutoresizingMaskIntoConstraints = false
//            nameLabel.adjustsFontSizeToFitWidth = true
//            listingContainer.addSubview(nameLabel)
//            nameLabel.leftAnchor.constraint(equalTo: periodLabel.rightAnchor, constant: 5).isActive = true
//            nameLabel.centerYAnchor.constraint(equalTo: listingContainer.centerYAnchor).isActive = true
//            nameLabel.widthAnchor.constraint(equalTo: listingContainer.widthAnchor, multiplier: 0.49).isActive = true

            let teacherButton = UIButton(type: .system)
            teacherButton.setTitle(c.staff.name, for: .normal)
            teacherButton.translatesAutoresizingMaskIntoConstraints = false
            teacherButton.titleLabel?.adjustsFontSizeToFitWidth = true

            listingContainer.addSubview(teacherButton)
            teacherButton.leftAnchor.constraint(equalTo: periodLabel.rightAnchor, constant: 5).isActive = true
            teacherButton.rightAnchor.constraint(equalTo: listingContainer.rightAnchor, constant: -5).isActive = true
            teacherButton.centerYAnchor.constraint(equalTo: listingContainer.centerYAnchor).isActive = true
            
            if fullySorted.last?.id != c.id {
                let seperator = UIView()
                seperator.backgroundColor = UIColor.lightGray
                seperator.translatesAutoresizingMaskIntoConstraints = false
                
                listingContainer.addSubview(seperator)
                seperator.bottomAnchor.constraint(equalTo: listingContainer.bottomAnchor).isActive = true
                seperator.leftAnchor.constraint(equalTo: listingContainer.leftAnchor).isActive = true
                seperator.rightAnchor.constraint(equalTo: listingContainer.rightAnchor).isActive = true
                seperator.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
            }
            
            
            scheduleBackground.addSubview(listingContainer)
            listingContainer.topAnchor.constraint(equalTo: (fullySorted.first!.id == c.id) ? lastView.topAnchor : lastView.bottomAnchor).isActive = true
            listingContainer.leftAnchor.constraint(equalTo: scheduleBackground.leftAnchor).isActive = true
            listingContainer.rightAnchor.constraint(equalTo: scheduleBackground.rightAnchor).isActive = true
            listingContainer.heightAnchor.constraint(equalToConstant: 50).isActive = true
            
            lastView = listingContainer
            
        }
        
    }
    
    

}
