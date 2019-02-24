//
//  LoadingCell.swift
//  Assignment@Popsical
//
//  Created by Baveendran Nagendran on 2/23/19.
//  Copyright © 2019 rbsolutions. All rights reserved.
//

import UIKit

class LoadingCell: UITableViewCell {
    
    private var downloadingFaild: Bool = false
    
    var downloadFailed: Bool {
        get {
            return downloadingFaild
        }
        set {
            
            if newValue {
                activityIndicator.stopAnimating()
            }else{
                activityIndicator.startAnimating()
            }
            
            downloadingFaild = newValue
        }
    }
    
    let activityIndicator: UIActivityIndicatorView = {
        let customView = UIActivityIndicatorView(style: .gray)
        customView.translatesAutoresizingMaskIntoConstraints = false
        return customView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureCell()
    }
    
    
    func configureCell(){
        contentView.addSubview(activityIndicator)
       
        activityIndicator.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        activityIndicator.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        activityIndicator.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        activityIndicator.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
        self.downloadFailed = false;

    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.downloadFailed = false
    }
    
}
