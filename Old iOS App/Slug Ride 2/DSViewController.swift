//
//  TestController.swift
//  Slug Ride 2
//
//  Created by Andrew dato on 5/23/17.
//  Copyright © 2017 Andrew Dat0. All rights reserved.
//

import LBTAComponents
import Foundation

struct DriverSC {
    let rider_count : Int;
    let driver_departure_longitude: Double;
    let driver_departure_latitude: Double;
    let driver_destination_longitude: Double;
    let driver_destination_latitude: Double;
    let driver_timeofdeparture_hour: Int;
    let driver_timeofdeparture_minute: Int
    let monday : Bool;
    let tuesday : Bool;
    let wednesday : Bool;
    let thursday : Bool;
    let friday : Bool;
    let saturday : Bool;
    let sunday : Bool;
    let trip_id : Int;
    let driver_departure : String;
    let driver_destination: String;
}

class DSFooter: DatasourceCell {
    override func setupViews() {
        super.setupViews()
        backgroundColor = .red
    }
}

class DSHeader: DatasourceCell {
    override func setupViews() {
        super.setupViews()
        backgroundColor = .red
    }
}

class DSCell: DatasourceCell {
    
    override var datasourceItem: Any? {
        didSet {
            guard let user = datasourceItem  as? DriverSC else {return}
            //nameLabel.text = "Ride Count: \(user.rider_count)"
            timeLabel.text = "Time: \(user.driver_timeofdeparture_hour):\(user.driver_timeofdeparture_minute)"
            locationView.text = user.driver_departure
            destinationView.text = user.driver_destination
            if user.monday == true {
                mondayX.text = "X"
                mondayX.textAlignment = .center
            }
            if user.tuesday  == true {
                tuesdayX.text = "X"
                tuesdayX.textAlignment = .center
            }
            if user.wednesday  == true {
                wednesdayX.text = "X"
                wednesdayX.textAlignment = .center
            }
            if user.thursday  == true {
                thursdayX.text = "X"
                thursdayX.textAlignment = .center
            }
            if user.friday  == true {
                fridayX.text = "X"
                fridayX.textAlignment = .center
            }
            if user.saturday  == true {
                saturdayX.text = "X"
                saturdayX.textAlignment = .center
            }
            if user.sunday  == false {
                sundayX.text = "X"
                sundayX.textAlignment = .center
            }
            followButton.tag = user.trip_id
            
        }
    }
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        return label
    }()
    
    let timeLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        return label
    }()
    
    let locationView: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.text = "Location: UCSC"
        return label
    }()
    
    let destinationView: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.text = "Destination: Pacific Avenue"
        return label
    }()
    
    let followButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.layer.cornerRadius = 10
        button.layer.backgroundColor = UIColor(r: 0, g: 107, b: 255).cgColor
        button.setTitle("Details", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(UIColor.white, for: .normal)
        button.addTarget(self, action: #selector(DSViewController.pressed), for: .touchDown)
        return button
    }()
    
    let monday: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.text = "Mon"
        label.textAlignment = .center
        return label
    }()
    
    let mondayX: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        return label
    }()
    
    let tuesday: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.text = "Tue"
        label.textAlignment = .center
        return label
    }()
    
    let tuesdayX: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.text = "X"
        label.textAlignment = .center
        return label
    }()
    
    let wednesday: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.text = "Wed"
        label.textAlignment = .center
        return label
    }()
    
    let wednesdayX: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        return label
    }()
    
    let thursday: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.text = "Thu"
        label.textAlignment = .center
        return label
    }()
    
    let thursdayX: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.text = "X"
        label.textAlignment = .center
        return label
    }()
    
    let friday: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.text = "Fri"
        label.textAlignment = .center
        return label
    }()
    
    let fridayX: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        return label
    }()
    
    let saturday: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.text = "Sat"
        label.textAlignment = .center
        return label
    }()
    
    let saturdayX: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        return label
    }()
    
    let sunday: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.text = "Sun"
        label.textAlignment = .center
        return label
    }()
    
    let sundayX: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        return label
    }()
    
    let back: UILabel = {
        let label = UILabel()
        label.layer.cornerRadius = 15
        label.layer.borderColor = UIColor.yellow.cgColor
        label.layer.borderWidth = 1
        label.layer.backgroundColor = UIColor.white.cgColor
        return label
    }()
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(back)
        addSubview(nameLabel)
        addSubview(timeLabel)
        addSubview(locationView)
        addSubview(destinationView)
        addSubview(followButton)
        addSubview(monday)
        addSubview(mondayX)
        addSubview(tuesday)
        addSubview(tuesdayX)
        addSubview(thursday)
        addSubview(thursdayX)
        addSubview(wednesday)
        addSubview(wednesdayX)
        addSubview(friday)
        addSubview(fridayX)
        addSubview(saturday)
        addSubview(saturdayX)
        addSubview(sunday)
        addSubview(sundayX)
        
        
        back.anchor(self.topAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, topConstant: 0, leftConstant: 4, bottomConstant: 0, rightConstant: 4, widthConstant: 0, heightConstant: 0)
        
        //nameLabel.anchor(self.topAnchor, left: self.leftAnchor, bottom: nil, right: followButton.leftAnchor, topConstant: 4, leftConstant: 8, bottomConstant: 0, rightConstant: 12, widthConstant: 0, heightConstant: 20)
        
        timeLabel.anchor(self.topAnchor, left: self.leftAnchor, bottom: nil, right: followButton.leftAnchor, topConstant: 4, leftConstant: 8, bottomConstant: 0, rightConstant: 12, widthConstant: 0, heightConstant: 20)
        
        followButton.anchor(topAnchor, left: nil, bottom: nil, right: self.rightAnchor, topConstant: 8, leftConstant: 0, bottomConstant: 0, rightConstant: 12, widthConstant: 120, heightConstant: 40)
        
        locationView.anchor(timeLabel.bottomAnchor, left: timeLabel.leftAnchor, bottom: nil, right: self.rightAnchor, topConstant: 8, leftConstant: 0, bottomConstant: 0, rightConstant: 12, widthConstant: 0, heightConstant: 20)
        
        destinationView.anchor(locationView.bottomAnchor, left: locationView.leftAnchor, bottom: nil, right: self.rightAnchor, topConstant: 8, leftConstant: 0, bottomConstant: 0, rightConstant: 12, widthConstant: 0, heightConstant: 20)
        
        monday.anchor(destinationView.bottomAnchor, left: self.leftAnchor, bottom: nil, right: nil, topConstant: 8, leftConstant: 8, bottomConstant: 0, rightConstant: 0, widthConstant: (CGFloat((wid-36)/7)), heightConstant: 20)
        
        mondayX.anchor(monday.bottomAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: nil, topConstant: 2, leftConstant: 8, bottomConstant: 4, rightConstant: 0, widthConstant: (CGFloat((wid-36)/7)), heightConstant: 0)
        
        tuesday.anchor(destinationView.bottomAnchor, left: monday.rightAnchor, bottom: nil, right: nil, topConstant: 8, leftConstant: 3, bottomConstant: 0, rightConstant: 0, widthConstant: (CGFloat((wid-36)/7)), heightConstant: 20)
        
        tuesdayX.anchor(tuesday.bottomAnchor, left: mondayX.rightAnchor, bottom: self.bottomAnchor, right: nil, topConstant: 2, leftConstant: 3, bottomConstant: 4, rightConstant: 0, widthConstant: (CGFloat((wid-36)/7)), heightConstant: 0)
        
        wednesday.anchor(destinationView.bottomAnchor, left: tuesday.rightAnchor, bottom: nil, right: nil, topConstant: 8, leftConstant: 3, bottomConstant: 0, rightConstant: 0, widthConstant: (CGFloat((wid-36)/7)), heightConstant: 20)
        
        wednesdayX.anchor(wednesday.bottomAnchor, left: tuesdayX.rightAnchor, bottom: self.bottomAnchor, right: nil, topConstant: 2, leftConstant: 3, bottomConstant: 4, rightConstant: 0, widthConstant: (CGFloat((wid-36)/7)), heightConstant: 0)
        
        thursday.anchor(destinationView.bottomAnchor, left: wednesday.rightAnchor, bottom: nil, right: nil, topConstant: 8, leftConstant: 3, bottomConstant: 0, rightConstant: 0, widthConstant: (CGFloat((wid-36)/7)), heightConstant: 20)
        
        thursdayX.anchor(thursday.bottomAnchor, left: wednesdayX.rightAnchor, bottom: self.bottomAnchor, right: nil, topConstant: 2, leftConstant: 3, bottomConstant: 4, rightConstant: 0, widthConstant: (CGFloat((wid-36)/7)), heightConstant: 0)
        
        friday.anchor(destinationView.bottomAnchor, left: thursday.rightAnchor, bottom: nil, right: nil, topConstant: 8, leftConstant: 3, bottomConstant: 0, rightConstant: 0, widthConstant: (CGFloat((wid-36)/7)), heightConstant: 20)
        
        fridayX.anchor(friday.bottomAnchor, left: thursdayX.rightAnchor, bottom: self.bottomAnchor, right: nil, topConstant: 2, leftConstant: 3, bottomConstant: 4, rightConstant: 0, widthConstant: (CGFloat((wid-36)/7)), heightConstant: 0)
        
        saturday.anchor(destinationView.bottomAnchor, left: friday.rightAnchor, bottom: nil, right: nil, topConstant: 8, leftConstant: 3, bottomConstant: 0, rightConstant: 12, widthConstant: (CGFloat((wid-36)/7)), heightConstant: 20)
        
        saturdayX.anchor(saturday.bottomAnchor, left: fridayX.rightAnchor, bottom: self.bottomAnchor, right: nil, topConstant: 2, leftConstant: 3, bottomConstant: 4, rightConstant: 12, widthConstant: (CGFloat((wid-36)/7)), heightConstant: 0)
        
        sunday.anchor(destinationView.bottomAnchor, left: saturday.rightAnchor, bottom: nil, right: self.rightAnchor, topConstant: 8, leftConstant: 3, bottomConstant: 0, rightConstant: 12, widthConstant: (CGFloat((wid-36)/7)), heightConstant: 20)
        
        sundayX.anchor(sunday.bottomAnchor, left: saturdayX.rightAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, topConstant: 2, leftConstant: 3, bottomConstant: 4, rightConstant: 12, widthConstant: (CGFloat((wid-36)/7)), heightConstant: 0)
    }
}

