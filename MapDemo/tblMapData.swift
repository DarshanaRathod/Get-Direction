//
//  tblMapData.swift
//  MapDemo
//
//  Created by Mac_01 on 07/10/19.
//  Copyright © 2019 Stegowl. All rights reserved.
//

import UIKit
import GoogleMaps
import CoreLocation
import GooglePlaces
import UIKit
import Alamofire
import SwiftyJSON


class cellData: UITableViewCell {
    
    @IBOutlet weak var lblaName: UILabel!
    
    @IBOutlet weak var btnDirection: UIButton!
    
}

class tblMapData: UIViewController, UITableViewDataSource, UITableViewDelegate {
  
    
    @IBOutlet weak var tblData: UITableView!
    
    var myCoordinate = CLLocationCoordinate2D()
    var locationmanager = CLLocationManager()
    var currentLat = 0.0
    var lat = 23.076488
    var long = 72.456297
    var currentLong = 0.0
    var timer = Timer()
    
    var arrData = NSMutableArray()
    var arrMenuover = NSMutableArray()
   

    override func viewDidLoad() {
        super.viewDidLoad()
//        self.WB()
//        let arr: Set = [1,2,3,4,5,6]
//        let arr1: Set = [3,4,6,7,8,9,10]
//        arr.intersection(arr1).sorted()
        
        let arr = [1,2,3,4,5,6]
        let arr1 = [3,4,6,7,8,9,10]
        let newArray = arr.filter { (string) -> Bool in
            return arr1.contains(string)
        }
        print(newArray)
//        for i in 0..<11{
//            if i != 8{
//                print(i)
//            }
//        }
        
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellData", for: indexPath) as! cellData
//        let dic = arrMenuover[indexPath.row] as!NSArray
        cell.lblaName.text = (arrMenuover.object(at: indexPath.row) as AnyObject).value(forKey: "maneuver") as? String
        cell.btnDirection.tag = indexPath.row
    
        return cell
        
    }
    
    @IBAction func btnGetDirectionClick(_ sender: UIButton) {
        let Slat =  ((arrMenuover.object(at: sender.tag) as AnyObject).value(forKey: "Slat") as? String)!
        let Slong =  ((arrMenuover.object(at: sender.tag) as AnyObject).value(forKey: "Slong") as? String)!
        let Elat =  ((arrMenuover.object(at: sender.tag) as AnyObject).value(forKey: "Elat") as? String)!
        let Elong =  ((arrMenuover.object(at: sender.tag) as AnyObject).value(forKey: "Elong") as? String)!
        
        
        let googleMapUrlString:String = String(format: "http://maps.google.com/?saddr=%f,%f&daddr=%@,%@", Double(Slat)!, Double(Slong)!,Elat,Elong)
        UIApplication.shared.openURL(NSURL(string: googleMapUrlString)! as URL)
    }
    
    func WB() {

        let origin = "\(28.524555),\(77.275111)"
        let destination = "\(23.118382),\(72.537858)"
        let url = URL(string: "https://maps.googleapis.com/maps/api/directions/json?origin=\(origin)&destination=\(destination)&sensor=true&mode=driving&key=AIzaSyDXhcpRwPQvgWtU1a13lVWy54qiVdcK1f0")!
        print(url)
        Alamofire.request(url).responseJSON { response in
            print(response.request as Any)  // original URL request
            print(response.response as Any) // HTTP URL response
            print(response.data as Any)     // server data
            print(response.result)   // result of response serialization
            
            let json =  JSON(response.data as Any)
            print(json)
            let routes = json["routes"].arrayValue
            print(routes)
            
            
            for route in routes
            {
                let routeOverviewPolyline = route["overview_polyline"].dictionary
                let legs = route["legs"].arrayValue
                print(legs as Any)
                print(legs)
                for leg in legs
                {
                    let steps = leg["steps"].arrayValue
                    print(steps)
                    self.arrData = (steps as NSArray).mutableCopy() as! NSMutableArray
                    print(self.arrData)
                    for step in steps
                    {
                        var dic = NSMutableDictionary()
                        let maneuver = step["maneuver"].stringValue
                        let startLocation = step["start_location"].dictionaryValue
                        let Slat = startLocation["lat"]!.stringValue
                        let Slong = startLocation["lng"]!.stringValue
                        let endLocation = step["start_location"].dictionaryValue
                        let Elat = endLocation["lat"]!.stringValue
                        let Elong = endLocation["lng"]!.stringValue
                        dic = ["maneuver":maneuver,"Slat":Slat,"Slong":Slong,"Elat":Elat,"Elong":Elong]
                        self.arrMenuover.add(dic)
                        print(self.arrMenuover)
                    }
                }
                
                let points = routeOverviewPolyline?["points"]?.stringValue
                let path = GMSPath.init(fromEncodedPath: points!)
                let polyline = GMSPolyline.init(path: path)
                polyline.strokeColor = UIColor.blue
                polyline.strokeWidth = 2
            }
        self.tblData.reloadData()
        }
      print("--------------------------MY MAP DATA--------------------------")
    }
   
}
