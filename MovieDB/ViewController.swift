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
    private var currentPage:Int = 1
    private var maxPage:Int = Int(INT_MAX)
    private var isLoading = false
    
    fileprivate lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = UIColor(red:0.25, green:0.72, blue:0.85, alpha:1.0)
        return refreshControl
    }()
    
    fileprivate lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle:
            .gray)
        return activityIndicator
    }()
    
    
    fileprivate lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = UIColor.white
        tableView.rowHeight = 138
        tableView.tableFooterView = UIView()
        tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: MovieTableViewCell.description())
        tableView.dataSource = self
        tableView.delegate = self
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.addSubview(refreshControl)
        }
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        view.addSubview(activityIndicator)
        
        getDiscoverDefault()
        refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
        activityIndicator.center = view.center
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func getDiscoverDefault(){
        getDiscoverMovie(releaseDate: DefaultDiscoverDay, sortBy: DefaultSortBy, page: 1)
    }
    
    func getDiscoverLoadMore(){
        getDiscoverMovie(releaseDate: DefaultDiscoverDay, sortBy: DefaultSortBy, page: currentPage + 1)
    }
    
    @objc func refreshData(_ sender: Any){
        self.movies.removeAll()
        maxPage = Int(INT_MAX)
        currentPage = 1
        getDiscoverDefault()
    }
    
    func getDiscoverMovie(releaseDate:String, sortBy:String, page:Int) {
        
        if (isLoading) {
            return
        }
        if (page > maxPage) {
            return
        }
        isLoading = true
        activityIndicator.startAnimating()
        MovieApi.getDiscoverMovie( releaseDate, sortBy:sortBy, page: page) { result in
            do {
                self.movieDiscover = try result.unwrap()
                if let movieResult = self.movieDiscover {
                    if ( page > movieResult.page) {
                        self.maxPage = movieResult.page
                        return
                    }
                    
                    self.movies.append(contentsOf:movieResult.movies)
                    self.currentPage = movieResult.page
                }
                self.refreshControl.endRefreshing()
                self.tableView.reloadData()
                self.isLoading = false
                self.activityIndicator.stopAnimating()
            } catch let error as NSError {
                self.isLoading = false
                self.activityIndicator.stopAnimating()
                debugPrint("getDiscoverMovie error: \(error.localizedDescription)")
            }
            
        }
    }
    func gotoDetail(movie:MovieOverview) {
       let detailView = DetailViewController()
        detailView.movieOverview = movie
       
        self.navigationController?.pushViewController(detailView, animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if tableView.contentOffset.y >= (tableView.contentSize.height - tableView.frame.size.height) {
            getDiscoverLoadMore()
        }
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
