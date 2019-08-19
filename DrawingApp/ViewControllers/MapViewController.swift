//
//  MapViewController.swift
//  DrawingApp
//
//  Created by imtiaz abbas on 19/08/19.
//  Copyright © 2019 Imtiaz. All rights reserved.
//

import UIKit
import GoogleMaps
import Stevia

class MapViewController: UIViewController, CLLocationManagerDelegate, GMSMapViewDelegate {
  
  let locationManager = CLLocationManager()
  var mapView: GMSMapView? = nil
  let label = UILabel()
  let marker = GMSMarker()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.sv(label)
    label.Top == 100
    label.centerHorizontally()
    
    self.locationManager.requestAlwaysAuthorization()
    // For use in foreground
    self.locationManager.requestWhenInUseAuthorization()
    
    if CLLocationManager.locationServicesEnabled() {
      print("location enabled")
      locationManager.delegate = self
      locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
      locationManager.startUpdatingLocation()
    } else {
      print("location not enabled")
    }
  }
  
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
    updateLocation(location: locValue)
    locationManager.stopUpdatingLocation()
  }
  
  override func loadView() {
    let camera = GMSCameraPosition.camera(withLatitude: 0.0, longitude: 0.0, zoom: 15.0)
    self.mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
    updateMapMarker(location: CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0))
    mapView?.delegate = self
    view = mapView
  }
  
  func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
    let desitnationLocation = CLLocation(latitude: position.target.latitude, longitude: position.target.longitude)
    changeLocationCoordinates(coordinates: desitnationLocation.coordinate)
  }
  
  func changeLocationCoordinates(coordinates:CLLocationCoordinate2D) {
    CATransaction.begin()
    CATransaction.setAnimationDuration(0.1)
    marker.position =  coordinates
    updateLocationText(location: coordinates)
    CATransaction.commit()
  }

  
  func updateMapMarker(location: CLLocationCoordinate2D) {
    if let mapV = self.mapView {
      self.marker.position = location
      self.marker.map = mapV
    }
  }
  
  func updateLocation(location: CLLocationCoordinate2D) {
    self.mapView?.animate(toLocation: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude))
    self.view = mapView!
    updateMapMarker(location: location)
    updateLocationText(location: location)
  }
  
  func updateLocationText(location: CLLocationCoordinate2D) {
    label.textColor = .black
    let lat = "\(location.latitude)"
    let long = "\(location.longitude)"
    label.text = "\(String(lat.prefix(8))), \(String(long.prefix(8)))"
    label.font = label.font.withSize(35)
  }
}
