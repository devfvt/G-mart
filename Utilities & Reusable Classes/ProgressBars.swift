
//
//  ProgressBars.swift
//  G-Mart
//
//  Created by Indrajit Chavda on 18/05/19.
//  Copyright © 2019 Indrajit Chavda. All rights reserved.
//

import UIKit



enum HudTheme{
    case theme1
    case theme2
    case theme3
    case theme4
    case theme5
    case theme6
}
class RoundProgress:NSObject{
    
    static var hudContainderSize:CGFloat = 110 // Size of container which holds all stuff
    
    static var hudType:HudTheme = .theme6 // Type of hud
    
    static var rotationLineWidth:CGFloat = 3 // line which is rotating
    
    static var rotaionGapPercentage:CGFloat = 92 // The gap which appears in round rotating line
    
    static var rotationSpeedTime:TimeInterval = 0.9 // Speed of rotation
    static var rotationSizeRatio:CGFloat = 2 // This is the size ration of round rotating line, By default it is half of total hud size that is hudContainderSize
    
    static var rotationLineColor:UIColor = .gray // Color of rotating line
    static var rotationLineGapColor:UIColor = .clear // Color of the gap which appears in round rotating line
    
    static var showNetworkIndicator:Bool = true // At the top or on the status bar there is default network indicator
    
    fileprivate static var isAnimating = false
    
    static let disablerView:UIView={
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        return view
    }()
    static let hudContainder:UIImageView={
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 16
        view.backgroundColor = UIColor.init(white: 0.3, alpha: 0.5)
        return view
    }()
    static var loadingIndicator:UIActivityIndicatorView={
        let loading = UIActivityIndicatorView()
        loading.translatesAutoresizingMaskIntoConstraints = false
        loading.style = .whiteLarge
        loading.backgroundColor = .clear
        loading.layer.cornerRadius = 16
        loading.layer.masksToBounds = true
        return loading
    }()
    
