//
//  MovieTableViewCell.swift
//  MovieDB
//
//  Created by Mac on 2018/7/29.
//  Copyright © 2018年 Link. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher

class MovieTableViewCell: UITableViewCell {
// MARK: - Designated Initializer
    fileprivate let posterImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage.init(named: "imagenotavailable")
        imageView.contentMode = UIViewContentMode.scaleAspectFit
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
        label.font = UIFont.systemFont(ofSize: 10)
        return label
    }()
    fileprivate(set) lazy var overviewLabel: UILabel = {
        let label = UILabel(frame: CGRect.zero)
        label.textColor = UIColor.black
        label.numberOfLines = 3
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(posterImage)
        contentView.addSubview(titleLabel)
        contentView.addSubview(releaseDateLabel)
        contentView.addSubview(popularityLabel)
        contentView.addSubview(overviewLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        posterImage.frame = CGRect(x: 0, y: 0, width: 92, height: 138)
    
        imageView?.isHidden = true
        
        popularityLabel.snp.makeConstraints { (make) in
            make.top.equalTo(contentView).offset(10)
            make.leading.equalTo(posterImage.snp.trailing).offset(10)
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
            make.bottom.equalTo(contentView)
        }
    }
    
    static func cellHeight() -> CGFloat {
        return 138
    }
    
    func updateData(movie : MovieOverview) {
        titleLabel.text = movie.title
        releaseDateLabel.text = movie.releaseDate
        popularityLabel.text = movie.popularityString
        overviewLabel.text = movie.overview
        
        guard let path = (movie.posterPath != nil) ? movie.posterPath : movie.backdropPath  else {
            return
        }
        
        let photoUrl = URL.getListPhotoURL(path)
        let image = UIImage.init(named: "imagenotavailable")
        posterImage.kf.setImage(with: photoUrl, placeholder: image)
        
    }
}
