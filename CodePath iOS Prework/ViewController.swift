//
//  ViewController.swift
//  CodePath iOS Prework
//
//  Created by joel on 12/6/24.
//

import UIKit

class ViewController: UIViewController {
    
    // UI elements connected from the storyboard
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!
    @IBOutlet weak var colorSlider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set up the color slider and reset colors on app load
        setupColorSlider()
        resetColors()
    }
    
    // Changes the background color randomly when the user taps a button
    @IBAction func changeBackgroundColor(_ sender: UIButton) {
        let randomColor = generateRandomColor()
        view.backgroundColor = randomColor
    }
    
    // Changes the text color of all labels to a random color
    @IBAction func changeTextColor(_ sender: UIButton) {
        let randomColor = generateRandomColor()
        label1.textColor = randomColor
        label2.textColor = randomColor
        label3.textColor = randomColor
    }
    
    // Resets colors to default when the reset button is tapped
    @IBAction func resetColor(_ sender: UIButton) {
        resetColors()
    }
    
    // Called when the slider value changes to adjust the background color
    @objc func sliderValueChanged(_ sender: UISlider) {
        let color = UIColor(hue: CGFloat(sender.value), saturation: 1.0, brightness: 1.0, alpha: 1.0)
        view.backgroundColor = color
        updateLabelColors(for: color)
    }
    
    // Sets the initial properties for the color slider
    func setupColorSlider() {
        colorSlider.minimumValue = 0
        colorSlider.maximumValue = 1.0
        colorSlider.value = 0.5
        colorSlider.addTarget(self, action: #selector(sliderValueChanged(_:)), for: .valueChanged)
        configureSliderWithGradient()
    }
    
    // Applies a gradient effect to the slider
    func configureSliderWithGradient() {
        let gradientImage = createGradientImage()
        colorSlider.setMinimumTrackImage(gradientImage, for: .normal)
        colorSlider.setMaximumTrackImage(gradientImage, for: .normal)
    }
    
    // Creates a gradient image for the slider's track
    func createGradientImage() -> UIImage {
        let trackHeight: CGFloat = 4.0
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = CGRect(x: 0, y: 0, width: colorSlider.bounds.width, height: trackHeight)
        gradientLayer.colors = [UIColor.red.cgColor, UIColor.orange.cgColor, UIColor.yellow.cgColor, UIColor.green.cgColor, UIColor.blue.cgColor, UIColor.purple.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        
        UIGraphicsBeginImageContextWithOptions(gradientLayer.bounds.size, false, 0.0)
        gradientLayer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext() ?? UIImage()
        UIGraphicsEndImageContext()
        
        return image.stretchableImage(withLeftCapWidth: Int(image.size.width / 2), topCapHeight: 0)
    }
    
    // Generates a random semi-transparent color
    func generateRandomColor() -> UIColor {
        return UIColor(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1), alpha: 0.5)
    }
    
    // Resets the background and labels to default colors
    func resetColors() {
        view.backgroundColor = .white
        label1.textColor = .black
        label2.textColor = .black
        label3.textColor = .black
        colorSlider.value = 0.5
    }
    
    // Updates the text color of labels based on background color brightness
    func updateLabelColors(for backgroundColor: UIColor) {
        let textColor = backgroundColor.isDarkColor ? UIColor.white : UIColor.black
        label1.textColor = textColor
        label2.textColor = textColor
        label3.textColor = textColor
    }
}

// Extension to check if color is dark or light
extension UIColor {
    var isDarkColor: Bool {
        var white: CGFloat = 0.0
        getWhite(&white, alpha: nil)
        return white < 0.5
    }
}
