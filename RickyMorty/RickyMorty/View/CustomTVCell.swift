

import Foundation
import UIKit

class CustomHomeTVCell:UITableViewCell {
    
    lazy var species: UILabel = {
        let text = UILabel()
        text.textColor = .black
        text.numberOfLines = 0
        text.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        return text
    }()
    lazy var status: UILabel = {
        let text = UILabel()
        text.textColor = .black
        text.numberOfLines = 0
        text.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        return text
    }()
    lazy var gender: UILabel = {
        let text = UILabel()
        text.textColor = .black
        text.numberOfLines = 0
        text.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        return text
    }()
    lazy var name: UILabel = {
        let text = UILabel()
        text.textColor = .black
        text.numberOfLines = 0
        text.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return text
    }()
    lazy var urlToImage: UIImageView = {
        let icon = UIImageView()
        icon.layer.masksToBounds = true
        icon.layer.cornerRadius = 18
        return icon
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    required init?(coder: NSCoder) {
        fatalError()
    }

    func setupUI() {
        contentView.addSubview(species)
        contentView.addSubview(status)
        contentView.addSubview(name)
        contentView.addSubview(gender)
        contentView.addSubview(urlToImage)
        urlToImage.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.width.equalTo(250)
        }
        name.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.top.equalTo(urlToImage.snp.bottom).offset(10)
            make.right.equalToSuperview().offset(-20)
        }
        species.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.top.equalTo(name.snp.bottom).offset(10)
            make.right.equalToSuperview().offset(-20)
        }
        gender.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.top.equalTo(species.snp.bottom).offset(10)
            make.right.equalToSuperview().offset(-20)
        }
        status.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.top.equalTo(gender.snp.bottom).offset(10)
            make.right.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-10)
        }
    }
    
}
