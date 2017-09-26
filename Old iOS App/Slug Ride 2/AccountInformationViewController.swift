//
//  AccountInformatioinViewController.swift
//  Slug Ride 2
//
//  Created by Andrew dato on 7/6/17.
//  Copyright © 2017 Andrew Dat0. All rights reserved.
//


import LBTAComponents
import Foundation

struct accountInfo {
    let car_capacity: Int;
    let car_color: String;
    let driver_rating: Double;
    let rider_rating: Double;
    let rides_given: Int;
    let rides_taken: Int;
    let user_car: String;
    let user_email: String;
    let user_name: String;
    let driver_approval: Bool;
}

class AIFooter: DatasourceCell {
    override func setupViews() {
        super.setupViews()
        backgroundColor = .red
    }
}

class AIHeader: DatasourceCell {
    override func setupViews() {
        super.setupViews()
        backgroundColor = .red
    }
}

class AICell: DatasourceCell {
    
    override var datasourceItem: Any? {
        didSet {
            guard let user = datasourceItem  as? accountInfo else {return}
            nameLabel.text = "Name: " + user.user_name
            emailLabel.text = "Email: " + user.user_email
            if user.driver_approval == true {
                approvalLabel.text = "Driver Approval: Approved"
            } else {
                approvalLabel.text = "Driver Approval: Pending"
            }
            if (user.rider_rating == 6) {
                riderateLabel.text = "Rider Rating: Unavailable"
            } else {
                riderateLabel.text = "Rider Rating: \(user.rider_rating)"
            }
            if (user.driver_rating == 6) {
                driverateLabel.text = "Driver Rating: Unavailable"
            } else {
                driverateLabel.text = "Driver Rating: \(user.rider_rating)"
            }
            drivecountLabel.text = "Drive Count: \(user.rides_given)"
            ridecountLabel.text = "Ride Count: \(user.rides_taken)"
            colorLabel.text = "Car Color: \(user.car_color)"
            capacityLabel.text = "Car Capacity: \(user.car_capacity)"
            carLabel.text = "Car Model: " + user.user_car
        }
    }
    
