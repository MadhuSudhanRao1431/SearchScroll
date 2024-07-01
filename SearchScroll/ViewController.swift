//
//  ViewController.swift
//  SearchScroll
//
//  Created by Madhusudhan Rao Uda on 27/06/24.
//


import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    var names = ["Milk", "Bread", "Vegetables", "Fruits", "Onions"]
    var currentIndex = 0
    var staticTextLayer: CATextLayer!
    var dynamicTextLayer: CATextLayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup static text layer ("Search for ")
        staticTextLayer = CATextLayer()
        staticTextLayer.string = "Search for "
        staticTextLayer.foregroundColor = UIColor.gray.cgColor
        staticTextLayer.fontSize = 16.0
        staticTextLayer.alignmentMode = .left
        staticTextLayer.bounds = CGRect(x: 0, y: 4, width: 200, height: 22)
        staticTextLayer.position = CGPoint(x: 150, y: searchBar.frame.height / 2)
        searchBar.layer.addSublayer(staticTextLayer)
        
        
        
        // Start animation on view load
        animateText()
    }
    
    func animateText() {
           // Get the current name to animate
           let currentName = names[currentIndex]
           
           // Setup dynamic text layer (currentName)
           dynamicTextLayer = CATextLayer()
           dynamicTextLayer.foregroundColor = UIColor.gray.cgColor
           dynamicTextLayer.fontSize = 14.0
           dynamicTextLayer.alignmentMode = .center
           dynamicTextLayer.bounds = CGRect(x: 0, y: 0, width: 200, height: 14)
           dynamicTextLayer.position = CGPoint(x: searchBar.frame.width / 2, y: searchBar.frame.height / 2)
           searchBar.layer.addSublayer(dynamicTextLayer)
           
           // Update dynamic text layer with currentName
           dynamicTextLayer.string = currentName
           
           // Create a CABasicAnimation to animate dynamicTextLayer's position
           let animation = CABasicAnimation(keyPath: "position.y")
           animation.fromValue = searchBar.frame.height - 8 // Start from below the searchBar
           animation.toValue = searchBar.frame.height / 2 // Move to the center of searchBar
           animation.duration = 1.0
           animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
           
           // Apply the animation to dynamicTextLayer
           dynamicTextLayer.add(animation, forKey: "positionAnimation")
           
           // Increment index for next name
           currentIndex = (currentIndex + 1) % names.count
           
           // Schedule the next animation after a delay
           DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
               // Remove current dynamicTextLayer from searchBar
               self.dynamicTextLayer.removeFromSuperlayer()
               // Call animateText again to continue animation with the next name
               self.animateText()
           }
       }
}
