//
//  ViewController.swift
//  Assignment@Popsical
//
//  Created by Baveendran Nagendran on 2/23/19.
//  Copyright © 2019 rbsolutions. All rights reserved.
//

import UIKit

let songCellIdentifier: String = "SongCellIdentifier"
let loadingCellIdentifier: String = "LoadingCellIdentifier"


class ViewController: UIViewController {
    
    var tracks = [Track]()
    
    var songsTableView: UITableView = {
        let tblView = UITableView()
        tblView.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        tblView.separatorStyle = .none
        tblView.register(SongsCell.self, forCellReuseIdentifier: songCellIdentifier)
        tblView.register(LoadingCell.self, forCellReuseIdentifier: loadingCellIdentifier)
        
        return tblView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadSongs()
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
    
    func displayAlert(with message: String){
        
        let alertController = UIAlertController(title: "Error!", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) { (action) in
            self.songsTableView.isHidden = true
        }
        alertController.addAction(action)
        self.present(alertController, animated: false, completion: nil)
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UIScrollViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tracks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if(indexPath.row == tracks.count-1){
            loadSongs()
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: songCellIdentifier, for: indexPath) as! SongsCell
        prepare(cell: cell, at: indexPath)
        return cell
        
    }
    
    func prepare(cell: SongsCell, at indexPath: IndexPath){
        DispatchQueue.main.async {
            let track = self.tracks[indexPath.row]
            if let cellForTrack = self.songCell(for: track.id) {
                cellForTrack.updateCell(with: track, at: cell)
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func songCell(for id: Int)-> SongsCell? {
        
        var cell: SongsCell?
        
        if  let tk = track(for: id) {
            let index = self.tracks.firstIndex(where: {$0.id == tk.id})
            let indxpath = IndexPath(row: index!, section: 0)
            cell = songsTableView.cellForRow(at: indxpath) as? SongsCell
            
        }
        
        return cell
    }
    
    func track(for id: Int) -> Track?{
        var findingTrack: Track?
        for tk in self.tracks {
            if tk.id == id {
                findingTrack = tk
            }
        }
        
        return findingTrack
    }
    
    func loadSongs(){
        
        WebServiceManager.sharedInstance.pageNumber += 1
        WebServiceManager.sharedInstance.fetchSongDetails(forPage:WebServiceManager.sharedInstance.pageNumber, completionBlock: {[weak self] (songs) in
            self?.tracks.append(contentsOf: songs)
            DispatchQueue.main.async {
                self?.songsTableView.reloadData()
            }
            }, errorBlock: {
                error in
                print(error?.localizedDescription)
        })
        
    }
    
}

