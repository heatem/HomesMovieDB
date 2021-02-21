//
//  SaveMovieButton.swift
//  HomesMovieDB
//
//  Created by Heather Mason on 2/20/21.
//

import UIKit

class SaveButton: UIView {
    var isSaved: Bool = false
    
    let saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("♡", for: .normal)
        button.titleLabel?.font = .preferredFont(forTextStyle: .title1)
        button.titleLabel?.textAlignment = .center
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .clear
        button.layer.cornerRadius = 20
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.black.cgColor
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        if isSaved {
            saveButton.backgroundColor = .black
            saveButton.setTitle("♥", for: .normal)
            saveButton.setTitleColor(.clear, for: .normal)
            saveButton.layer.borderColor = UIColor.clear.cgColor
        }
        
        addSubview(saveButton)
        installConstraints()
    }
    
    func installConstraints() {
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.topAnchor.constraint(equalTo: topAnchor).isActive = true
        saveButton.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        saveButton.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        saveButton.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
