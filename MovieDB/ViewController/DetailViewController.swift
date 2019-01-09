//
//  DetailViewController.swift
//  MovieDB
//
//  Created by Mac on 2018/7/29.
//  Copyright © 2018年 Link. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UIScrollViewDelegate {
    // MARK: - Designated Initializer
    fileprivate let posterImage: UIImageView = {
        let imageView = UIImageView()
        return imageView;
    }()
    
    fileprivate let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.isScrollEnabled = true
        return scroll;
    }()
    
    fileprivate let contentView: UIView = {
        let view = UIView()
        return view;
    }()
    fileprivate let dataView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        return view;
    }()
    fileprivate(set) lazy var titleLabel: UILabel = {
        let label = UILabel(frame: CGRect.zero)
        label.textColor = UIColor.white
        return label
    }()
    
    fileprivate(set) lazy var releaseDateLabel: UILabel = {
        let label = UILabel(frame: CGRect.zero)
        label.textColor = UIColor.white
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
        label.textColor = UIColor.white
        label.numberOfLines = 5
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    fileprivate(set) lazy var genresTitleLabel: UILabel = {
        let label = UILabel(frame: CGRect.zero)
        label.textColor = UIColor.white
        label.text = "Genres"
        return label
    }()
    
    fileprivate(set) lazy var languageLabel: UILabel = {
        let label = UILabel(frame: CGRect.zero)
        label.textColor = UIColor.white
        return label
    }()
    
    fileprivate(set) lazy var durationLabel: UILabel = {
        let label = UILabel(frame: CGRect.zero)
        label.textColor = UIColor.white
        return label
    }()
    
    fileprivate(set) lazy var bookButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.blue
        button.setTitle("Book", for: UIControlState())
        button.setTitleColor(UIColor.white, for: UIControlState())
        return button
    }()
    
    var isAddBlur:Bool = false
    var movieOverview:MovieOverview?
    var movie:Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        isAddBlur = false
        view.backgroundColor = UIColor.white
        view.addSubview(posterImage)
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(dataView)
        dataView.addSubview(titleLabel)
        dataView.addSubview(releaseDateLabel)
        dataView.addSubview(popularityLabel)
        dataView.addSubview(overviewLabel)
        dataView.addSubview(genresTitleLabel)
        dataView.addSubview(languageLabel)
        dataView.addSubview(durationLabel)
        dataView.addSubview(bookButton)
        scrollView.delegate = self
        updateOverViewData()
        addConstraints()
//        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
//        self.navigationController?.navigationBar.shadowImage = UIImage()
//        self.navigationController?.navigationBar.isTranslucent = true
        
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
        popularityLabel.text = overview.popularityString
        overviewLabel.text = overview.overview
        let path = (overview.posterPath != nil) ? overview.posterPath : overview.backdropPath
        let photoUrl = URL.getDetailPhotoURL(path!)
        let image = UIImage.init(named: "imagenotavailable")
        posterImage.kf.setImage(with: photoUrl, placeholder: image)
        posterImage.contentMode = UIViewContentMode.scaleAspectFill
        
        getMovieDetail()
        
    }
    
    func addConstraints(){
        posterImage.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
        scrollView.snp.makeConstraints { (make) in
            make.top.equalTo(view)
            make.leading.equalTo(view)
            make.trailing.equalTo(view)
            make.bottom.equalTo(view)
        }
        contentView.snp.makeConstraints { (make) in
            make.edges.equalTo(scrollView)
            make.width.equalTo(view)
            make.bottom.equalTo(dataView.snp.bottom)
        }
        dataView.snp.makeConstraints { (make) in
            make.top.equalTo(contentView.snp.top).offset(700)
            make.width.equalTo(view)
            make.bottom.equalTo(bookButton.snp.bottom).offset(10)
        }
        
        popularityLabel.snp.makeConstraints { (make) in
            make.top.equalTo(dataView.snp.top).offset(10)
            make.leading.equalTo(contentView).offset(10)
            make.height.equalTo(30)
            make.width.equalTo(30)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(popularityLabel)
            make.leading.equalTo(popularityLabel.snp.trailing).offset(5)
            make.trailing.equalTo(contentView)
            make.height.equalTo(30)
        }
        
        releaseDateLabel.snp.makeConstraints{ (make) in
            make.top.equalTo(popularityLabel.snp.bottom).offset(5)
            make.leading.equalTo(popularityLabel)
            make.trailing.equalTo(contentView)
            make.height.equalTo(12)
        }
        overviewLabel.snp.makeConstraints{ (make) in
            make.top.equalTo(releaseDateLabel.snp.bottom)
            make.leading.equalTo(popularityLabel)
            make.trailing.equalTo(contentView)
            make.height.equalTo(100)
        }
        genresTitleLabel.snp.makeConstraints{ (make) in
            make.top.equalTo(overviewLabel.snp.bottom)
            make.leading.equalTo(popularityLabel)
            make.trailing.equalTo(contentView)
            make.height.equalTo(20)
        }
        durationLabel.snp.makeConstraints{ (make) in
            make.top.equalTo(genresTitleLabel.snp.bottom)
            make.leading.equalTo(popularityLabel)
            make.trailing.equalTo(contentView)
            make.height.equalTo(20)
        }
        languageLabel.snp.makeConstraints{ (make) in
            make.top.equalTo(durationLabel.snp.bottom)
            make.leading.equalTo(popularityLabel)
            make.trailing.equalTo(contentView)
            make.height.equalTo(20)
        }
        bookButton.snp.makeConstraints{ (make) in
            make.top.equalTo(languageLabel.snp.bottom).offset(20)
            make.centerX.equalTo(contentView)
            make.height.equalTo(28)
            make.width.equalTo(100)
        }
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
    }
    override func viewDidLayoutSubviews() {
      
        super.viewDidLayoutSubviews()
        bookButton.addTarget(self, action: #selector(bookButtonClicked(_:)), for: .touchUpInside)

    }
    
    @objc func bookButtonClicked(_ sender: UIButton) {
        let bookVc = BookMovieViewController()
        bookVc.movie = movie
        self.navigationController?.pushViewController(bookVc, animated: true)
    }
    
    func getMovieDetail() {
        guard let overview = movieOverview else {
            return
        }
        MovieApi.getMovieDetail( overview.movieId) { [weak self] result in
            do {
                self?.movie = try result.unwrap()
                self?.updateData()
            } catch let error as NSError {
                
                debugPrint("getDiscoverMovie error: \(error.localizedDescription)")
            }
        }
    }
    
    func updateData() {
        guard let data = movie else {
            return
        }
        
        durationLabel.text = data.runtimeString
        var genreslist = "Genres:"
        for genre in data.genres{
            genreslist = genreslist + " " + genre.name
        }
        genresTitleLabel.text = genreslist
        var languages = "lagnuages:"
        for spokenlanguage in data.spokenLanguages{
            languages = languages + " " + spokenlanguage.name
        }
        languageLabel.text = languages
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView){
//        if (scrollView.contentOffset.y > 10) {
//            if (!isAddBlur) {
//                posterImage.addBlurEffect()
//                isAddBlur = true
//            }
//        }else if(isAddBlur){
//            posterImage.removeBlurEffect()
//            isAddBlur = false
//        }
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