    let userLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.text = "Account Information"
        label.textColor = .white
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
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        return label
    }()
    
    let emailLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        return label
    }()
    
    let button1: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.layer.cornerRadius = 10
        button.layer.backgroundColor = UIColor(r: 140, g: 197, b: 61).cgColor
        button.setTitle("Edit Account Information", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(UIColor.white, for: .normal)
        button.addTarget(self, action: #selector(AccountInformationViewController.info), for: .touchDown)
        return button
    }()
    
    let statLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.text = "User Statistics"
        label.textColor = .white
        return label
    }()
    
    let riderateLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        return label
    }()
    
    let driverateLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        return label
    }()
    
    let ridecountLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        return label
    }()
    
    let drivecountLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
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
    
    let button2: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.layer.cornerRadius = 10
        button.layer.backgroundColor = UIColor(r: 140, g: 197, b: 61).cgColor
        button.setTitle("Edit Driver Information", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(UIColor.white, for: .normal)
        button.addTarget(self, action: #selector(AccountInformationViewController.driveinfo), for: .touchDown)
        return button
    }()
    
    let driverLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.text = "Driver Information"
        label.textColor = .white
        return label
    }()
    
    let capacityLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        return label
    }()
    
    let colorLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        return label
    }()
    
    let carLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        return label
    }()
    
    let approvalLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
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
    
    let button3: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.layer.cornerRadius = 10
        button.layer.backgroundColor = UIColor(r: 140, g: 197, b: 61).cgColor
        button.setTitle("Log Out", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(UIColor.white, for: .normal)
        button.addTarget(self, action: #selector(AccountInformationViewController.logout), for: .touchDown)
        return button
    }()
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(userLabel)
        addSubview(statLabel)
        addSubview(driverLabel)
        addSubview(back1)
        addSubview(back2)
        addSubview(back3)
        addSubview(button1)
        addSubview(button2)
        addSubview(button3)
        addSubview(nameLabel)
        addSubview(emailLabel)
        addSubview(driverateLabel)
        addSubview(riderateLabel)
        addSubview(drivecountLabel)
        addSubview(ridecountLabel)
        addSubview(carLabel)
        addSubview(colorLabel)
        addSubview(capacityLabel)
        addSubview(approvalLabel)

        print("check1")
        userLabel.anchor(self.topAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, topConstant: 0, leftConstant: 4, bottomConstant: 0, rightConstant: 4, widthConstant: 0, heightConstant: 40)
        back1.anchor(userLabel.bottomAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, topConstant: 0, leftConstant: 4, bottomConstant: 0, rightConstant: 4, widthConstant: 0, heightConstant: 70)
        nameLabel.anchor(userLabel.bottomAnchor, left: self.leftAnchor, bottom: nil, right: nil, topConstant: 5, leftConstant: 6, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 30)
        emailLabel.anchor(nameLabel.bottomAnchor, left: self.leftAnchor, bottom: nil, right: nil, topConstant: 5, leftConstant: 6, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 30)
        button1.anchor(back1.bottomAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, topConstant: 5, leftConstant: 16, bottomConstant: 0, rightConstant: 16, widthConstant: 70, heightConstant: 30)
        print("check2")
        
        statLabel.anchor(button1.bottomAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, topConstant: 0, leftConstant: 4, bottomConstant: 0, rightConstant: 4, widthConstant: 0, heightConstant: 40)
        print("check11")
        back2.anchor(statLabel.bottomAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, topConstant: 0, leftConstant: 4, bottomConstant: 0, rightConstant: 4, widthConstant: 0, heightConstant: 140)
        print("check12")

        driverateLabel.anchor(statLabel.bottomAnchor, left: self.leftAnchor, bottom: nil, right: nil, topConstant: 5, leftConstant: 6, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 30)
        print("check13")
        drivecountLabel.anchor(driverateLabel.bottomAnchor, left: self.leftAnchor, bottom: nil, right: nil, topConstant: 5, leftConstant: 6, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 30)
        print("check14")
        riderateLabel.anchor(drivecountLabel.bottomAnchor, left: self.leftAnchor, bottom: nil, right: nil, topConstant: 5, leftConstant: 6, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 30)
        print("check15")
        ridecountLabel.anchor(riderateLabel.bottomAnchor, left: self.leftAnchor, bottom: nil, right: nil, topConstant: 5, leftConstant: 6, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 30)
        
        print("check3")
        driverLabel.anchor(back2.bottomAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, topConstant: 0, leftConstant: 4, bottomConstant: 0, rightConstant: 4, widthConstant: 0, heightConstant: 40)
        back3.anchor(driverLabel.bottomAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, topConstant: 0, leftConstant: 4, bottomConstant: 0, rightConstant: 4, widthConstant: 0, heightConstant: 140)
        
        print("check5")
        carLabel.anchor(driverLabel.bottomAnchor, left: self.leftAnchor, bottom: nil, right: nil, topConstant: 5, leftConstant: 6, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 30)
        print("check6")
        colorLabel.anchor(carLabel.bottomAnchor, left: self.leftAnchor, bottom: nil, right: nil, topConstant: 5, leftConstant: 6, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 30)
        print("check7")
        capacityLabel.anchor(colorLabel.bottomAnchor, left: self.leftAnchor, bottom: nil, right: nil, topConstant: 5, leftConstant: 6, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 30)
        print("check8")
        approvalLabel.anchor(capacityLabel.bottomAnchor, left: self.leftAnchor, bottom: nil, right: nil, topConstant: 5, leftConstant: 6, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 30)

        print("check4")
        button2.anchor(back3.bottomAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, topConstant: 5, leftConstant: 16, bottomConstant: 0, rightConstant: 16, widthConstant: 70, heightConstant: 30)
        button3.anchor(button2.bottomAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, topConstant: 5, leftConstant: 16, bottomConstant: 0, rightConstant: 16, widthConstant: 70, heightConstant: 30)
        

    }
}

