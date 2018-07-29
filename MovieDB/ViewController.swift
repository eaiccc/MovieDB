//
//  ViewController.swift
//  MovieDB
//
//  Created by Mac on 2018/7/27.
//  Copyright © 2018年 Link. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    fileprivate var movieDiscover: DiscoverMovie?
    fileprivate var movies: Array<MovieOverview> = Array<MovieOverview>()
    fileprivate lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = UIColor.white
        tableView.rowHeight = 138
        tableView.tableFooterView = UIView()
        tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: MovieTableViewCell.description())
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        getDiscoverDefault()
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func getDiscoverDefault(){
        getDiscoverMovie(releaseDate: "2017-07-31", sortBy: "release_date.desc", page: 1)
    }
    
    func getDiscoverMovie(releaseDate:String, sortBy:String, page:Int) {
        //hud.show()
        MovieApi.getDiscoverMovie( releaseDate, sortBy:sortBy, page: page) { result in
            do {
                self.movieDiscover = try result.unwrap()
                if let movieResult = self.movieDiscover {
                    self.movies.append(contentsOf:movieResult.movies)
                }
                self.tableView.reloadData()
            } catch let error as NSError {
                
                debugPrint("getDiscoverMovie error: \(error.localizedDescription)")
            }
            //self.hud.hide()
        }
    }
    func gotoDetail(movie:MovieOverview) {
        self.navigationController?.pushViewController(DetailViewController(), animated: true)
    }
    
}
// MARK: - Table View Data Source
extension ViewController: UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.movies.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.description(), for: indexPath) as? MovieTableViewCell else {
            
            return UITableViewCell()
        }
        let movie = movies[indexPath.row]
        cell.updateData(movie: movie)
        //cell.imageView?.image = UIImage(named: "UserNoAvatar")
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
        cell.preservesSuperviewLayoutMargins = false
        cell.backgroundColor = UIColor.white
        
        return cell
    }
}

// MARK: - Table View Delegate
extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
            tableView.deselectRow(at: indexPath, animated: true)
            let movie = movies[(indexPath as NSIndexPath).row]
            gotoDetail(movie: movie)
        
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return MovieTableViewCell.cellHeight()
    }

    
}
