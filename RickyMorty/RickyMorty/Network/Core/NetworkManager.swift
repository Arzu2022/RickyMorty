

import Alamofire

class NetworkManager {
    
    static let shared = NetworkManager()
    func get(url:String, completion: @escaping (MainData)->()){
        AF.request(url, method: .get).responseDecodable(of: MainData.self,completionHandler: { response in
            if response.value != nil{
                completion(response.value!)
            }
                    })
        
        
    }
    
}