class AIDataSource: Datasource {
    
    let words = ["user1"]
    
    override func footerClasses() -> [DatasourceCell.Type]? {
        return [AIFooter.self]
    }
    
    override func headerClasses() -> [DatasourceCell.Type]? {
        return [AIHeader.self]
    }
    
    override func cellClasses() -> [DatasourceCell.Type] {
        return [AICell.self]
    }
    
    override func item(_ indexPath: IndexPath) -> Any? {
        return AI[indexPath.item]
    }
    
    override func numberOfItems(_ section: Int) -> Int {
        return AI.count
    }
    
}

var AI = [accountInfo]()

class AccountInformationViewController: DatasourceController {
    
    
    var paused: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        collectionView?.backgroundColor = UIColor(r: 0, g: 71, b: 17)
        let homeDatasource = AIDataSource()
        self.datasource = homeDatasource
        getDriver()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
        collectionView?.backgroundColor = UIColor(r: 0, g: 71, b: 17)
        let homeDatasource = AIDataSource()
        self.datasource = homeDatasource
        getDriver()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    
    func loadDone() {
        print("load Success")
    }
    
    func getDriver () {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let dict = ["user_email":appDelegate.user_email] as [String: Any]
        //let dict = ["user_email":appDelegate.user_email, "first_name":"Test", "last_name":"Test", "user_car":"Test", "car_color":"Test", "car_capacity":5] as [String: Any]
        print(dict)
        if let jsonData = try? JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted){
            print("success")
            let url = NSURL(string: "http://138.68.252.198:8000/rideshare/account_info/")!
            let request = NSMutableURLRequest(url: url as URL)
            request.httpMethod = "POST"
            request.setValue("Token \(appDelegate.token)", forHTTPHeaderField: "Authorization")
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = jsonData
            
            let task = URLSession.shared.dataTask(with: request as URLRequest){
                data, response, error in
                if let httpResponse = response as? HTTPURLResponse{
                    print(httpResponse.statusCode)
                    if(httpResponse.statusCode != 200){
                        print("error")
                        return
                    }
                }
                print("success1")
                guard error == nil else{
                    print(error!)
                    return
                }
                print("success2")
                guard let data = data else {
                    print("Data Empty")
                    return
                }
                print("success3")
                let json = try! JSONSerialization.jsonObject(with: data, options: []) as AnyObject
                print(json)
                var tempColor: String
                if (json["car_color"] as? String) != nil {
                    tempColor = (json["car_color"] as? String)!
                } else {
                    tempColor = "None"
                }
                var tempCar: String
                if (json["car_color"] as? String) != nil {
                    tempCar = (json["car_color"] as? String)!
                } else {
                    tempCar = "None"
                }

                AI.removeAll()
                let temp = accountInfo(car_capacity: (json["car_capacity"] as? Int)!,
                                       car_color: tempColor,
                                       driver_rating: (json["driver_rating"] as? Double)!,
                                       rider_rating: (json["rider_rating"] as? Double)!,
                                       rides_given: (json["rides_given"] as? Int)!,
                                       rides_taken: (json["rides_taken"] as? Int)!,
                                       user_car: tempCar,
                                       user_email: "\(appDelegate.user_email)",
                                        user_name: "\(appDelegate.user_firstname) \(appDelegate.user_lastname)",
                                       driver_approval: appDelegate.driver_approval)
                AI.append(temp)
            }
            task.resume()
        }
    }


    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 580)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 0)
    }
    
    //Button Function
    func info(button: UIButton) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "EditViewController") as! EditViewController
        self.present(newViewController, animated: true, completion: nil)
    }
    
    func driveinfo(button: UIButton) {

        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "EditInformationViewController") as! EditInformationViewController
        self.present(newViewController, animated: true, completion: nil)
    }
    
    func logout(button: UIButton) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "StartViewController") as! StartViewController
        self.present(newViewController, animated: true, completion: nil)
    }
    
    
}
