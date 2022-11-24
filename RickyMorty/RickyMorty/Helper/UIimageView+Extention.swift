
import Foundation
import UIKit

extension UIImageView {
        func imageFromServerURL(_ URLString: String, placeHolder: UIImage?) {
        self.image = nil
        let imageServerUrl = URLString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        if let url = URL(string: imageServerUrl) {
            URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                if error != nil {
                    DispatchQueue.main.async {
                        self.image = placeHolder
                    }
                    return
                }
                DispatchQueue.main.async {
                    if let data = data {
                        if let downloadedImage = UIImage(data: data) {
                            self.image = downloadedImage
                        }
                    }
                }
            }).resume()
        }
    }
}
extension UIViewController {
    func getInfoAfterClick(name:String,gender:String,origin:Location,status:String,type:String,speices:String,imageUrl:String,vc:UIViewController){
        let alert = UIAlertController(title:"General information", message: "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n", preferredStyle: UIAlertController.Style.alert)
        let rickyImageV = UIImageView()
        rickyImageV.layer.masksToBounds = true
        rickyImageV.layer.cornerRadius = 80
        rickyImageV.imageFromServerURL(imageUrl, placeHolder: nil)
            alert.view.addSubview(rickyImageV)
        rickyImageV.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(50)
            make.width.height.equalTo(160)
        }
        let nameLabel = UILabel()
        alert.view.addSubview(nameLabel)
        nameLabel.text = name
        nameLabel.textColor = .darkGray
        nameLabel.numberOfLines = 0
        nameLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(rickyImageV.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
        }
        let speicesLabel = UILabel()
        alert.view.addSubview(speicesLabel)
        speicesLabel.text = speices
        speicesLabel.numberOfLines = 0
        speicesLabel.textColor = .darkGray
        speicesLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        speicesLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
        }
        let genderLabel = UILabel()
        alert.view.addSubview(genderLabel)
        genderLabel.text = gender
        genderLabel.textColor = .darkGray
        genderLabel.numberOfLines = 0
        genderLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        genderLabel.snp.makeConstraints { make in
            make.top.equalTo(speicesLabel.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
        }
        let statusLabel = UILabel()
        alert.view.addSubview(statusLabel)
        statusLabel.text = status
        statusLabel.textColor = .darkGray
        statusLabel.numberOfLines = 0
        statusLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        statusLabel.snp.makeConstraints { make in
            make.top.equalTo(genderLabel.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
        }
        let originNameLabel = UILabel()
        alert.view.addSubview(originNameLabel)
        originNameLabel.text = origin.name
        originNameLabel.textColor = .darkGray
        originNameLabel.numberOfLines = 0
        originNameLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        originNameLabel.snp.makeConstraints { make in
            make.top.equalTo(statusLabel.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
        }
        let typeLabel = UILabel()
        alert.view.addSubview(typeLabel)
        typeLabel.text = type
        typeLabel.textColor = .darkGray
        typeLabel.numberOfLines = 0
        typeLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        typeLabel.snp.makeConstraints { make in
            make.top.equalTo(originNameLabel.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
        }
        alert.addAction(UIAlertAction(title: "Got it", style: .cancel, handler: nil))
            vc.present(alert, animated: true, completion: nil)
        }
}
