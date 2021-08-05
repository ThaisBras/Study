//
//  CustomCollectionViewCell.swift
//  Study
//
//  Created by Thais da Silva Bras on 27/07/21.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "CustomCollectionViewCell"
    
    private let myLabel: UILabel = {
        let label = UILabel()
        label.text = "Custom"
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = #colorLiteral(red: 1, green: 0.8485386968, blue: 0.8083946109, alpha: 1)
        contentView.layer.borderColor = #colorLiteral(red: 1, green: 0.5266870856, blue: 0.4073979557, alpha: 1)
        contentView.layer.borderWidth = 1
        contentView.layer.cornerRadius = 5
        contentView.addSubview(myLabel)
        contentView.clipsToBounds = true
        setContraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setContraints(){
        NSLayoutConstraint.activate([
            myLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            myLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            myLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            myLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12)
        ])
    }
    
    
    public func configure(label: String) {
        myLabel.text = label
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        myLabel.text = nil
    }
    
}
