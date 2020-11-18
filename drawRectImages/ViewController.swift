//
//  ViewController.swift
//  drawRectImages
//
//  Created by colbylim on 2020/11/17.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var stackViewTopLayoutConstraint: NSLayoutConstraint!
    
    let imageCount: Int = 60
    lazy var maxPage: Int = {
        return Int((CGFloat(imageCount) / 4).rounded(.up) - 1)
    }()
    
    var views: [MyView] = [MyView]()
    var page: Int = 0
    var beganPoint: CGFloat = 0
        
    override func viewDidLoad() {
        super.viewDidLoad()

        DispatchQueue.main.async { [weak self] in
            self?.setupViews()
        }
    }
    
    func setupViews() {
        if imageCount == 0 { return }
        
        for i in 1 ... imageCount {
            let v = MyView()
            v.translatesAutoresizingMaskIntoConstraints = false
            v.tag = i
            
            let h = view.safeAreaLayoutGuide.layoutFrame.size.height / 4
            
            views.append(v)
            stackView.addArrangedSubview(v)
            
            v.addConstraint(NSLayoutConstraint(item: v,
                                               attribute: .height,
                                               relatedBy: .equal,
                                               toItem: nil,
                                               attribute: .height,
                                               multiplier: 1,
                                               constant: h))
        }
        
        setMyViews(page: page, isVisible: true)
    }
    
    func setMyViews(page: Int, isVisible: Bool) {
        let startIndex = page * 4
        let endIndex: Int
        if page != maxPage {
            endIndex = startIndex + 4
        } else {
            let mod = imageCount % 4
            if mod == 0 {
                endIndex = startIndex + 4
            } else {
                endIndex = startIndex + mod
            }
        }
        
        views[startIndex ..< endIndex].forEach({
            $0.isVisible = isVisible
            $0.setNeedsDisplay()
        })
    }
        
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first as UITouch? {
            beganPoint = floor(touch.location(in: view).y)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if imageCount == 0 { return }
        
        if let touch = touches.first as UITouch? {
            let endPoint = floor(touch.location(in: view).y)
            let oldPage = page
            if beganPoint > endPoint {
                // down
                if page == maxPage { return }
                page += 1
            } else {
                // up
                if page == 0 { return }
                page -= 1
            }
                        
            setMyViews(page: page, isVisible: true)
            
            let constant = -(CGFloat(page) * view.safeAreaLayoutGuide.layoutFrame.size.height)
            stackViewTopLayoutConstraint.constant = constant
            
            UIView.animate(withDuration: 0.3) { [weak self] in
                self?.view.layoutIfNeeded()
            } completion: { [weak self] (_) in
                self?.setMyViews(page: oldPage, isVisible: false)
            }
        }
    }
}

