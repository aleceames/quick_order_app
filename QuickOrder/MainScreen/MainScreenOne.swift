//
//  MainScreenOne.swift
//  QuickOrder
//
//  Copyright © 2019 QuickOrder. All rights reserved.
//

import Foundation
import UIKit
import GoogleMaps
import GooglePlaces
import GooglePlacePicker
import CoreLocation

class MainScreenOneController: UIViewController, UITableViewDelegate, UITableViewDataSource,
UISearchDisplayDelegate, GMSPlacePickerViewControllerDelegate, UINavigationControllerDelegate,
CLLocationManagerDelegate {
    
    // MARK: - Variables
    // Define "Search For a Store" button
    var buttonView = UIView(frame: .zero)
    
    // Create label with frame size of 0
    let text = UILabel(frame: .zero)
    
    // TODO: Create UITableView with frame size of 0 named purchases
    var purchases = UITableView(frame: .zero)
    
    // Google Places setup
    lazy var locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        return manager
    }()
    
    var placesClient: GMSPlacesClient!
    var appLocationEnabled = CLLocationManager.authorizationStatus()
    
    // MARK: - Overrides
    override func viewDidLoad() {
        // Set current view's background color to a UIColor
        // object initialized with a UIImage
        view.backgroundColor = UIColor(patternImage: UIImage(named: "Amethyst.png")!)
        
        placesClient = GMSPlacesClient.shared()
        
        // Create search button
        defineSearchButton()
        
        // Create Recent Purchases textview
        defineRecentPurchasesText()
        
        // TODO: Append two place names of your choice to the orders array in
        // Constants and Global Variables
        
        
        // Create purchases tableview
        definePurchases()
    }
    
    // MARK: - Custom Functions
    func defineSearchButton() {
        buttonView.backgroundColor = .white
        buttonView.layer.cornerRadius = 20
        buttonView.layer.masksToBounds = true
        buttonView.alpha = 0.8
        buttonView.isOpaque = true
        
        // Use autolayout
        buttonView.translatesAutoresizingMaskIntoConstraints = false
        
        // Create the button
        let searchButton = UIButton(type: .roundedRect)
        searchButton.addTarget(self, action: #selector(searchClicked), for: .touchUpInside)
        searchButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight(rawValue: 10))
        searchButton.tintColor = .black
        searchButton.setTitle("Search For a Store", for: .normal)
        searchButton.frame = .zero
        
        // Use autolayout
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        
        // Add searchButton to buttonView
        buttonView.addSubview(searchButton)
        
        // Declare layout guide for the view's margins
        let margins = view.layoutMarginsGuide
        
        // Center search button text in its container
        searchButton.centerYAnchor.constraint(equalTo: buttonView.centerYAnchor).isActive = true
        searchButton.centerXAnchor.constraint(equalTo: buttonView.centerXAnchor).isActive = true
        searchButton.widthAnchor.constraint(equalToConstant: 300).isActive = true
        searchButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        self.view.addSubview(buttonView)
        
        // Add constraints of buttonView (our search button) to view
        buttonView.topAnchor.constraint(equalTo: margins.topAnchor, constant: 75).isActive = true
        buttonView.centerXAnchor.constraint(equalTo: margins.centerXAnchor).isActive = true
        buttonView.widthAnchor.constraint(equalToConstant: 300).isActive = true
        buttonView.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func defineRecentPurchasesText() {
        // TODO: Set text to "Recent Purchases"
        
        
        // Set text font to Apple's System font
        text.font = UIFont.systemFont(ofSize: 25, weight: UIFont.Weight(rawValue: 10))
        
        // TODO: Set text color to white
        
        
        // Use autolayout
        text.translatesAutoresizingMaskIntoConstraints = false
        
        // TODO: Add text UILabel to the view
        
        
        // TODO: Declare layout guide for the view's margins
        l
    
        // TODO: Add constraints to the text
        // Description
        // text should be of constant 30 from the bottom of buttonView
        // text should be of constant 20 from the left side of the screen
        
    }
    
    func definePurchases() {
        // purchases UITableView setup
        purchases.delegate = self
        purchases.dataSource = self
        purchases.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        // TODO: Set background color of purchases to clear
        

        // Add purchases to the view
        self.view.addSubview(purchases)
        
        // Use autolayout for purchases
        purchases.translatesAutoresizingMaskIntoConstraints = false
        
        // Declare layout guide for the view's margins
        let margins = view.layoutMarginsGuide
        
        // Add purchases tableview constraints
        purchases.topAnchor.constraint(equalTo: text.bottomAnchor, constant: 30).isActive = true
        purchases.leftAnchor.constraint(equalTo: margins.leftAnchor).isActive = true
        purchases.rightAnchor.constraint(equalTo: margins.rightAnchor).isActive = true
        purchases.bottomAnchor.constraint(equalTo: margins.bottomAnchor).isActive = true
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Value: \(orders[indexPath.row])")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // TODO: return the count of the orders array in Constants and Global Variables
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "\(orders[indexPath.row])"
        cell.textLabel?.textColor = .white
        cell.backgroundColor = .clear
        return cell
    }
    
    //Retrieves the location that the user picked through Google Place Picker
    func placePicker(_ viewController: GMSPlacePickerViewController, didPick place: GMSPlace) {
        // TODO: Print 2 more attributes of the picked place to the console
        // To start, here is one attribute that is being printed
        print("Place name\(place.name)")
            
        // Dismiss the place picker, as it cannot dismiss itself.
        viewController.dismiss(animated: true, completion: nil)
        
        self.navigationController?.pushViewController(OrderScreenViewController(placeName: place.name), animated: true)
    }
    
    //Dismisses Google Place Picker when user presses the "cancel" button
    func placePickerDidCancel(_ viewController: GMSPlacePickerViewController) {
        // Dismiss the place picker, as it cannot dismiss itself.
        viewController.dismiss(animated: true, completion: nil)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // Retrieve user location and present Place Picker UI centered on user's location
        let userLocation = locations[0]
        let center = CLLocationCoordinate2D(latitude: ((userLocation.coordinate.latitude)), longitude: ((userLocation.coordinate.longitude)))
        let northEast = CLLocationCoordinate2D(latitude: center.latitude + 0.001,
                                               longitude: center.longitude + 0.001)
        let southWest = CLLocationCoordinate2D(latitude: center.latitude - 0.001,
                                               longitude: center.longitude - 0.001)
        let viewport = GMSCoordinateBounds(coordinate: northEast, coordinate: southWest)
        let config = GMSPlacePickerConfig(viewport: viewport)
        let placePicker = GMSPlacePickerViewController(config: config)
        placePicker.delegate = self
        present(placePicker, animated: true, completion: nil)
    }
    
    // MARK: - Action Listeners
    @objc func searchClicked(sender: UIButton!) {
        locationManager.requestLocation()
    }
}
