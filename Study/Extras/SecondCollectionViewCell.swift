//
//  SecondCollectionViewCell.swift
//  Study
//
//  Created by Thais da Silva Bras on 29/07/21.
//

import UIKit

class SecondCollectionViewCell: UICollectionViewCell {
   
        static let identifier = "CustomCollectionViewCell"
        
        private let myLabel: UILabel = {
            let label = UILabel()
            label.text = "Matéria"
            label.textAlignment = .left
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
    
        private let myLabel2: UILabel = {
        let label2 = UILabel()
        label2.text = "Data"
        label2.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        label2.textAlignment = .left
        label2.translatesAutoresizingMaskIntoConstraints = false
        return label2
    }()
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            contentView.backgroundColor = #colorLiteral(red: 1, green: 0.8485386968, blue: 0.8083946109, alpha: 1)
            contentView.layer.borderColor = #colorLiteral(red: 1, green: 0.5266870856, blue: 0.4073979557, alpha: 1)
            contentView.layer.borderWidth = 1
            contentView.layer.cornerRadius = 5
            contentView.addSubview(myLabel)
            contentView.addSubview(myLabel2)
            contentView.clipsToBounds = true
            setContraints()
        }
    
        private func setContraints(){
            NSLayoutConstraint.activate([
            myLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            myLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            myLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            myLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
                
            myLabel2.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            myLabel2.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15),
            myLabel2.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            myLabel2.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15)
                    
        ])
    }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override func layoutSubviews() {
            super.layoutSubviews()
            
            myLabel.frame = CGRect(x: 5, y: contentView.frame.size.height-50, width: contentView.frame.size.width-10, height: 50)
            myLabel2.frame = CGRect(x: 5, y:contentView.frame.size.height-30, width: contentView.frame.size.width-10, height: 30)
        }
        public func configure(label: String, label2: String) {
            myLabel.text = label
            myLabel2.text = label2
        }
        
        override func prepareForReuse() {
            super.prepareForReuse()
            myLabel.text = nil
            myLabel2.text = nil
        }
        
    }

