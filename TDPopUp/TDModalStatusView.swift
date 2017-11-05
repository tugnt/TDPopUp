//
//  TDModalStatusView.swift
//  TDPopUp
//
//  Created by Nguyen Trong Tung on 2017/11/05.
//  Copyright © 2017 Nguyen Trong Tung. All rights reserved.
//

import UIKit

public class TDModalStatusView: UIView {
    var contentView: UIView!
    let nibName = "TDModalStatusView"
    var timer: Timer?
    @IBOutlet private weak var statusImage: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var subTitleLabel: UILabel!
    
    // MARK: Set up view use in code
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }
    
    // MARK: Setup view create by interface builder
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpView()
    }
    
    private func setUpView() {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: self.nibName, bundle: bundle)
        self.contentView = nib.instantiate(withOwner: self, options: nil).first as! UIView
        addSubview(contentView)
       
        contentView.center = self.center
        contentView.autoresizingMask = []
        contentView.translatesAutoresizingMaskIntoConstraints = true
        contentView.alpha = 0.0
        
        titleLabel.text = ""
        subTitleLabel.text = ""
    }
    
    // Provide func setup view
    public func setStatusImage(image: UIImage) {
        self.statusImage.image = image
    }
    
    public func setTitleLabel(title: String) {
        self.titleLabel.text = title
    }
    
    public func setSubTitleLabel(subTitle: String) {
        self.subTitleLabel.text = subTitle
    }
    
    // Allow view controller ifself
    public override func layoutSubviews() {
        self.layoutIfNeeded()
        self.contentView.clipsToBounds = true
        self.contentView.layer.cornerRadius = 10
        self.contentView.layer.masksToBounds = true
    }
    
    // This function call when add into super view
    public override func didMoveToSuperview() {
        self.contentView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        UIView.animate(withDuration: 0.15, animations: {
            self.contentView.alpha = 1.0
            self.contentView.transform = .identity
        }) { _ in
            self.timer = Timer.scheduledTimer(timeInterval: TimeInterval(1.5), target: self, selector: #selector(self.removePopUp), userInfo: nil, repeats: false)
        }
    }
    
    @objc func removePopUp() {
        UIView.animate(withDuration: 0.15, animations: {
            self.contentView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            self.contentView.alpha = 0.0
        }) { _ in
            self.removeFromSuperview()
        }
    }
}
