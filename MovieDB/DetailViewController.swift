//
//  DetailViewController.swift
//  MovieDB
//
//  Created by Mac on 2018/7/29.
//  Copyright © 2018年 Link. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    // MARK: - Designated Initializer
    fileprivate let posterImage: UIImageView = {
        let imageView = UIImageView()
        return imageView;
    }()
    
    fileprivate(set) lazy var titleLabel: UILabel = {
        let label = UILabel(frame: CGRect.zero)
        label.textColor = UIColor.black
        return label
    }()
    
    fileprivate(set) lazy var releaseDateLabel: UILabel = {
        let label = UILabel(frame: CGRect.zero)
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 10)
        return label
    }()
    
    fileprivate(set) lazy var popularityLabel: UILabel = {
        let label = UILabel(frame: CGRect.zero)
        label.textColor = UIColor.white
        label.backgroundColor = UIColor.blue
        label.textAlignment = .center
        return label
    }()
    fileprivate(set) lazy var overviewLabel: UILabel = {
        let label = UILabel(frame: CGRect.zero)
        label.textColor = UIColor.black
        label.numberOfLines = 3
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    fileprivate(set) lazy var genresTitleLabel: UILabel = {
        let label = UILabel(frame: CGRect.zero)
        label.textColor = UIColor.black
        label.text = "Genres"
        return label
    }()
    
    fileprivate(set) lazy var languageLabel: UILabel = {
        let label = UILabel(frame: CGRect.zero)
        label.textColor = UIColor.black
        return label
    }()
    
    fileprivate(set) lazy var durationLabel: UILabel = {
        let label = UILabel(frame: CGRect.zero)
        label.textColor = UIColor.black
        return label
    }()
    
    var movieOverview:MovieOverview?
    var movie:Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        view.addSubview(posterImage)
        view.addSubview(titleLabel)
        view.addSubview(releaseDateLabel)
        view.addSubview(popularityLabel)
        view.addSubview(overviewLabel)
        view.addSubview(genresTitleLabel)
        view.addSubview(languageLabel)
        view.addSubview(durationLabel)
        updateOverViewData()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateOverViewData() {
        guard let overview = movieOverview else {
            return
        }
    
        titleLabel.text = overview.title
        releaseDateLabel.text = overview.releaseDate
        popularityLabel.text = String(format: "%.1f",  overview.popularity)
    
        overviewLabel.text = overview.overview
        let photoUrl = URL.getDetailPhotoURL(overview.posterPath!)
        posterImage.kf.setImage(with:photoUrl)
    
        
        posterImage.contentMode = UIViewContentMode.scaleAspectFit
        getMovieDetail()
    }
    
    override func viewDidLayoutSubviews() {
      
        super.viewDidLayoutSubviews()
    
        posterImage.snp.makeConstraints { (make) in
            make.top.equalTo(view).offset(50)
            make.leading.equalTo(view).offset(10)
            make.trailing.equalTo(view).offset(10)
            make.height.equalTo(300)
        }
        
        popularityLabel.snp.makeConstraints { (make) in
            make.top.equalTo(posterImage.snp.bottom).offset(10)
            make.leading.equalTo(view).offset(10)
            make.height.equalTo(30)
            make.width.equalTo(30)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(popularityLabel)
            make.leading.equalTo(popularityLabel.snp.trailing).offset(5)
            make.trailing.equalTo(view)
            make.height.equalTo(30)
        }
        
        releaseDateLabel.snp.makeConstraints{ (make) in
            make.top.equalTo(popularityLabel.snp.bottom).offset(5)
            make.leading.equalTo(popularityLabel)
            make.trailing.equalTo(view)
            make.height.equalTo(12)
        }
        overviewLabel.snp.makeConstraints{ (make) in
            make.top.equalTo(releaseDateLabel.snp.bottom)
            make.leading.equalTo(popularityLabel)
            make.trailing.equalTo(view)
            make.height.equalTo(100)
        }
        genresTitleLabel.snp.makeConstraints{ (make) in
            make.top.equalTo(overviewLabel.snp.bottom)
            make.leading.equalTo(popularityLabel)
            make.trailing.equalTo(view)
            make.height.equalTo(20)
        }
        durationLabel.snp.makeConstraints{ (make) in
            make.top.equalTo(genresTitleLabel.snp.bottom)
            make.leading.equalTo(popularityLabel)
            make.trailing.equalTo(view)
            make.height.equalTo(20)
        }
        languageLabel.snp.makeConstraints{ (make) in
            make.top.equalTo(durationLabel.snp.bottom)
            make.leading.equalTo(popularityLabel)
            make.trailing.equalTo(view)
            make.height.equalTo(20)
        }
    }
    
    func getMovieDetail() {
        //hud.show()
        guard let overview = movieOverview else {
            return
        }
        MovieApi.getMovieDetail( overview.movieId) { result in
            do {
                self.movie = try result.unwrap()
                self.updateData()
            } catch let error as NSError {
                
                debugPrint("getDiscoverMovie error: \(error.localizedDescription)")
            }
            //self.hud.hide()
        }
    }
    func updateData() {
        guard let data = movie else {
            return
        }
        
        durationLabel.text = String(data.runtime)
        var genreslist = "Genres:"
        for genre in data.genres{
            genreslist = genreslist + " " + genre.name
        }
        genresTitleLabel.text = genreslist
        languageLabel.text = data.originalLanguage
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
