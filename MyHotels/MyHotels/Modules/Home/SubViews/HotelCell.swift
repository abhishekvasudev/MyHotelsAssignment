//
//  HotelCell.swift
//  MyHotels
//
//  Created by Abhishek Vasudev on 22/07/21.
//

import UIKit

class HotelCell: UITableViewCell {
    
    var hotel : Hotel? {
        didSet {
            hotelNameLabel.text = hotel?.name ?? ""
            hotelRatingLabel.text = "\(hotel?.hotelRating ?? 0 )"
            if let image = hotel?.photo {
                hotelImageView.image = image
            }
        }
    }
    let horizontalPadding = CGFloat(20)
    let verticalPadding = CGFloat(20)
    
    let rootView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = MHColorScheme.primaryColor
        view.layer.cornerRadius = CGFloat(12)
        view.clipsToBounds = true
        return view
    }()
    
    let hotelImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "DefaultHotelImage")
        let imageSize = 150
        imageView.layer.cornerRadius = CGFloat(15)
        imageView.heightAnchor.constraint(equalToConstant: CGFloat(imageSize)).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: CGFloat(imageSize)).isActive = true
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let hotelNameTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "NAME"
        label.textColor = MHColorScheme.tertiaryColor
        return label
    }()
    
    let hotelNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let hotelRatingTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "RATING"
        label.textColor = MHColorScheme.tertiaryColor
        return label
    }()
    
    let hotelRatingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        addSubview(rootView)
        rootView.addSubview(hotelImageView)
        rootView.addSubview(hotelNameTitleLabel)
        rootView.addSubview(hotelNameLabel)
        rootView.addSubview(hotelRatingTitleLabel)
        rootView.addSubview(hotelRatingLabel)
        activateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func activateConstraints() {
        // Another way of enabling constraints
        rootView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        rootView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        rootView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        rootView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
        
        hotelImageView.leadingAnchor.constraint(equalTo: rootView.leadingAnchor, constant: horizontalPadding).isActive = true
        hotelImageView.topAnchor.constraint(equalTo: rootView.topAnchor, constant:verticalPadding).isActive = true
        hotelImageView.bottomAnchor.constraint(equalTo: rootView.bottomAnchor, constant: -verticalPadding).isActive = true
        
        hotelNameTitleLabel.leadingAnchor.constraint(equalTo: hotelImageView.trailingAnchor, constant: horizontalPadding).isActive = true
        hotelNameTitleLabel.topAnchor.constraint(equalTo: rootView.topAnchor, constant:verticalPadding).isActive = true
        hotelNameTitleLabel.trailingAnchor.constraint(greaterThanOrEqualTo: rootView.trailingAnchor, constant: -horizontalPadding).isActive = true
        
        hotelNameLabel.leadingAnchor.constraint(equalTo: hotelImageView.trailingAnchor, constant: horizontalPadding).isActive = true
        hotelNameLabel.topAnchor.constraint(equalTo: hotelNameTitleLabel.bottomAnchor, constant: 5).isActive = true
        hotelNameLabel.trailingAnchor.constraint(greaterThanOrEqualTo: rootView.trailingAnchor, constant: -horizontalPadding).isActive = true
        
        hotelRatingTitleLabel.leadingAnchor.constraint(equalTo: hotelImageView.trailingAnchor, constant: horizontalPadding).isActive = true
        hotelRatingTitleLabel.trailingAnchor.constraint(greaterThanOrEqualTo: rootView.trailingAnchor, constant: -horizontalPadding).isActive = true
        hotelRatingTitleLabel.bottomAnchor.constraint(equalTo: hotelRatingLabel.topAnchor, constant: -5).isActive = true
        
        hotelRatingLabel.leadingAnchor.constraint(equalTo: hotelImageView.trailingAnchor, constant: horizontalPadding).isActive = true
        hotelRatingLabel.trailingAnchor.constraint(greaterThanOrEqualTo: rootView.trailingAnchor, constant: -horizontalPadding).isActive = true
        hotelRatingLabel.bottomAnchor.constraint(equalTo: rootView.bottomAnchor, constant: -horizontalPadding).isActive = true
    }
}