class DSDataSource: Datasource {
    
    let words = ["user1", "user2", "user3"]
    
    override func footerClasses() -> [DatasourceCell.Type]? {
        return [DSFooter.self]
    }
    
    override func headerClasses() -> [DatasourceCell.Type]? {
        return [DSHeader.self]
    }
    
    override func cellClasses() -> [DatasourceCell.Type] {
        return [DSCell.self]
    }
    
    override func item(_ indexPath: IndexPath) -> Any? {
        return usersSC[indexPath.item]
    }
    
    override func numberOfItems(_ section: Int) -> Int {
        return usersSC.count
    }
    
}

var usersSC = [DriverSC]()

class DSViewController: DatasourceController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        wid = Int(view.frame.width)
        collectionView?.backgroundColor = UIColor(r: 0, g: 107, b: 255)
        let homeDatasource = DSDataSource()
        self.datasource = homeDatasource
        print("success")
        getDriver()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
        wid = Int(view.frame.width)
        collectionView?.backgroundColor = UIColor(r: 0, g: 107, b: 255)
        let homeDatasource = DSDataSource()
        self.datasource = homeDatasource
        print("success")
        getDriver()
    }
    
    func getDriver () {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let dict = ["email":appDelegate.user_email] as [String: Any]
        print(dict)
        if let jsonData = try? JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted) {
            
            print("success")
            let url = NSURL(string: "http://138.68.252.198:8000/rideshare/get_driver_planned_trips/")!
            let request = NSMutableURLRequest(url: url as URL)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = jsonData
            
            
            let task = URLSession.shared.dataTask(with: request as URLRequest) { data, response, error in
                if let httpResponse = response as? HTTPURLResponse {
                    print(httpResponse.statusCode)
                    if(httpResponse.statusCode != 201) {
                        print("error")
                        return
                    }
                }
                guard error == nil else {
                    print(error!)
                    return
                }
                guard let data = data else {
                    print("Data is empty")
                    return
                }
                let json = try! JSONSerialization.jsonObject(with: data, options: []) as AnyObject
                print(json)
                let arrJson = json
                print(arrJson)
                
                usersSC.removeAll()
                let userss = arrJson as? [[String: Any]]
                for user in userss! {
                    let newRide = DriverSC (rider_count : 0,
                                         driver_departure_longitude: (user["driver_departure_longitude"] as? Double)!,
                                         driver_departure_latitude: (user["driver_departure_latitude"] as? Double)!,
                                         driver_destination_longitude: (user["driver_destination_longitude"] as? Double)!,
                                         driver_destination_latitude: (user["driver_destination_latitude"] as? Double)!,
                                         driver_timeofdeparture_hour: (user["driver_timeofdeparture_hour"] as? Int)!,
                                         driver_timeofdeparture_minute: (user["driver_timeofdeparture_minute"] as? Int)!,
                                         monday: (user["monday"] as? Bool)!,
                                         tuesday: (user["tuesday"] as? Bool)!,
                                         wednesday: (user["wednesday"] as? Bool)!,
                                         thursday: (user["thursday"] as? Bool)! ,
                                         friday: (user["friday"] as? Bool)!,
                                         saturday: (user["saturday"] as? Bool)! ,
                                         sunday: (user["sunday"] as? Bool)!,
                                         trip_id: (user["trip_id"] as? Int)!,
                                         driver_departure: (user["driver_departure"] as? String)!,
                                         driver_destination: (user["driver_destination"] as? String)!)
                    usersSC.append(newRide)
                }
                print(usersSC)
                //let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                //let newViewController = storyBoard.instantiateViewController(withIdentifier: "MenuViewController") as! MenuViewController
                //self.present(newViewController, animated: true, completion: nil)
            }
            
            task.resume()
            
        }
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    
    func loadDone() {
        print("load Success")
    }
    
    func pressed(button: UIButton) {
        print(button.tag)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.rd_tripid = button.tag
        let newViewController = DSDViewController()
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 0)
    }
}
