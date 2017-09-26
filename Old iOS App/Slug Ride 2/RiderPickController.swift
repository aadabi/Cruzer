//
//  TestController.swift
//  Slug Ride 2
//
//  Created by Andrew dato on 5/23/17.
//  Copyright © 2017 Andrew Dat0. All rights reserved.
//

import LBTAComponents
import Foundation
import CoreLocation

/////////////////////////////////////////
//Driver JSON object
/////////////////////////////////////////
struct driver {
    let first_name : String;
    let last_name : String;
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

/////////////////////////////////////////
//View
/////////////////////////////////////////

class UserFooter: DatasourceCell {
    override func setupViews() {
        super.setupViews()
        backgroundColor = .green
    }
}

class UserHeader: DatasourceCell {
    override func setupViews() {
        super.setupViews()
        backgroundColor = .blue
    }
}

class UserCell: DatasourceCell {

    override var datasourceItem: Any? {
        didSet {
            guard let user = datasourceItem  as? driver else {return}
            nameLabel.text = user.first_name + " " + user.last_name
            if (user.driver_timeofdeparture_minute > 0) {
                timeLabel.text = "Time: \(user.driver_timeofdeparture_hour):\(user.driver_timeofdeparture_minute)"
            } else {
                timeLabel.text = "Time: \(user.driver_timeofdeparture_hour):00"
            }
            
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
        button.setTitle("Join", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(UIColor.white, for: .normal)
        button.addTarget(self, action: #selector(RiderPickController.pressed), for: .touchDown)
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
        
        nameLabel.anchor(self.topAnchor, left: self.leftAnchor, bottom: nil, right: followButton.leftAnchor, topConstant: 4, leftConstant: 8, bottomConstant: 0, rightConstant: 12, widthConstant: 0, heightConstant: 20)
        
        timeLabel.anchor(nameLabel.bottomAnchor, left: nameLabel.leftAnchor, bottom: nil, right: nameLabel.rightAnchor, topConstant: 8, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 20)
        
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

/////////////////////////////////////////
//Model
/////////////////////////////////////////

class RiderPickDataSource: Datasource {
    
    let words = ["user1", "user2", "user3"]
    
    override func footerClasses() -> [DatasourceCell.Type]? {
        return [UserFooter.self]
    }
    
    override func headerClasses() -> [DatasourceCell.Type]? {
        return [UserHeader.self]
    }
    
    override func cellClasses() -> [DatasourceCell.Type] {
        return [UserCell.self]
    }
    
    override func item(_ indexPath: IndexPath) -> Any? {
        return users[indexPath.item]
    }
    
    override func numberOfItems(_ section: Int) -> Int {
        return users.count
    }
    
}

var wid = 0
var users = [driver]()

/////////////////////////////////////////
//Controller
/////////////////////////////////////////

class RiderPickController: DatasourceController {
    

    /////////////////////////////////////////
    //Viewq Functions
    /////////////////////////////////////////
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
        wid = Int(view.frame.width)
        collectionView?.backgroundColor = UIColor(r: 0, g: 107, b: 255)
        let homeDatasource = RiderPickDataSource()
        self.datasource = homeDatasource
        print("success")
        getDriver()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        wid = Int(view.frame.width)
        collectionView?.backgroundColor = UIColor(r: 0, g: 107, b: 255)
        let homeDatasource = RiderPickDataSource()
        self.datasource = homeDatasource
        print("success")
        getDriver()
    }
    
    /////////////////////////////////////////
    //GET Function
    /////////////////////////////////////////
    func getDriver () {
        let url = NSURL(string: "http://138.68.252.198:8000/rideshare/get_all_planned_trips/")!
        let request = NSMutableURLRequest(url: url as URL)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
        
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
            
            
            
            users.removeAll()
            let userss = arrJson as? [[String: Any]]
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            for user in userss! {
                //Make the JSON object
                if (appDelegate.rider_dayChecker[0] == user["monday"] as? Bool && appDelegate.rider_dayChecker[0] == true) ||
                    (appDelegate.rider_dayChecker[1] == user["tuesday"] as? Bool && appDelegate.rider_dayChecker[1] == true) ||
                    (appDelegate.rider_dayChecker[2] == user["wednesday"] as? Bool && appDelegate.rider_dayChecker[2] == true) ||
                    (appDelegate.rider_dayChecker[3] == user["thursday"] as? Bool && appDelegate.rider_dayChecker[3] == true) ||
                    (appDelegate.rider_dayChecker[4] == user["friday"] as? Bool && appDelegate.rider_dayChecker[4] == true) ||
                    (appDelegate.rider_dayChecker[5] == user["saturday"] as? Bool && appDelegate.rider_dayChecker[5] == true) ||
                    (appDelegate.rider_dayChecker[6] == user["sunday"] as? Bool && appDelegate.rider_dayChecker[6] == true) {
                    
                    let riderStart = CLLocation(latitude: appDelegate.rider_cords[1], longitude: appDelegate.rider_cords[0])
                    let driverStart = CLLocation(latitude: (user["driver_departure_latitude"] as? Double)!, longitude: (user["driver_departure_longitude"] as? Double)!)
                    print(riderStart)
                    print(driverStart)
                    print (riderStart.distance(from: driverStart))
                    
                    if (riderStart.distance(from: driverStart) <= (2*1609) && (user["driver_departure_latitude"] as? Double)! != 989898.0 && (user["driver_departure_latitude"] as? Double)! != 147.0) {
                        
                        let riderLoc = CLLocation(latitude: appDelegate.rider_cords[3], longitude: appDelegate.rider_cords[2])
                        let driverLoc = CLLocation(latitude: (user["driver_destination_latitude"] as? Double)!, longitude: (user["driver_destination_longitude"] as? Double)!)
                        print(riderLoc)
                        print(driverLoc)
                        print (riderLoc.distance(from: driverLoc))

                        //Check the JSON object 
                        
                        if (riderLoc.distance(from: driverLoc) <= (2*1609) && (user["driver_departure_latitude"] as? Double)! != 878787.0 && (user["driver_departure_latitude"] as? Double)! != 147.0) {
                            let newRide = driver(first_name: (user["first_name"] as? String)!,
                                         last_name: (user["last_name"] as? String)!,
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
                    
                            print(newRide)
                            users.append(newRide)
                        }
                    }
                }
            }
            print(users)
            DispatchQueue.main.async(execute: self.loadDone)
            
            
            //let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            //let newViewController = storyBoard.instantiateViewController(withIdentifier: "MenuViewController") as! MenuViewController
            //self.present(newViewController, animated: true, completion: nil)
        }
        
        task.resume()
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    
    func loadDone() {
        print("load Success")
    }
    
    
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 178)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 0)
    }
    
    /////////////////////////////////////////
    //Function for button pressed
    /////////////////////////////////////////
    func pressed(button: UIButton) {
        print(button.tag)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let dict = ["email":appDelegate.user_email, "trip_id":button.tag] as [String: Any]
        print(dict)
        if let jsonData = try? JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted) {
            
            print("success")
            let url = NSURL(string: "http://138.68.252.198:8000/rideshare/ride_join_trip/")!
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
                button.isEnabled = false
                button.setTitle("Joined!",for: .normal)
                //let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                //let newViewController = storyBoard.instantiateViewController(withIdentifier: "MenuViewController") as! MenuViewController
                //self.present(newViewController, animated: true, completion: nil)
            }
            task.resume()
        }
    }
}