    static var hudTextsLabel:UILabel={
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "Please wait..."
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    static let rotationRoundBackground:UIView={ // This is the view which is containing the rotating line
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    fileprivate static var timerToHideHud:Timer?
    fileprivate static var timerToShowHud:Timer?
    
    @objc class func hideHudAfterDelay(timeInterval:Double){
        
        RoundProgress.timerToShowHud?.invalidate()
        RoundProgress.timerToHideHud = Timer.scheduledTimer(timeInterval: timeInterval, target: RoundProgress.self, selector: #selector(RoundProgress.hide), userInfo: nil, repeats: false)
        
    }
    
    @objc class func hide(){
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        isAnimating = false
        RoundProgress.loadingIndicator.stopAnimating()
        RoundProgress.disablerView.removeFromSuperview()
        timerToHideHud?.invalidate()
        
    }
    
    
    class func showHudAfterDelay(timeInterval:Double,hudTexts:String = "Please wait...",conainerView:Any? = nil)
    {
        RoundProgress.hudTextsLabel.text = hudTexts
        RoundProgress.timerToHideHud?.invalidate()
        
        RoundProgress.timerToShowHud = Timer.scheduledTimer(timeInterval: timeInterval, target: RoundProgress.self, selector: #selector(RoundProgress.showHudAfterDelayWithPatameter), userInfo: ["hudTexts":hudTexts,"view":conainerView], repeats: false)
    }
    
    @objc fileprivate static func showHudAfterDelayWithPatameter(timer:Timer){
        if let userInfo = timer.userInfo as? [String:Any]{
            var conainerView:UIView?
            if let value = userInfo["view"] as? UIView{
                conainerView = value
            }
            if let value = userInfo["hudTexts"] as? String{
                showHud(hudTexts: value, hudConainerView: conainerView)
            }
        }
    }
    
    @objc static func showHud(hudTexts:String = "Please wait...",hudConainerView:UIView? = nil){
        
        RoundProgress.hudTextsLabel.text = hudTexts
        func setUpHudeViews(keyWindow:UIView){
            
            if !isAnimating
            {
                isAnimating = true
                UIApplication.shared.isNetworkActivityIndicatorVisible = showNetworkIndicator
                keyWindow.addSubview(disablerView)
                
                disablerView.rightAnchor.constraint(equalTo: keyWindow.rightAnchor).isActive = true
                disablerView.leftAnchor.constraint(equalTo: keyWindow.leftAnchor).isActive = true
                disablerView.topAnchor.constraint(equalTo: keyWindow.topAnchor).isActive = true
                disablerView.bottomAnchor.constraint(equalTo: keyWindow.bottomAnchor).isActive = true
                RoundProgress.loadingIndicator.startAnimating()
                
                disablerView.addSubview(hudContainder)
                hudContainder.addSubview(hudTextsLabel)
                
                hudContainder.centerXAnchor.constraint(equalTo: disablerView.centerXAnchor).isActive = true
                hudContainder.centerYAnchor.constraint(equalTo: disablerView.centerYAnchor).isActive = true
                hudContainder.widthAnchor.constraint(equalToConstant: hudContainderSize).isActive = true
                hudContainder.heightAnchor.constraint(equalToConstant: hudContainderSize).isActive = true
                
                func showRound(){
                    let roatationViewSize:CGFloat = hudContainderSize/rotationSizeRatio
                    hudContainder.addSubview(rotationRoundBackground)
                    rotationRoundBackground.heightAnchor.constraint(equalToConstant:roatationViewSize).isActive = true
                    rotationRoundBackground.widthAnchor.constraint(equalToConstant:roatationViewSize).isActive = true
                    rotationRoundBackground.layer.masksToBounds = true
                    let halfSize:CGFloat = roatationViewSize/2
                    rotationRoundBackground.layer.cornerRadius = halfSize
                    rotationRoundBackground.centerXAnchor.constraint(equalTo: hudContainder.centerXAnchor).isActive = true
                    rotationRoundBackground.centerYAnchor.constraint(equalTo: hudContainder.centerYAnchor).isActive = true
                    hudTextsLabel.topAnchor.constraint(equalTo: rotationRoundBackground.bottomAnchor, constant: 5).isActive = true
                    
                    func getShapeLayer(color:UIColor,view:UIView,gap:Double){
                        let circlePath = UIBezierPath(
                            arcCenter: CGPoint(x:halfSize,y:halfSize),
                            radius: CGFloat( halfSize - (rotationLineWidth/2)),
                            startAngle: CGFloat(0),
                            endAngle:CGFloat(Double.pi * gap),
                            clockwise: true)
                        let shapeLayer = CAShapeLayer()
                        shapeLayer.path = circlePath.cgPath
                        shapeLayer.fillColor = UIColor.clear.cgColor
                        shapeLayer.strokeColor = color.cgColor
                        shapeLayer.lineWidth = rotationLineWidth
                        view.layer.addSublayer(shapeLayer)
                    }
                    
                    getShapeLayer(color: rotationLineGapColor, view: rotationRoundBackground,gap: 2)
                    getShapeLayer(color: rotationLineColor, view: rotationRoundBackground,gap: (Double((rotaionGapPercentage * 2)/100)))
                    let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
                    rotateAnimation.fromValue = 0.0
                    rotateAnimation.toValue = CGFloat(Double.pi * 2)
                    rotateAnimation.isRemovedOnCompletion = false
                    rotateAnimation.duration = rotationSpeedTime
                    rotateAnimation.repeatCount = Float.infinity
                    rotationRoundBackground.layer.add(rotateAnimation, forKey: nil)
                }
                
                switch hudType{
                case .theme1:
                    rotationLineColor = UIColor.blue.withAlphaComponent(0.5)
                    self.hudTextsLabel.isHidden = true
                    hudContainder.backgroundColor = .clear
                    self.disablerView.backgroundColor = .white
                    showRound()
                case .theme2:
                    rotationLineColor = UIColor.blue.withAlphaComponent(0.5)
                    self.hudTextsLabel.textColor = rotationLineColor.withAlphaComponent(1)
                    self.hudTextsLabel.isHidden = false
                    hudContainder.backgroundColor = .clear
                    showRound()
                case .theme3:
                    rotationLineColor = UIColor.blue.withAlphaComponent(0.5)
                    self.hudTextsLabel.textColor = rotationLineColor.withAlphaComponent(1)
                    self.hudTextsLabel.isHidden = false
                    hudContainder.backgroundColor = UIColor.lightGray
                    showRound()
                case .theme4:
                    rotationLineColor = UIColor.blue.withAlphaComponent(0.5)
                    self.hudTextsLabel.textColor = rotationLineColor.withAlphaComponent(1)
                    self.hudTextsLabel.isHidden = true
                    hudContainder.backgroundColor = UIColor.lightGray
                    showRound()
                case .theme5:
                    hudContainder.addSubview(loadingIndicator)
                    loadingIndicator.centerXAnchor.constraint(equalTo: hudContainder.centerXAnchor).isActive = true
                    loadingIndicator.centerYAnchor.constraint(equalTo: hudContainder.centerYAnchor).isActive = true
                    hudTextsLabel.topAnchor.constraint(equalTo: loadingIndicator.bottomAnchor, constant: 5).isActive = true
                case .theme6:
                    hudContainder.backgroundColor = .clear
                    self.hudTextsLabel.isHidden = true
                    hudContainder.addSubview(loadingIndicator)
                    loadingIndicator.centerXAnchor.constraint(equalTo: hudContainder.centerXAnchor).isActive = true
                    loadingIndicator.centerYAnchor.constraint(equalTo: hudContainder.centerYAnchor).isActive = true
                    hudTextsLabel.topAnchor.constraint(equalTo: loadingIndicator.bottomAnchor, constant: 5).isActive = true
                }
                
                
                
                hudTextsLabel.rightAnchor.constraint(equalTo: hudContainder.rightAnchor, constant: -3).isActive = true
                hudTextsLabel.leftAnchor.constraint(equalTo: hudContainder.leftAnchor, constant: 3).isActive = true
                hudTextsLabel.bottomAnchor.constraint(equalTo: hudContainder.bottomAnchor, constant: -5).isActive = true
                
            }
            
        }
        
        if let superView = hudConainerView{
            setUpHudeViews(keyWindow: superView)
        }else if let keyWindow = UIViewController.getVisibleViewController(nil) {
            setUpHudeViews(keyWindow: keyWindow.view)
        }
    }
    
}



class LineProgress{
    
    fileprivate static var isAnimating = false
    static var showNetworkIndicator = true
    static let lineView:UIView={
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .blue
        return view
    }()
    
    
    static let disablerView:UIView={
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.black.withAlphaComponent(0.1)
        return view
    }()
    static var topAnchorOfLineView:NSLayoutConstraint!
    static func show(onView:UIView? = nil){
        DispatchQueue.main.async {
            if !isAnimating{
                isAnimating = true
                
                if UIApplication.hasTopNotch{
                    RoundProgress.showHud()
                    return
                }
                
                let sizeOfLineView:CGFloat = 3
                if let view = onView{
                    view.addSubview(disablerView)
                    disablerView.setFullOnSuperView()
                    view.addSubview(lineView)
                    lineView.setHeight(height: sizeOfLineView)
                    lineView.setAnchors(top: view.topAnchor, bottom: nil, left: view.leftAnchor, right: view.rightAnchor)
                    
                    
                }else{
                    if let vc = UIViewController.getVisibleViewController(nil){
                        vc.view.addSubview(disablerView)
                        disablerView.setFullOnSuperView()
                        
                        if let navView = vc.navigationController?.navigationBar,!navView.isHidden{
                            navView.addSubview(lineView)
                            lineView.setAnchors(top: navView.bottomAnchor, bottom: nil, left: navView.leftAnchor, right: navView.rightAnchor, topConstant: -(sizeOfLineView/2), bottomConstant: 0, leftConstant: 0, rightConstant: 0)
                            
                        }else if let view = vc.view{
                            let pad = UIDevice.current.userInterfaceIdiom == .pad
                            if let statusBar = UIApplication.shared.value(forKey: "statusBarWindow") as? UIWindow{
                                statusBar.addSubview(lineView)
                                let isLandscape = (UIDevice.current.orientation == .landscapeLeft || UIDevice.current.orientation == .landscapeRight)
                                
                                lineView.setAnchors(top: nil, bottom: nil, left: statusBar.leftAnchor, right: statusBar.rightAnchor, topConstant: -(sizeOfLineView/2), bottomConstant: 0, leftConstant: 0, rightConstant: 0)
                                
                                topAnchorOfLineView = lineView.topAnchor.constraint(equalTo: statusBar.topAnchor, constant: pad ? 20 : (isLandscape ? 0 : 20))
                                topAnchorOfLineView?.isActive = true
                                if !pad{
                                    NotificationCenter.default.removeObserver(self, name: UIDevice.orientationDidChangeNotification, object: nil)
                                    NotificationCenter.default.addObserver(self, selector: #selector(rotated), name: UIDevice.orientationDidChangeNotification, object: nil)
                                }
                            }else{
                                view.addSubview(lineView)
                                lineView.setAnchors(top:  view.topAnchor, bottom: nil, left: view.leftAnchor, right: view.rightAnchor, topConstant: 0, bottomConstant: 0, leftConstant: 0, rightConstant: 0)
                                
                            }
                        }
                        lineView.setHeight(height: sizeOfLineView)
                    }
                }
                
                UIApplication.shared.isNetworkActivityIndicatorVisible = showNetworkIndicator
                let color = CABasicAnimation(keyPath: "borderColor")
                let colorTopForMainView = UIColor(red: 31.0 / 255.0, green: 139.0 / 255.0, blue: 208.0 / 255.0, alpha: 1.0).cgColor
                let colorBottomForMainView = UIColor.white.cgColor//UIColor(red: 7.0 / 255.0, green: 106.0 / 255.0, blue: 200 / 255.0, alpha: 1.0).cgColor
                color.fromValue = colorTopForMainView
                color.toValue = colorBottomForMainView
                color.duration = 0.8
                color.repeatCount = Float.greatestFiniteMagnitude
                color.autoreverses = true
                lineView.layer.borderWidth = sizeOfLineView
                lineView.layer.borderColor = UIColor.blue.cgColor
                lineView.layer.add(color, forKey: "borderColor")
            }
        }
        
    }
    
    @objc static func rotated(){
        let isLandscape = (UIDevice.current.orientation == .landscapeLeft || UIDevice.current.orientation == .landscapeRight)
        topAnchorOfLineView?.constant = isLandscape ? 0 : 20
    }
    
    static func hide(){
        
        NotificationCenter.default.removeObserver(self, name: UIDevice.orientationDidChangeNotification, object: nil)
        DispatchQueue.main.async {
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            isAnimating = false
            lineView.layer.removeAllAnimations()
            lineView.removeFromSuperview()
            disablerView.removeFromSuperview()
            topAnchorOfLineView = nil
            
            if UIApplication.hasTopNotch{
                RoundProgress.hide()
                return
            }
        }
        
    }
    
}



class CircularProgress: UIView {
    
    fileprivate var progressLayer = CAShapeLayer()
    fileprivate var tracklayer = CAShapeLayer()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createCircularPath()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        createCircularPath()
    }
    
    var progressColor:UIColor = UIColor.red {
        didSet {
            progressLayer.strokeColor = progressColor.cgColor
        }
    }
    
    var trackColor:UIColor = UIColor.white {
        didSet {
            tracklayer.strokeColor = trackColor.cgColor
        }
    }
    
    fileprivate func createCircularPath() {
        self.layer.cornerRadius = self.frame.size.width/2.0
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: frame.size.width / 2.0, y: frame.size.height / 2.0),
                                      radius: (frame.size.width - 1.5)/2, startAngle: CGFloat(-0.5 * Double.pi),
                                      endAngle: CGFloat(1.5 * Double.pi), clockwise: true)
        
        tracklayer.path = circlePath.cgPath
        tracklayer.fillColor = UIColor.clear.cgColor
        tracklayer.strokeColor = trackColor.cgColor
        tracklayer.lineWidth = 2.0
        tracklayer.strokeEnd = 1.0
        layer.addSublayer(tracklayer)
        
        progressLayer.path = circlePath.cgPath
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.strokeColor = progressColor.cgColor
        progressLayer.lineWidth = 2.0
        progressLayer.strokeEnd = 0.0
        layer.addSublayer(progressLayer)
        
    }
    
    func setProgressWithAnimation(duration: TimeInterval, fromVal: CGFloat,toVal: CGFloat) {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.duration = duration
        // Animate from 0 (no circle) to 1 (full circle)
        animation.fromValue = fromVal
        animation.toValue = toVal
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        progressLayer.strokeEnd = toVal
        progressLayer.add(animation, forKey: "animateCircle")
    }
    
}
