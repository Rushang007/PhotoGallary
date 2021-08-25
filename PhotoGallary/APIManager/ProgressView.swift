//
//  ProgressView.swift
//  PhotoGallary
//
//  Created by Rushang Patel (iOS Developer) on 25/08/21.
//

import Foundation
class ProgressView {
    
    // MARK: - Variables
    private var containerView = UIView()
    private var progressView = UIView()
    private var activityIndicator = UIActivityIndicatorView()
    static var shared = ProgressView()
    
    // To close for instantiation
    private init() {}
    
    // MARK: - Functions
    func startAnimating(view: UIView) {
        containerView.center = view.center
        containerView.frame = view.frame
        containerView.backgroundColor = UIColor.black.withAlphaComponent(0.1)
        
        progressView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        progressView.center = containerView.center
        progressView.backgroundColor = .gray.withAlphaComponent(0.6)
        progressView.clipsToBounds = true
        progressView.layer.cornerRadius = 10
        
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 60, height: 60)
        activityIndicator.center = CGPoint(x: progressView.bounds.width/2, y: progressView.bounds.height/2)
        
        if #available(iOS 13.0, *) {
            activityIndicator.style = .large
        } else {
            activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.whiteLarge)
        }
        
        activityIndicator.color = .white
        view.addSubview(containerView)
        containerView.addSubview(progressView)
        progressView.addSubview(activityIndicator)
        
        activityIndicator.startAnimating()
    }
    
    /// animate UIActivityIndicationView without blocking UI
    func startSmoothAnimation(view: UIView) {
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 60, height: 60)
        activityIndicator.center = view.center
        if #available(iOS 13.0, *) {
            activityIndicator.style = .large
        } else {
            activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.whiteLarge)
        }
        activityIndicator.color = UIColor.gray
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
    }
    
    func stopAnimatimating() {
        activityIndicator.stopAnimating()
        containerView.removeFromSuperview()
    }
 
}
