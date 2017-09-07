//
//  MarketViewController.swift
//  Slug Ride 2
//
//  Created by Andrew dato on 7/6/17.
//  Copyright © 2017 Andrew Dat0. All rights reserved.
//


import LBTAComponents
import Foundation


class RSFooter: DatasourceCell {
    override func setupViews() {
        super.setupViews()
        backgroundColor = .red
    }
}

class RSHeader: DatasourceCell {
    override func setupViews() {
        super.setupViews()
        backgroundColor = .red
    }
}

class RSCell: DatasourceCell {
    
    override var datasourceItem: Any? {
        didSet {
            guard datasourceItem != nil else {return}
    
        }
    }
    
    let weeklyLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.text = "Weekly Goals"
        label.textColor = .white
        return label
    }()
    
    let back6: UILabel = {
        let label = UILabel()
        label.layer.cornerRadius = 15
        label.layer.borderColor = UIColor.yellow.cgColor
        label.layer.borderWidth = 1
        label.layer.backgroundColor = UIColor(r: 227, g: 226, b: 191).cgColor
        return label
    }()
    let back7: UILabel = {
        let label = UILabel()
        label.layer.cornerRadius = 15
        label.layer.borderColor = UIColor.yellow.cgColor
        label.layer.borderWidth = 1
        label.layer.backgroundColor = UIColor(r: 227, g: 226, b: 191).cgColor
        return label
    }()
    let back8: UILabel = {
        let label = UILabel()
        label.layer.cornerRadius = 15
        label.layer.borderColor = UIColor.yellow.cgColor
        label.layer.borderWidth = 1
        label.layer.backgroundColor = UIColor(r: 227, g: 226, b: 191).cgColor
        return label
    }()
    let back9: UILabel = {
        let label = UILabel()
        label.layer.cornerRadius = 15
        label.layer.borderColor = UIColor.yellow.cgColor
        label.layer.borderWidth = 1
        label.layer.backgroundColor = UIColor(r: 227, g: 226, b: 191).cgColor
        return label
    }()
    let back10: UILabel = {
        let label = UILabel()
        label.layer.cornerRadius = 15
        label.layer.borderColor = UIColor.yellow.cgColor
        label.layer.borderWidth = 1
        label.layer.backgroundColor = UIColor(r: 227, g: 226, b: 191).cgColor
        return label
    }()
    
    let marketLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textColor = .white
        label.text = "Purchase Coins"
        return label
    }()
    
    let back1: UILabel = {
        let label = UILabel()
        label.layer.cornerRadius = 15
        label.layer.borderColor = UIColor.yellow.cgColor
        label.layer.borderWidth = 1
        label.layer.backgroundColor = UIColor(r: 227, g: 226, b: 191).cgColor
        return label
    }()
    let back2: UILabel = {
        let label = UILabel()
        label.layer.cornerRadius = 15
        label.layer.borderColor = UIColor.yellow.cgColor
        label.layer.borderWidth = 1
        label.layer.backgroundColor = UIColor(r: 227, g: 226, b: 191).cgColor
        return label
    }()
    let back3: UILabel = {
        let label = UILabel()
        label.layer.cornerRadius = 15
        label.layer.borderColor = UIColor.yellow.cgColor
        label.layer.borderWidth = 1
        label.layer.backgroundColor = UIColor(r: 227, g: 226, b: 191).cgColor
        return label
    }()
    let back4: UILabel = {
        let label = UILabel()
        label.layer.cornerRadius = 15
        label.layer.borderColor = UIColor.yellow.cgColor
        label.layer.borderWidth = 1
        label.layer.backgroundColor = UIColor(r: 227, g: 226, b: 191).cgColor
        return label
    }()
    let back5: UILabel = {
        let label = UILabel()
        label.layer.cornerRadius = 15
        label.layer.borderColor = UIColor.yellow.cgColor
        label.layer.borderWidth = 1
        label.layer.backgroundColor = UIColor(r: 227, g: 226, b: 191).cgColor
        return label
    }()
    
    let monthlyLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.text = "Weekly Goals"
        label.textColor = .white
        return label
    }()
    
    let back11: UILabel = {
        let label = UILabel()
        label.layer.cornerRadius = 15
        label.layer.borderColor = UIColor.yellow.cgColor
        label.layer.borderWidth = 1
        label.layer.backgroundColor = UIColor(r: 227, g: 226, b: 191).cgColor
        return label
    }()
    let back12: UILabel = {
        let label = UILabel()
        label.layer.cornerRadius = 15
        label.layer.borderColor = UIColor.yellow.cgColor
        label.layer.borderWidth = 1
        label.layer.backgroundColor = UIColor(r: 227, g: 226, b: 191).cgColor
        return label
    }()
    let back13: UILabel = {
        let label = UILabel()
        label.layer.cornerRadius = 15
        label.layer.borderColor = UIColor.yellow.cgColor
        label.layer.borderWidth = 1
        label.layer.backgroundColor = UIColor(r: 227, g: 226, b: 191).cgColor
        return label
    }()
    let back14: UILabel = {
        let label = UILabel()
        label.layer.cornerRadius = 15
        label.layer.borderColor = UIColor.yellow.cgColor
        label.layer.borderWidth = 1
        label.layer.backgroundColor = UIColor(r: 227, g: 226, b: 191).cgColor
        return label
    }()
    let back15: UILabel = {
        let label = UILabel()
        label.layer.cornerRadius = 15
        label.layer.borderColor = UIColor.yellow.cgColor
        label.layer.borderWidth = 1
        label.layer.backgroundColor = UIColor(r: 227, g: 226, b: 191).cgColor
        return label
    }()

    let button1: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.layer.cornerRadius = 10
        button.layer.backgroundColor = UIColor(r: 140, g: 197, b: 61).cgColor
        button.setTitle("Purchase", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(UIColor.white, for: .normal)
        //button.addTarget(self, action: #selector(RiderPickController.pressed), for: .touchDown)
        return button
    }()
    let button2: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.layer.cornerRadius = 10
        button.layer.backgroundColor = UIColor(r: 140, g: 197, b: 61).cgColor
        button.setTitle("Purchase", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(UIColor.white, for: .normal)
        //button.addTarget(self, action: #selector(RiderPickController.pressed), for: .touchDown)
        return button
    }()
    let button3: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.layer.cornerRadius = 10
        button.layer.backgroundColor = UIColor(r: 140, g: 197, b: 61).cgColor
        button.setTitle("Purchase", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(UIColor.white, for: .normal)
        //button.addTarget(self, action: #selector(RiderPickController.pressed), for: .touchDown)
        return button
    }()
    let button4: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.layer.cornerRadius = 10
        button.layer.backgroundColor = UIColor(r: 140, g: 197, b: 61).cgColor
        button.setTitle("Purchase", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(UIColor.white, for: .normal)
        //button.addTarget(self, action: #selector(RiderPickController.pressed), for: .touchDown)
        return button
    }()
    let button5: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.layer.cornerRadius = 10
        button.layer.backgroundColor = UIColor(r: 140, g: 197, b: 61).cgColor
        button.setTitle("Purchase", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(UIColor.white, for: .normal)
        //button.addTarget(self, action: #selector(RiderPickController.pressed), for: .touchDown)
        return button
    }()
    let price1: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.text = "200 points: $1.99"
        return label
    }()
    let price2: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.text = "500 points: $4.99"
        return label
    }()
    let price3: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.text = "1100 points: $9.99"
        return label
    }()
    let price4: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.text = "2400 points: $19.99"
        return label
    }()
    let price5: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.text = "4000 points: $39.99"
        return label
    }()
    
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(marketLabel)
        addSubview(back1)
        addSubview(back2)
        addSubview(back3)
        addSubview(back4)
        addSubview(back5)
        addSubview(weeklyLabel)
        addSubview(back6)
        addSubview(back7)
        addSubview(back8)
        addSubview(back9)
        addSubview(back10)
        addSubview(monthlyLabel)
        addSubview(back11)
        addSubview(back12)
        addSubview(back13)
        addSubview(back14)
        addSubview(back15)
        addSubview(button1)
        addSubview(button2)
        addSubview(button3)
        addSubview(button4)
        addSubview(button5)
        addSubview(price1)
        addSubview(price2)
        addSubview(price3)
        addSubview(price4)
        addSubview(price5)
        
        marketLabel.anchor(self.topAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, topConstant: 0, leftConstant: 4, bottomConstant: 0, rightConstant: 4, widthConstant: 0, heightConstant: 40)
        back1.anchor(marketLabel.bottomAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, topConstant: 0, leftConstant: 4, bottomConstant: 0, rightConstant: 4, widthConstant: 0, heightConstant: 40)
        button1.anchor(marketLabel.bottomAnchor, left: nil, bottom: nil, right: self.rightAnchor, topConstant: 5, leftConstant: 4, bottomConstant: 0, rightConstant: 16, widthConstant: 70, heightConstant: 30)
        price1.anchor(marketLabel.bottomAnchor, left: self.leftAnchor, bottom: nil, right: nil, topConstant: 5, leftConstant: 4, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 30)
        
        back2.anchor(back1.bottomAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, topConstant: 8, leftConstant: 4, bottomConstant: 0, rightConstant: 4, widthConstant: 0, heightConstant: 40)
        button2.anchor(back1.bottomAnchor, left: nil, bottom: nil, right: self.rightAnchor, topConstant: 13, leftConstant: 4, bottomConstant: 0, rightConstant: 16, widthConstant: 70, heightConstant: 30)
        price2.anchor(back1.bottomAnchor, left: self.leftAnchor, bottom: nil, right: nil, topConstant: 13, leftConstant: 4, bottomConstant: 16, rightConstant: 0, widthConstant: 0, heightConstant: 30)
        
        back3.anchor(back2.bottomAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, topConstant: 8, leftConstant: 4, bottomConstant: 0, rightConstant: 4, widthConstant: 0, heightConstant: 40)
        button3.anchor(back2.bottomAnchor, left: nil, bottom: nil, right: self.rightAnchor, topConstant: 13, leftConstant: 4, bottomConstant: 0, rightConstant: 16, widthConstant: 70, heightConstant: 30)
        price3.anchor(back2.bottomAnchor, left: self.leftAnchor, bottom: nil, right: nil, topConstant: 13, leftConstant: 4, bottomConstant: 16, rightConstant: 0, widthConstant: 0, heightConstant: 30)
        
        back4.anchor(back3.bottomAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, topConstant: 8, leftConstant: 4, bottomConstant: 0, rightConstant: 4, widthConstant: 0, heightConstant: 40)
        button4.anchor(back3.bottomAnchor, left: nil, bottom: nil, right: self.rightAnchor, topConstant: 13, leftConstant: 4, bottomConstant: 0, rightConstant: 16, widthConstant: 70, heightConstant: 30)
        price4.anchor(back3.bottomAnchor, left: self.leftAnchor, bottom: nil, right: nil, topConstant: 13, leftConstant: 4, bottomConstant: 16, rightConstant: 0, widthConstant: 0, heightConstant: 30)
        
        back5.anchor(back4.bottomAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, topConstant: 8, leftConstant: 4, bottomConstant: 0, rightConstant: 4, widthConstant: 0, heightConstant: 40)
        button5.anchor(back4.bottomAnchor, left: nil, bottom: nil, right: self.rightAnchor, topConstant: 13, leftConstant: 4, bottomConstant: 0, rightConstant: 16, widthConstant: 70, heightConstant: 30)
        price5.anchor(back4.bottomAnchor, left: self.leftAnchor, bottom: nil, right: nil, topConstant: 13, leftConstant: 4, bottomConstant: 16, rightConstant: 0, widthConstant: 0, heightConstant: 30)
        
        weeklyLabel.anchor(back5.bottomAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, topConstant: 0, leftConstant: 4, bottomConstant: 0, rightConstant: 4, widthConstant: 0, heightConstant: 40)
        back6.anchor(weeklyLabel.bottomAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, topConstant: 0, leftConstant: 4, bottomConstant: 0, rightConstant: 4, widthConstant: 0, heightConstant: 40)
        back7.anchor(back6.bottomAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, topConstant: 8, leftConstant: 4, bottomConstant: 0, rightConstant: 4, widthConstant: 0, heightConstant: 40)
        back8.anchor(back7.bottomAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, topConstant: 8, leftConstant: 4, bottomConstant: 0, rightConstant: 4, widthConstant: 0, heightConstant: 40)
        back9.anchor(back8.bottomAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, topConstant: 8, leftConstant: 4, bottomConstant: 0, rightConstant: 4, widthConstant: 0, heightConstant: 40)
        back10.anchor(back9.bottomAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, topConstant: 8, leftConstant: 4, bottomConstant: 0, rightConstant: 4, widthConstant: 0, heightConstant: 40)
        
        monthlyLabel.anchor(back10.bottomAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, topConstant: 0, leftConstant: 4, bottomConstant: 0, rightConstant: 4, widthConstant: 0, heightConstant: 40)
        back11.anchor(monthlyLabel.bottomAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, topConstant: 0, leftConstant: 4, bottomConstant: 0, rightConstant: 4, widthConstant: 0, heightConstant: 40)
        back12.anchor(back11.bottomAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, topConstant: 8, leftConstant: 4, bottomConstant: 0, rightConstant: 4, widthConstant: 0, heightConstant: 40)
        back13.anchor(back12.bottomAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, topConstant: 8, leftConstant: 4, bottomConstant: 0, rightConstant: 4, widthConstant: 0, heightConstant: 40)
        back14.anchor(back13.bottomAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, topConstant: 8, leftConstant: 4, bottomConstant: 0, rightConstant: 4, widthConstant: 0, heightConstant: 40)
        back15.anchor(back14.bottomAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, topConstant: 8, leftConstant: 4, bottomConstant: 0, rightConstant: 4, widthConstant: 0, heightConstant: 40)
    }
}

