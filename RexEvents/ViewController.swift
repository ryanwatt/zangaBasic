//
//  ViewController.swift
//  RexEvents
//
//  Created by Paul O'Neill on 1/26/16.
//  Copyright © 2016 Paul O'Neill. All rights reserved.
//

import UIKit
import CoreData


class ViewController: UIViewController, NSXMLParserDelegate, UITableViewDataSource, UITableViewDelegate{

    @IBOutlet weak var tableView: UITableView!
    
    var events : [zEvent] = []
    var selectedEvent : zEvent? = zEvent()
    
    var parser = NSXMLParser()
    var posts = NSMutableArray()
    var elements = NSMutableDictionary()
    var element = NSString()
    var title1 = NSMutableString()
    var eDate = NSString()
    //var eImage = UIImage()
    var eImage = NSString()
    var eDisc = NSMutableString()
    var eLink = NSMutableString()
    var eCatagory = NSMutableString()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.navigationController?.navigationBar.backgroundColor = UIColor.blackColor()
        self.navigationController?.navigationBar.barTintColor = UIColor.blackColor()
        let imageView = UIImageView(image: UIImage(named: "tableviewBackground.jpg")!)
        self.tableView.backgroundView = imageView
        self.tableView.backgroundView?.contentMode = UIViewContentMode.Center
        self.tableView.backgroundColor = UIColor.blackColor()
        let imgView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 60))
        let logo = UIImage(named: "zanga1.png")
        imgView.image = logo
        imgView.contentMode = UIViewContentMode.ScaleAspectFit
        
        navigationItem.titleView = imgView
        
        tableView!.reloadData()
        
        do {
            try self.beginParsing()
        } catch {}
        
    }
    
    func beginParsing() throws {
        // http://calendar.byui.edu/RSSFeeds.aspx?data=tq9cbc8b%2btuQeZGvCTEMSP%2bfv3SYIrjQ3VTAXA335bE0WtJCqYU4mp9MMtuSlz6MRZ4LbMUU%2fO4%3d
        // http://calendar.byui.edu/RSSFeeds.aspx?data=6N%2bM7u2dU1sLnA7F%2fIU6T7cdeKcTSrVEhd4ewWzOpYQ%3d
        // http://www.fandango.com/rss/moviesnearme_83440.rss
        posts = []
        parser = NSXMLParser(contentsOfURL:(NSURL(string:"http://calendar.byui.edu/RSSFeeds.aspx?data=tq9cbc8b%2btuQeZGvCTEMSP%2bfv3SYIrjQ3VTAXA335bE0WtJCqYU4mp9MMtuSlz6MRZ4LbMUU%2fO4%3d"))!)!
        parser.delegate = self
        parser.parse()
        tableView!.reloadData()
        
    }
    
    /************************************************************************
    * PARSER METHODS
    *************************************************************************/
    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        element = elementName
        if (elementName as NSString).isEqualToString("item") {
            elements = NSMutableDictionary()
            elements = [:]
            title1 = NSMutableString()
            title1 = ""
            eDate = NSMutableString()
            eDate = ""
            //eImage = UIImage()
            eImage = NSString()
            eImage = ""
            eDisc = NSMutableString()
            eDisc = ""
            eLink = NSMutableString()
            eLink = ""
            
        }
        else if (elementName as NSString).isEqualToString("enclosure") {
            let imgLink = attributeDict["url"]! as String
//            let url : NSURL = NSURL(string: imgLink)!
//            let data: NSData = NSData(contentsOfURL: url)!
//            eImage = UIImage(data: data)!
            eImage = imgLink
        }
    }
    
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if (elementName as NSString).isEqualToString("item") {
            if !title1.isEqual(nil) {
                elements.setObject(title1, forKey: "title")
            }
            
            if !eDate.isEqual(nil) {
                elements.setObject(convertTime(eDate as String), forKey: "pubDate")
            }
            
            if !eImage.isEqual(nil) {
                elements.setObject(eImage, forKey: "enclosure")
            }
            
            if !eDisc.isEqualToString("") {
                elements.setObject(eDisc, forKey: "description")
            }
            
            if !eLink.isEqual(nil) {
                elements.setObject(eLink, forKey: "link")
            }
            
            if !eCatagory.isEqual(nil) {
                elements.setObject(eCatagory, forKey: "catagory")
            }
            
            posts.addObject(elements)
            
        }
    }
    
    func parser(parser: NSXMLParser, foundCharacters string: String) {
        if element.isEqualToString("title") {
            title1.appendString(string)
        } else if element.isEqualToString("pubDate") {
            eDate = string
        } else if element.isEqualToString("description") {
            eDisc.appendString(string)
        } else if element.isEqualToString("link") {
            eLink.appendString(string)
        } else if element.isEqualToString("catagory") {
            eCatagory.appendString(string)
        }
    }
    
    /************************************************************************
    * TABLE VIEW METHODS
    *************************************************************************/
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let anEvent = zEvent()
        
        
        var cell = tableView.dequeueReusableCellWithIdentifier("cell") as! EventTableViewCell
        
        if(cell.isEqual(NSNull)) {
            cell = NSBundle.mainBundle().loadNibNamed("cell", owner: self, options: nil)[0] as! EventTableViewCell
        }

        let day = posts.objectAtIndex(indexPath.row).valueForKey("pubDate") as! NSString as String
        let day_of_week = day.substringWithRange(Range<String.Index>(start: day.startIndex, end: day.startIndex.advancedBy(3)))
        let date = day.substringWithRange(Range<String.Index>(start: day.startIndex.advancedBy(5), end: day.startIndex.advancedBy(11)))
        let time_of_day = day.substringWithRange(Range<String.Index>(start: day.startIndex.advancedBy(12), end: day.endIndex))
        
        cell.eTitle.text = posts.objectAtIndex(indexPath.row).valueForKey("title") as! NSString as String
        //cell.ePic.image = posts.objectAtIndex(indexPath.row).valueForKey("enclosure") as? UIImage
        let url = posts.objectAtIndex(indexPath.row).valueForKey("enclosure") as! String
        //let block  = SDWebImageCompletionBlock()
        cell.ePic.sd_setImageWithURL(NSURL(string: url), placeholderImage: UIImage(named: "placeholder.jgp"))
        cell.eTime.text = time_of_day
        cell.eDate.text = date
        cell.eDay.text = day_of_week
        
        events.append(anEvent)
        
        return cell
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let post : NSMutableDictionary = (self.posts[indexPath.row] as? NSMutableDictionary)!
        self.selectedEvent!.title = post.valueForKey("title") as! NSString as String
        self.selectedEvent!.date = post.valueForKey("pubDate") as! String
        self.selectedEvent!.eDescription = post.valueForKey("description") as! NSString as String
        self.selectedEvent!.image = post.valueForKey("enclosure") as! NSString
        self.selectedEvent!.location = "BYUI Campus"
        self.performSegueWithIdentifier("eventDetailSegue", sender: self)
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let detailViewController = segue.destinationViewController as! EventInfoViewController
        detailViewController.event = self.selectedEvent
    }
    
    
    /**************************************************************************************************
    *
    *
    *                   ****************CUSTOM FUNCTIONS****************
    *
    *
    *************************************************************************************************/
     
     
    /*******************************************
     * CONVERT TIME ZONE TO LOCAL TIME
     ********************************************/
    func convertTime(time: String) -> String {
        var convertedTime : String = ""
        let dateString = time
        // cut out time zone code (GMT)
        let newStringDate = dateString.substringWithRange(Range<String.Index>(start: dateString.startIndex, end: dateString.startIndex.advancedBy(24)))
        let formatter = NSDateFormatter();
        formatter.dateFormat = "EEE, dd MMM yyyy HH:mm:ss"
        formatter.timeZone = NSTimeZone(forSecondsFromGMT: 0)
        if let dateFromString = formatter.dateFromString(newStringDate) {
            formatter.dateFormat = "EEE, dd MMM hh:mm a"
            formatter.timeZone = NSTimeZone.localTimeZone()
            //date.setString(formatter.stringFromDate(dateFromString))
            convertedTime = formatter.stringFromDate(dateFromString) as String
        }
        
        return convertedTime
    }


}

