//
//  ViewController.swift
//  MapDemo
//
//  Created by Stegowl05 on 25/03/19.
//  Copyright © 2019 Stegowl. All rights reserved.
//

import UIKit
import GoogleMaps
import CoreLocation
import GooglePlaces
import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController, CLLocationManagerDelegate ,GMSMapViewDelegate{
    
    @IBOutlet weak var viewMap: GMSMapView!
    var myCoordinate = CLLocationCoordinate2D()
    var locationmanager = CLLocationManager()
    var currentLat = 0.0
    var lat = 23.076488
    var long = 72.456297
    var currentLong = 0.0
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let camera = GMSCameraPosition.camera(withLatitude: 28.524555,
                                              longitude: 77.275111,
                                              zoom: 10.0,
                                              bearing: 30,
                                              viewingAngle: 500)
        self.viewMap.camera = camera
        self.viewMap.delegate = self
        self.viewMap?.isMyLocationEnabled = true
        self.view.addSubview(self.viewMap)
        let origin = "\(28.524555),\(77.275111)"
        let destination = "\(28.643091),\(77.218280)"
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
                let points = routeOverviewPolyline?["points"]?.stringValue
                let path = GMSPath.init(fromEncodedPath: points!)
                let polyline = GMSPolyline.init(path: path)
                polyline.strokeColor = UIColor.blue
                polyline.strokeWidth = 2
                polyline.map = self.viewMap
            }
        }
        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: 28.524555, longitude: 77.275111)
        marker.title = "Mobiloitte"
        marker.snippet = "India"
        marker.map = viewMap
   
        let marker1 = GMSMarker()
        marker1.position = CLLocationCoordinate2D(latitude: 28.643091, longitude: 77.218280)
        marker1.title = "NewDelhi"
        marker1.snippet = "India"
        marker1.map = viewMap
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

