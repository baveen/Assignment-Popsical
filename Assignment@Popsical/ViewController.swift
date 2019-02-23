//
//  ViewController.swift
//  Assignment@Popsical
//
//  Created by Baveendran Nagendran on 2/23/19.
//  Copyright © 2019 rbsolutions. All rights reserved.
//

import UIKit

let cellIdentifier: String = "CellIdentifier"

class ViewController: UIViewController {

    var tracks: [Track] = []

    var songsTableView: UITableView = {
        let tblView = UITableView()
        tblView.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        tblView.separatorStyle = .none
        tblView.register(SongsCell.self, forCellReuseIdentifier: cellIdentifier)
        return tblView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        getData()

        view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        songsTableView.delegate = self
        songsTableView.dataSource = self
        configureViews()

    }

    func configureViews() {
        
        view.addSubview(songsTableView)
        songsTableView.translatesAutoresizingMaskIntoConstraints =  false
        
        songsTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        songsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        songsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        songsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tracks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! SongsCell
        let track = tracks[indexPath.row]
        cell.updateCell(with: track, at: cell)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func getData(){
        
        WebServiceManager.sharedInstance.fetchSongDetails(forPage:WebServiceManager.sharedInstance.pageNumber, completionBlock: {[weak self] (songs) in
            self?.tracks = songs
            DispatchQueue.main.async {
                self?.songsTableView.reloadData()
                //self?.songsTableView.isHidden = false
            }
            }, errorBlock: {
                error in
                print(error?.localizedDescription)
        })
    }
    
}
