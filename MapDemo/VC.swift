////
////  VC.swift
////  MapDemo
////
////  Created by Stegowl05 on 27/03/19.
////  Copyright © 2019 Stegowl. All rights reserved.
////
////
////  ViewController.swift
////  MapDemo
////
////  Created by Stegowl05 on 25/03/19.
////  Copyright © 2019 Stegowl. All rights reserved.
////
//
//import UIKit
//import GoogleMaps
//import CoreLocation
//import GooglePlaces
//import UIKit
//import Alamofire
//import SwiftyJSON
//
//class ViewController: UIViewController, CLLocationManagerDelegate ,GMSMapViewDelegate{
//    
//    @IBOutlet weak var viewMap: GMSMapView!
//    var myCoordinate = CLLocationCoordinate2D()
//    var locationmanager = CLLocationManager()
//    var currentLat = 0.0
//    var lat = 23.076488
//    var long = 72.456297
//    var currentLong = 0.0
//    var timer = Timer()
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        locationmanager.delegate = self
//        locationmanager.desiredAccuracy = kCLLocationAccuracyBest
//        locationmanager.requestWhenInUseAuthorization()
//        let camera = GMSCameraPosition.camera(withLatitude: 28.524555,
//                                              longitude: 77.275111,
//                                              zoom: 10.0,
//                                              bearing: 30,
//                                              viewingAngle: 40)
//        self.viewMap.camera = camera
//        self.viewMap.delegate = self
//        self.viewMap?.isMyLocationEnabled = true
//        //        self.viewMap.settings.myLocationButton = true
//        //        self.viewMap.settings.compassButton = true
//        self.viewMap.settings.zoomGestures = true
//        //  self.viewMap.animate(to: camera)
//        self.view.addSubview(self.viewMap)
//        
//        //Setting the start and end location
//        let origin = "\(28.524555),\(77.275111)"
//        let destination = "\(28.643091),\(77.218280)"
//        let url = URL(string: "https://maps.googleapis.com/maps/api/directions/json?origin=\(28.524555),\(77.275111)&destination=\(28.643091),\(77.218280)&sensor=true&mode=driving&key=AIzaSyBUyqVv-_3nXoADcV-dvSTCnclJcpdjhSU")!
//        //  let url = "https://maps.googleapis.com/maps/api/directions/json?origin=\(origin)&destination=\(destination)&mode=driving&key=AIzaSyAh47j2BTE-2zQm5GBlWIl2fCvRWPrVuC4"
//        //  let url = "https://maps.googleapis.com/maps/api/directions/json?origin=\(origin)&destination=\(destination)&mode=driving"
//        print(url)
//        //Rrequesting Alamofire and SwiftyJSON
//        Alamofire.request(url).responseJSON { response in
//            print(response.request as Any)  // original URL request
//            print(response.response as Any) // HTTP URL response
//            print(response.data as Any)     // server data
//            print(response.result)   // result of response serialization
//            
//            let json =  JSON(response.data as Any)
//            print(json)//try! JSON(data: response.data!)
//            let routes = json["routes"].arrayValue
//            print(routes)
//            for route in routes
//            {
//                let routeOverviewPolyline = route["overview_polyline"].dictionary
//                let points = routeOverviewPolyline?["points"]?.stringValue
//                let path = GMSPath.init(fromEncodedPath: points!)
//                let polyline = GMSPolyline.init(path: path)
//                polyline.strokeColor = UIColor.blue
//                polyline.strokeWidth = 2
//                polyline.map = self.viewMap
//            }
//        }
//        
//        
//        // Creates a marker in the center of the map.
//        let marker = GMSMarker()
//        marker.position = CLLocationCoordinate2D(latitude: 28.524555, longitude: 77.275111)
//        marker.title = "Mobiloitte"
//        marker.snippet = "India"
//        marker.map = viewMap
//        
//        //28.643091, 77.218280
//        let marker1 = GMSMarker()
//        marker1.position = CLLocationCoordinate2D(latitude: 28.643091, longitude: 77.218280)
//        marker1.title = "NewDelhi"
//        marker1.snippet = "India"
//        marker1.map = viewMap
//        //  let camera = GMSCameraPosition.camera(withLatitude: 23.033782, longitude: 72.558722, zoom: 10.0)
//        //        viewMap.camera = camera
//        //        self.viewMap = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
//        //        // self.viewMap.isMyLocationEnabled = true
//        //        let marker = GMSMarker()
//        //        marker.position = CLLocationCoordinate2DMake(18.5203, 73.8567)
//        //        marker.groundAnchor = CGPoint(x: 0.5, y: 0.5)
//        //        marker.map = viewMap
//        //        let marker1 = GMSMarker()
//        //        marker1.position = CLLocationCoordinate2DMake(16.7, 73.8567)
//        //        marker1.groundAnchor = CGPoint(x: 0.5, y: 0.5)
//        //        marker1.map = viewMap
//        
//        //  MARK:- FOR STRAIGHT LINE
//        
//        //        let path = GMSMutablePath()
//        //        path.add(CLLocationCoordinate2DMake(CDouble((18.520)), CDouble((73.856))))
//        //        path.add(CLLocationCoordinate2DMake(CDouble((16.7)), CDouble((73.8567))))
//        //        let rectangle = GMSPolyline.init(path: path)
//        //        // rectangle.strokeWidth = 2.0
//        //        rectangle.spans = [GMSStyleSpan(color: .red)]
//        //        //rectangle.strokeColor = UIColor.red
//        //        rectangle.map = self.viewMap
//        //        rectangle.geodesic = true
//        //        rectangle.map = viewMap
//        //
//        //        self.view = viewMap
//    }
//    // Do any additional setup after loading the view, typically from a nib.
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//    
//    //    func generateRoute(uiMapView:GMSMapView, encodedString:String){
//    //
//    //        uiMapView.clear()
//    //        let path = GMSMutablePath(fromEncodedPath: encodedString)
//    //        let polyLine = GMSPolyline(path: path)
//    //        polyLine.strokeWidth = 3
//    //
//    //        polyLine.map = uiMapView
//    
//    //        let polyline = Polyline(encodedPolyline: encodedString)
//    //        let decodedCoordinates: [CLLocationCoordinate2D]? = polyline.coordinates
//    //
//    //        let pickupLat = decodedCoordinates?[0].latitude
//    //        let pickupLong = decodedCoordinates?[0].longitude
//    //
//    //
//    //        let dropLat = decodedCoordinates?[((decodedCoordinates?.count)! -  1)].latitude
//    //        let dropLong = decodedCoordinates?[((decodedCoordinates?.count)! - 1)].longitude
//    
//    // Creates a marker in the center of the map.
//    //        let marker = GMSMarker()
//    //        marker.position = CLLocationCoordinate2D(latitude: pickupLat!, longitude: pickupLong!)
//    //        marker.snippet = "Pickup Location"
//    //        marker.icon = UIImage(named: "ic_pin_pick.png")
//    //        marker.map = uiMapView
//    //        // Creates a marker in the center of the map.
//    //        let marker2 = GMSMarker()
//    //        marker2.position = CLLocationCoordinate2D(latitude: dropLat!, longitude: dropLong!)
//    //        marker2.snippet = "Drop Location"
//    //        marker2.icon = UIImage(named: "ic_pin_drop.png")
//    //        marker2.map = uiMapView
//    //   }
//    //    func drawPath(from polyStr: String){
//    //        let path = GMSPath(fromEncodedPath: polyStr)
//    //        let polyline = GMSPolyline(path: path)
//    //        polyline.strokeWidth = 3.0
//    //        polyline.map = viewMap // Google MapView
//    //    }
//    //    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//    //        print("Lat--",manager.location!.coordinate.latitude)
//    //        print("Long--",manager.location!.coordinate.longitude)
//    //        self.currentLat = manager.location!.coordinate.latitude
//    //        self.currentLong = manager.location!.coordinate.longitude
//    //        let userLocation = locations[0]
//    //
//    //        // redirect to google map
//    //        //   let googleMapUrlString:String = String(format: "http://maps.google.com/?saddr=%f,%f&daddr=%@,%@", self.currentLat, self.currentLong,self.lat,self.long)
//    //        // UIApplication.shared.openURL(URL(string: googleMapUrlString)!)
//    //        CLGeocoder().reverseGeocodeLocation(userLocation) { (placemarks, error) in
//    //        }
//    //    }
//    //
//    //
//    //    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
//    //        if status == CLAuthorizationStatus.authorizedWhenInUse {
//    //            self.locationmanager.startUpdatingLocation()
//    //        }
//    //        else if status == CLAuthorizationStatus.denied {
//    //
//    //        }
//    //    }
//}
//
//
