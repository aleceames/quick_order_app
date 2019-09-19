//
//  OrderScreenViewController.swift
//  QuickOrder
//
//  Copyright © 2019 QuickOrder. All rights reserved.
//

import UIKit
import Foundation
import GoogleMaps
import GooglePlaces
import CoreLocation

class OrderScreenViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    
    // MARK: - Variables
    // Create instance of a UILabel with a size of 0
    let titleLabel = UILabel(frame: .zero)
    
    // Create instance of UIButton
    let backButton = UIButton(frame: .zero)
    
    // TODO: Create UITextField as orderTextField
    // with an initial frame of zero
    
    
    // TODO: Create UIButton as confirmOrderButton
    // with an initial frame of zero
    
    
    // String holding the place from which the customer is ordering
    // NOTE: This variable initialized in current controller's constructor
    var orderPlace: String
    
    
    // MARK: - Overrides
    
    // This function runs after the view loads
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(patternImage: UIImage(named: "Amethyst.png")!)
        
        // TODO: Create title, back button, order text field, and submit button
        // Hint: You'll need to call a few functions
        
    }
    
    func createBackButton() {
        // Set back button image for the UIButton
        backButton.setImage(UIImage(named: "back-button")?.withRenderingMode(.alwaysTemplate), for: .normal)
        
        // Change image color to white from black
        backButton.tintColor = .white
        
        // TODO: Run backToMainScreen function when backButton is touched
        // inside its object bounds
        
        
        // Use autolayout with constraints
        backButton.translatesAutoresizingMaskIntoConstraints = false
        
        // Add backButton to view
        self.view.addSubview(backButton)
        
        // Declare layout guide for the view's margins
        let margins = view.layoutMarginsGuide
        
        // Add constraints to backButton
        backButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor).isActive = true
        backButton.leftAnchor.constraint(equalTo: margins.leftAnchor, constant: 5).isActive = true
        backButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        backButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func createTitle() {
        // TODO: Set text of titleLabel to the name of the order place
        
        
        // Align text to the center
        titleLabel.textAlignment = .center

        // Specify the font to be used for the label
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight(rawValue: 10))
        
        // TODO: Specify text color as white
        
        
        // Break label into more than one line if text does not fit
        titleLabel.lineBreakMode = .byWordWrapping
        
        // Specify that the label can have an unlimited amount of lines
        // depending on how long the text is
        titleLabel.numberOfLines = 0
        
        // TODO: Use autolayout with constraints
        
        
        // TODO: Add titleLabel to the view
        
        
        // Declare layout guide for the view's margins
        let margins = view.layoutMarginsGuide
        
        // TODO: Add constraints to UILabel
        // Constraint Description:
        // titleLabel should be of constant 20 from the top of the screen
        // titleLabel should be horizontally centered
        // titleLabel should be of constant 50 from the left of the screen
        // titleLabel should be of constant 50 from the right of the screen
        
    }
    
    func createOrderTextField() {
        // TODO: Specify font of words in orderTextField
        
        
        // Set text to white
        orderTextField.textColor = .white
        
        // Use return key text field
        orderTextField.returnKeyType = .done
        
        // Set orderTextField's background color to gray
        orderTextField.backgroundColor = .gray
        
        // Use autolayout with contraints
        orderTextField.translatesAutoresizingMaskIntoConstraints = false
        
        // Add text field to the view
        self.view.addSubview(orderTextField)
        
        // Declare layout guide for the view's margins
        let margins = view.layoutMarginsGuide
        
        // Add constraints to order text field
        orderTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true
        orderTextField.leftAnchor.constraint(equalTo: margins.leftAnchor).isActive = true
        orderTextField.rightAnchor.constraint(equalTo: margins.rightAnchor).isActive = true
    }
    
    func createSubmitButton() {
        // TODO: From code earlier in the file, try to understand
        // the following code and see if you can predict what
        // createSubmitButton creates and how it styles its UI elements
        // Feel free to change some of the values and experiment a bit
        confirmOrderButton.backgroundColor = .white
        confirmOrderButton.layer.cornerRadius = 20
        confirmOrderButton.layer.masksToBounds = true
        confirmOrderButton.alpha = 0.8
        confirmOrderButton.isOpaque = true
        
        // Use autolayout
        confirmOrderButton.translatesAutoresizingMaskIntoConstraints = false
        
        // Create the button
        let confirmButton = UIButton(type: .roundedRect)
        confirmButton.addTarget(self, action: #selector(confirmOrder), for: .touchUpInside)
        confirmButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight(rawValue: 10))
        confirmButton.tintColor = .black
        confirmButton.setTitle("Submit Order", for: .normal)
        confirmButton.frame = .zero
        confirmButton.translatesAutoresizingMaskIntoConstraints = false
        confirmOrderButton.addSubview(confirmButton)
        
        // Declare layout guide for the view's margins
        let margins = view.layoutMarginsGuide
        
        // Center search button text in its container
        confirmButton.centerYAnchor.constraint(equalTo: confirmOrderButton.centerYAnchor).isActive = true
        confirmButton.centerXAnchor.constraint(equalTo: confirmOrderButton.centerXAnchor).isActive = true
        confirmButton.widthAnchor.constraint(equalToConstant: 300).isActive = true
        confirmButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        self.view.addSubview(confirmOrderButton)

        confirmOrderButton.bottomAnchor.constraint(equalTo: margins.bottomAnchor, constant: -20).isActive = true
        confirmOrderButton.centerXAnchor.constraint(equalTo: margins.centerXAnchor).isActive = true
        confirmOrderButton.widthAnchor.constraint(equalToConstant: 300).isActive = true
        confirmOrderButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        // TODO: When the user begins editing orderTextField,
        // erase the default text and make the text color of
        // orderTextField black
        
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if orderTextField.text?.isEmpty ?? true {
            orderTextField.text = "Enter Order (Example: 3 chocolate muffins)"
            orderTextField.textColor = UIColor.lightGray
        }
    }
    
    // MARK: - Action Listeners
    @objc func backToMainScreen() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func confirmOrder() {
        // TODO: Append the name of the order place to the orders array
        // This array can be found in the Constants and Global Variables.swift
        
        
        // TODO: Pop the current view controller using
        // self.navigationController
        
    }
    
    // MARK: - Initializers
    required init?(coder aDecoder: NSCoder) {
        self.orderPlace = "Ordering from "
        super.init(coder: aDecoder)
    }
    
    init(placeName: String) {
        self.orderPlace = "Ordering from " +  placeName
        super.init(nibName: nil, bundle: nil)
    }
}
