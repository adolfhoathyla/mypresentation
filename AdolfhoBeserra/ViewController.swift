//
//  ViewController.swift
//  AdolfhoBeserra
//
//  Created by Adolfho Athyla on 16/04/15.
//  Copyright (c) 2015 Adolfho Athyla. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController , MKMapViewDelegate, BWWalkthroughViewControllerDelegate {

    @IBOutlet var buttonNext: UIBarButtonItem!
    @IBOutlet var buttonPrev: UIBarButtonItem!
    @IBOutlet var labelStatus: UILabel!
    @IBOutlet var myMapView: MKMapView!
    
    // Show Brazil
    // Show Ceará
    // Show Fortaleza
    // Show IFCE Maracanaú
    // Show FA7
    // Show IFCE Fortaleza/BEPiD
    var telaMostrada = "ShowBrazil"
    
    var brazil: Region?
    var brazilInitial: Region?
    var ceara: Region?
    var fortaleza: Region?
    var ifceMaracanauRegion: Region?
    var fa7Region: Region?
    var bepidRegion: Region?
    
    var ifceMaracanau: University?
    var fa7: University?
    var bepid: University?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.buttonPrev.enabled = false
        
        self.initMyRegions()
        
        self.initMyUniversities()
        
        self.initMyMap()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func initMyRegions() {
        
        self.brazilInitial = Region(name: "Brazil", coordinate: CLLocationCoordinate2DMake(-6.879313, -52.609359),
            latitudeDistance: 6500000 as CLLocationDistance, longitudeDistance: 6500000 as CLLocationDistance)
        
        self.brazil = Region(name: "Brazil", coordinate: CLLocationCoordinate2DMake(-6.879313, -52.609359),
            latitudeDistance: 5000000 as CLLocationDistance, longitudeDistance: 5000000 as CLLocationDistance)
        
        self.ceara = Region(name: "Ceara", coordinate: CLLocationCoordinate2DMake(-4.879313, -39.609359),
            latitudeDistance: 500000 as CLLocationDistance, longitudeDistance: 500000 as CLLocationDistance)
        
        self.fortaleza = Region(name: "Fortaleza", coordinate: CLLocationCoordinate2DMake(-3.739647, -38.538245),
            latitudeDistance: 10000 as CLLocationDistance, longitudeDistance: 10000 as CLLocationDistance)
        
        self.ifceMaracanauRegion = Region(name: "IFCEMaracanau", coordinate: CLLocationCoordinate2D(latitude: -3.8725904, longitude: -38.6109761), latitudeDistance: 2000, longitudeDistance: 2000)
        
        self.fa7Region = Region(name: "FA7", coordinate: CLLocationCoordinate2D(latitude: -3.7713721, longitude: -38.4833348), latitudeDistance: 2000, longitudeDistance: 2000)
        
        self.bepidRegion = Region(name: "BEPiD", coordinate: CLLocationCoordinate2D(latitude: -3.7441968, longitude: -38.5358771), latitudeDistance: 2000, longitudeDistance: 2000)
    }
    
    private func initMyUniversities() {
        self.ifceMaracanau = University(name: "IFCE Campus Maracanaú", coordinates: CLLocationCoordinate2D(latitude: -3.8725904, longitude: -38.6109761))
        self.fa7 = University(name: "Faculdade 7 de Setembro", coordinates: CLLocationCoordinate2D(latitude: -3.7713721, longitude: -38.4833348))
        self.bepid = University(name: "BEPiD", coordinates: CLLocationCoordinate2D(latitude: -3.7441968, longitude: -38.5358771))
    }

    private func initMyMap() {
        
        self.myMapView.delegate = self
        
        self.zoomInMapForRegion(brazilInitial!)
    }
    
    private func addUniversityInMap(university: University) {
        let annotation = MKPointAnnotation()
        
        let location = CLLocation(latitude: university.coordinates.latitude, longitude: university.coordinates.longitude)
        
        annotation.coordinate = location.coordinate
        annotation.title = university.name
        
        self.myMapView.addAnnotation(annotation)
        self.myMapView.selectAnnotation(annotation, animated: true)
    }
    
    private func zoomInMapForRegion(region: Region) {
        let startCoordinate = CLLocationCoordinate2DMake(region.coordinate.latitude, region.coordinate.longitude)
        let adjustRegion = self.myMapView.regionThatFits(MKCoordinateRegionMakeWithDistance(startCoordinate, region.latitudeDistance, region.longitudeDistance))

        self.myMapView.setRegion(adjustRegion, animated: true)
    }
    
    private func animateMyStatusNext() {
        
        UIView.animateWithDuration(0.5, delay: 0.0, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
            
            self.labelStatus.center = CGPointMake(-100, self.labelStatus.center.y)
            
            self.view.layoutIfNeeded()
            
        }) { (sucess) -> Void in
            self.labelStatus.center = CGPointMake(self.view.bounds.width, self.labelStatus.center.y)
            
            UIView.animateWithDuration(0.5, delay: 0.0, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
                
                self.labelStatus.center = CGPointMake(self.view.center.x, self.labelStatus.center.y)
                
            }, completion: nil)
            
            self.view.layoutIfNeeded()
        }
        
    }
    
    private func animateMyStatusPrev() {
        
        UIView.animateWithDuration(0.5, delay: 0.0, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
            
            self.labelStatus.center = CGPointMake(self.view.frame.width + 100, self.labelStatus.center.y)
            
            self.view.layoutIfNeeded()
            
            }) { (sucess) -> Void in
                self.labelStatus.center = CGPointMake(0, self.labelStatus.center.y)
                
                UIView.animateWithDuration(0.5, delay: 0.0, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
                    
                    self.labelStatus.center = CGPointMake(self.view.center.x, self.labelStatus.center.y)
                    
                    }, completion: nil)
                
                self.view.layoutIfNeeded()
        }
        
    }

    @IBAction func buttonNext(sender: AnyObject) {
        
        self.buttonPrev.enabled = true
        
        switch self.telaMostrada {
            case "ShowBrazil":
                self.animateMyStatusNext()
                self.telaMostrada = "ShowCeara"
                self.labelStatus.text = "From Ceará"
                self.zoomInMapForRegion(self.ceara!)
            break
            case "ShowCeara":
                self.animateMyStatusNext()
                self.telaMostrada = "ShowFortaleza"
                self.labelStatus.text = "From Fortaleza"
                self.zoomInMapForRegion(self.fortaleza!)
            break
            case "ShowFortaleza":
                self.animateMyStatusNext()
                self.addUniversityInMap(self.ifceMaracanau!)
                self.telaMostrada = "ShowIFCEMaracanau"
                self.labelStatus.text = "I studied at "
                self.zoomInMapForRegion(self.ifceMaracanauRegion!)
            break
            case "ShowIFCEMaracanau":
                self.animateMyStatusNext()
                self.addUniversityInMap(self.fa7!)
                self.telaMostrada = "ShowFA7"
                self.labelStatus.text = "I study at "
                self.zoomInMapForRegion(self.fa7Region!)
            break
            case "ShowFA7":
                self.animateMyStatusNext()
                self.addUniversityInMap(self.bepid!)
                self.telaMostrada = "ShowBEPiD"
                self.labelStatus.text = "And I work at"
                self.zoomInMapForRegion(self.bepidRegion!)
                break
        default:
            
            let stb = UIStoryboard(name: "Walkthrough", bundle: nil)
            let walkthrough = stb.instantiateViewControllerWithIdentifier("walkController") as! BWWalkthroughViewController
            let page0 = stb.instantiateViewControllerWithIdentifier("walk0Abilities") as! UIViewController
            let page1 = stb.instantiateViewControllerWithIdentifier("walk1Abilities") as! UIViewController
            let page2 = stb.instantiateViewControllerWithIdentifier("walk2Abilities") as! UIViewController
            let page3 = stb.instantiateViewControllerWithIdentifier("walk0Interests") as! UIViewController
            let page4 = stb.instantiateViewControllerWithIdentifier("walk1Interests") as! UIViewController
            let page5 = stb.instantiateViewControllerWithIdentifier("walkEnd") as! UIViewController
            
            walkthrough.delegate = self
            
            walkthrough.addViewController(page0)
            walkthrough.addViewController(page1)
            walkthrough.addViewController(page2)
            walkthrough.addViewController(page3)
            walkthrough.addViewController(page4)
            walkthrough.addViewController(page5)
            
            self.presentViewController(walkthrough, animated: true, completion: nil)
            
            break
        }

    }
    
    @IBAction func buttonPrev(sender: AnyObject) {
        
        switch self.telaMostrada {
        case "ShowCeara":
            self.animateMyStatusPrev()
            self.telaMostrada = "ShowBrazil"
            self.labelStatus.text = "Yes, I'm Brazilian"
            self.zoomInMapForRegion(self.brazil!)
            self.buttonPrev.enabled = false
            break
        case "ShowFortaleza":
            self.animateMyStatusPrev()
            self.telaMostrada = "ShowCeara"
            self.labelStatus.text = "From Ceará"
            self.zoomInMapForRegion(self.ceara!)
            break
        case "ShowIFCEMaracanau":
            self.animateMyStatusPrev()
            self.telaMostrada = "ShowFortaleza"
            self.labelStatus.text = "From Fortaleza"
            self.zoomInMapForRegion(self.fortaleza!)
            self.myMapView.removeAnnotations(self.myMapView.annotations)
            break
        case "ShowFA7":
            self.animateMyStatusPrev()
            self.telaMostrada = "ShowIFCEMaracanau"
            self.labelStatus.text = "I studied at "
            self.zoomInMapForRegion(self.ifceMaracanauRegion!)
            for annotation in self.myMapView.annotations {
                if annotation.title == "IFCE Campus Maracanaú" {
                    self.myMapView.selectAnnotation(annotation as! MKAnnotation, animated: true)
                }
            }
            break
        case "ShowBEPiD":
            self.animateMyStatusPrev()
            self.telaMostrada = "ShowFA7"
            self.labelStatus.text = "I study at "
            self.zoomInMapForRegion(self.fa7Region!)
            for annotation in self.myMapView.annotations {
                if annotation.title == "Faculdade 7 de Setembro" {
                    self.myMapView.selectAnnotation(annotation as! MKAnnotation, animated: true)
                }
            }
            break
        default:
            break
        }
        
    }
    
    // MARK: - MapView
        
    func mapView(mapView: MKMapView!, didAddAnnotationViews views: [AnyObject]!) {
        let av: MKPointAnnotation?
        
        for av in views {
            if av.annotation is MKPointAnnotation {
                
                let annotationsView = av as! MKAnnotationView
                
                if let title = annotationsView.annotation.title {
                    switch title {
                    case "IFCE Campus Maracanaú":
                        annotationsView.leftCalloutAccessoryView = UIImageView(image:UIImage(named: "ifceIcon"))
                        break
                        
                    case "Faculdade 7 de Setembro":
                        annotationsView.leftCalloutAccessoryView = UIImageView(image: UIImage(named: "fa7Icon"))
                        break
                    case "BEPiD":
                        annotationsView.leftCalloutAccessoryView = UIImageView(image: UIImage(named: "bepidIcon"))
                        break
                        
                    default:
                        break
                    }
                }
                

                
                annotationsView.rightCalloutAccessoryView = UIButton.buttonWithType(UIButtonType.DetailDisclosure) as! UIView
                
                annotationsView.canShowCallout = true
                
            }
        }
    }
    
    func mapView(mapView: MKMapView!, annotationView view: MKAnnotationView!, calloutAccessoryControlTapped control: UIControl!) {
        
        if let title = view.annotation.title {
            switch title {
            case "IFCE Campus Maracanaú":
                
                let stb = UIStoryboard(name: "Walkthrough", bundle: nil)
                let walkthrough = stb.instantiateViewControllerWithIdentifier("walk") as! BWWalkthroughViewController
                let page0 = stb.instantiateViewControllerWithIdentifier("walk0ifce") as! UIViewController
                let page1 = stb.instantiateViewControllerWithIdentifier("walk1ifce") as! UIViewController
                
                walkthrough.delegate = self
                
                walkthrough.addViewController(page0)
                walkthrough.addViewController(page1)
                
                self.presentViewController(walkthrough, animated: true, completion: nil)
                
                break
                
            case "Faculdade 7 de Setembro":
                
                let stb = UIStoryboard(name: "Walkthrough", bundle: nil)
                let walkthrough = stb.instantiateViewControllerWithIdentifier("walk") as! BWWalkthroughViewController
                let page0 = stb.instantiateViewControllerWithIdentifier("walk0fa7") as! UIViewController
                let page1 = stb.instantiateViewControllerWithIdentifier("walk1fa7") as! UIViewController
                let page2 = stb.instantiateViewControllerWithIdentifier("walk2fa7") as! UIViewController
                
                walkthrough.delegate = self
                
                walkthrough.addViewController(page0)
                walkthrough.addViewController(page1)
                walkthrough.addViewController(page2)
                
                self.presentViewController(walkthrough, animated: true, completion: nil)
                
                break
            case "BEPiD":
                
                let stb = UIStoryboard(name: "Walkthrough", bundle: nil)
                let walkthrough = stb.instantiateViewControllerWithIdentifier("walk") as! BWWalkthroughViewController
                let page0 = stb.instantiateViewControllerWithIdentifier("walk0bepid") as! UIViewController
                let page1 = stb.instantiateViewControllerWithIdentifier("walk1bepid") as! UIViewController
                let page2 = stb.instantiateViewControllerWithIdentifier("walk2bepid") as! UIViewController
                let page3 = stb.instantiateViewControllerWithIdentifier("walk3bepid") as! UIViewController
                
                walkthrough.delegate = self
                
                walkthrough.addViewController(page0)
                walkthrough.addViewController(page3)
                walkthrough.addViewController(page1)
                walkthrough.addViewController(page2)
                
                self.presentViewController(walkthrough, animated: true, completion: nil)
                
                break
             
            default:
                break
            }
        }
        

    }
    
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
    }
    
}

