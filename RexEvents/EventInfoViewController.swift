//
//  EventInfoViewController.swift
//  RexEvents
//
//  Created by Paul O'Neill on 2/9/16.
//  Copyright © 2016 Paul O'Neill. All rights reserved.
//

import UIKit
import MapKit

class EventInfoViewController: UIViewController {

    
    @IBOutlet weak var event_pic: UIImageView!
    @IBOutlet weak var event_title: UILabel!
    @IBOutlet weak var event_time: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var eventLocation: UILabel!
    @IBOutlet weak var eventDescription: UILabel!

    
    var event : zEvent? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //self.event_title.text = self.event?.title
        //self.event_date_time.text = self.event?.date as? String
        //self.event_description.text = self.event?.eDescription as? String
        //self.event_pic.image = self.event?.image
//        var address = "370 W 7th S, Rexburg, ID, USA"
//        var geocoder = CLGeocoder()
//        geocoder.geocodeAddressString(address) { (placemarks: [AnyObject]!, error: NSError?) -> Void in
//            if let placemark = placemarks?[0] as? CLPlacemark {
//                self.mapView.addAnnotation(MKPlacemark(placemark: placemark))
//            }
//        }
        
        //sd_setImageWithURL(NSURL(string: url), placeholderImage: UIImage(named: "placeholder.jgp"))
        
        self.event_pic.sd_setImageWithURL(NSURL(string: (self.event?.image)! as String), placeholderImage: UIImage(named: "placeholder.jpg"))
        self.event_title.text = self.event?.title
        self.event_time.text = self.event?.date as? String
        self.eventDescription.text = self.event?.eDescription as? String
        self.eventLocation.text = self.event?.location as? String
        
    }
    
    
    
    

}
