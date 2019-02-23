//
//  SongsCell.swift
//  Assignment@Popsical
//
//  Created by Baveendran Nagendran on 2/23/19.
//  Copyright © 2019 rbsolutions. All rights reserved.
//

import UIKit

class SongsCell: UITableViewCell {

    var trackImageView: UIImageView = {
        let imv = UIImageView()
        imv.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        imv.contentMode = .scaleAspectFill
        imv.clipsToBounds = true
        return imv
    }()
    
    var trackNameLabel: UILabel = {
        let trackName = UILabel()
        return trackName
    }()
    
    var artistNameLabel: UILabel = {
        let artistName = UILabel()
        return artistName
    }()
    
    private var labelHolderStackView: UIStackView = {
        let labelHolder = UIStackView()
        labelHolder.axis = .vertical
        labelHolder.distribution = .fillEqually
        return labelHolder
    }()
    
    private var holderStackView: UIStackView = {
        let holder = UIStackView()
        holder.axis = .horizontal
        holder.spacing = 16
        return holder
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
        customize(label: trackNameLabel)
        customize(label: artistNameLabel)
        
        contentView.addSubview(holderStackView)
        holderStackView.addArrangedSubview(trackImageView)
        holderStackView.addArrangedSubview(labelHolderStackView)
        labelHolderStackView.addArrangedSubview(trackNameLabel)
        labelHolderStackView.addArrangedSubview(artistNameLabel)
        
        holderStackView.translatesAutoresizingMaskIntoConstraints = false
        holderStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8).isActive = true
        holderStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8).isActive = true
        holderStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
        holderStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8).isActive = true
        
        trackImageView.translatesAutoresizingMaskIntoConstraints = false
        labelHolderStackView.translatesAutoresizingMaskIntoConstraints = false
        
        trackImageView.widthAnchor.constraint(equalTo: trackImageView.heightAnchor).isActive = true
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        trackImageView.image = nil
        trackNameLabel.text = nil
        artistNameLabel.text = nil
    }
    
    func updateCell(with track: Track, at cell: SongsCell) {
        
        cell.trackNameLabel.text = "Track Name: \(track.title!)"
        
        DispatchQueue.global().async {[weak self] in
            
            if let urlString = track.imageURL {
                
                if let url = URL(string: urlString) {
                    if let data = try? Data(contentsOf: url) {
                        let image = UIImage(data: data)
                        
                        DispatchQueue.main.async {
                            self?.trackImageView.image = image
                        }
                    }else {
//                        DispatchQueue.main.async {
//                            self?.trackImageView.image = image
//                        }

                    }
                
            }
           
        }
    }
}
    
    
    func customize(label: UILabel) {
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 12)
    }


}
