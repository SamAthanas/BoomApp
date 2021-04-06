//
//  MapController.swift
//  BoomApp
//
//  Created by Samuel Athanasenas on 10/28/20.
//  Copyright © 2020 Samuel Athanasenas. All rights reserved.
//

import UIKit
import MapKit

class MapController {
    var map:MKMapView;
    var latitude:Double;
    var longitude:Double;
    
    var mapAnnotations:[MKPointAnnotation];
    var zoomActive:Bool;

    init(map:MKMapView) {
        self.map = map;
        self.latitude = 0;
        self.longitude = 0;
        
        self.zoomActive = false;
        self.mapAnnotations = [];
    }
    
    func setMapType(type:MKMapType) {
        map.mapType = type;
    }
    
    func updateMap(latitude:Double?,longitude:Double?) {
        if (latitude != nil) {
            self.latitude = latitude!;
        }
        
        if (longitude != nil) {
            self.longitude = longitude!;
        }

        let lat = self.latitude;
        let lon = self.longitude;
        
        let coordinates = CLLocationCoordinate2D( latitude: lat, longitude: lon)
        let span: MKCoordinateSpan = MKCoordinateSpan.init(latitudeDelta: 0.01, longitudeDelta: 0.01)
        
        let region: MKCoordinateRegion = MKCoordinateRegion.init(center: coordinates, span: span)
        
        self.map.setRegion(region, animated: true);

        zoomActive = false;
    }
    
    func addMapItem(latitude:Double,longitude:Double,title:String?,subTitle:String?) -> MKPointAnnotation {
        let coordinates = CLLocationCoordinate2D( latitude: latitude, longitude: longitude);
        
        // add an annotation
        let annotation = MKPointAnnotation();
        annotation.coordinate = coordinates;
        annotation.title = title ?? "";
        annotation.subtitle = subTitle ?? "";
        
        self.map.addAnnotation(annotation);
        
        return annotation;
    }

    
    func mapZoom(_ zoomin : Bool) {
        var region = self.map.region;
        var span = MKCoordinateSpan();
        span.latitudeDelta = zoomin ? region.span.latitudeDelta / 2 :  region.span.latitudeDelta * 2;
        span.longitudeDelta = zoomin ? region.span.longitudeDelta / 2 : region.span.longitudeDelta * 2;
        region.span = span;
    
        self.map.setRegion(region, animated: true);
        zoomActive = true;
    }
    
    func removeAnnotations() {
        for annotation in mapAnnotations {
            self.map.removeAnnotation(annotation);
        }
        mapAnnotations.removeAll();
    }
}