class RSDataSource: Datasource {
    
    let words = ["user1"]
    
    override func footerClasses() -> [DatasourceCell.Type]? {
        return [RSFooter.self]
    }
    
    override func headerClasses() -> [DatasourceCell.Type]? {
        return [RSHeader.self]
    }
    
    override func cellClasses() -> [DatasourceCell.Type] {
        return [RSCell.self]
    }
    
    override func item(_ indexPath: IndexPath) -> Any? {
        return words[indexPath.item]
    }
    
    override func numberOfItems(_ section: Int) -> Int {
        return words.count
    }
    
}

class MarketViewController: DatasourceController {
    
    
    var paused: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        collectionView?.backgroundColor = UIColor(r: 0, g: 71, b: 17)
        let homeDatasource = RSDataSource()
        self.datasource = homeDatasource
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
        collectionView?.backgroundColor = UIColor(r: 0, g: 71, b: 17)
        let homeDatasource = RSDataSource()
        self.datasource = homeDatasource
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    
    func loadDone() {
        print("load Success")
    }
    
    /*
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Repeat the video at the end
    func playerItemDidReachEnd(notification: Notification) {
        let p: AVPlayerItem = notification.object as! AVPlayerItem
        p.seek(to: kCMTimeZero)
    }*/    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 816)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 0)
    }
}
