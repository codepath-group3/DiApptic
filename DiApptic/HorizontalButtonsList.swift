//
//  HorizontalButtonsList.swift
//  DiApptic
//
//  Created by Faheem Hussain on 12/6/16.
//  Copyright © 2016 Faheem Hussain. All rights reserved.
//


import UIKit

//
// A scroll view, which loads all 10 images, and has a callback
// for when the user taps on one of the images
//
class FilterButton: UIImageView{

    var isSelected: Bool! {
        didSet {
            if isSelected! {
                backgroundColor = Styles.lightBlue
                layer.borderColor = UIColor.white.cgColor
                tintColor = UIColor.white
            }else {
                backgroundColor = UIColor.white
                layer.borderColor = Styles.lightBlue.cgColor
                tintColor = Styles.lightBlue
            }
            
        }
    }
    func layoutButton(){
        contentMode = .center
        isUserInteractionEnabled = true
        layer.cornerRadius = 0.5 * bounds.size.width
        layer.borderWidth = 1.0
    }
    
}
class HorizontalButtonsList: UIScrollView {
    
    var didSelectFilter: ((_ button: FilterButton)->())?
    let buttonWidth: CGFloat = 40.0
    let horizontalPadding: CGFloat = 30.0
    let verticalPadding: CGFloat = 10.0
    let images: [String] = ["dawn24x24","hamburger24x24","dinner24x24", "syringe24x24", "pill24x24"]
    var buttons: [FilterButton] = []
    var container: UIView!
    var isShowing: Bool! {
        didSet {
            if !isShowing! {
                UIView.animate(withDuration: 0.5, animations: {
                    self.alpha = 0
                    self.layoutIfNeeded()
                }, completion: { (error) in
                    self.center.x = self.container.bounds.width + self.bounds.width/2
                })
                
            }
        }
    }
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(inView: UIView) {
        let rect = CGRect(x: inView.bounds.width, y: 0, width: inView.frame.width, height: 60.0)
        self.init(frame: rect)
        self.container = inView
        alpha = 0
        
        for i in 0 ..< 5 {
            let image = UIImage(named: images[i])
            let button  = FilterButton(image: image)
            
            button.bounds.size = CGSize(width: buttonWidth  , height: buttonWidth)
            let x = CGFloat(i) * (buttonWidth + horizontalPadding) + buttonWidth/2 + 20
            button.center = CGPoint(x: x, y: buttonWidth/2 + verticalPadding)
            button.tag = i
            button.layoutButton()
            button.isSelected = false
            addSubview(button)
            
            let tap = UITapGestureRecognizer(target: self, action: #selector(HorizontalButtonsList.didTapImage(_:)))
            button.addGestureRecognizer(tap)
            buttons.append(button)
        }
        
        contentSize = CGSize(width: horizontalPadding * buttonWidth, height:  buttonWidth + 2*verticalPadding)
    }
    
    func didTapImage(_ tap: UITapGestureRecognizer) {
        let tappedButton = buttons[tap.view!.tag]
        for button in buttons {
            if button != tappedButton {
                button.isSelected = false
            }
        }
        tappedButton.isSelected = !tappedButton.isSelected
        didSelectFilter?(tappedButton)
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()

        guard superview != nil else {
            return
        }
        
        UIView.animate(withDuration: 1.0, delay: 0.01, usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 10.0, options: .curveEaseIn,
                       animations: {
                        self.alpha = 1.0
                        self.center.x -= self.frame.size.width

        },
                       completion: nil
        )
    }
}
