

import Foundation
class HomeNetwork {
    static let shared = HomeNetwork()
    func getAllData(complete: @escaping (MainData)->()){
        NetworkManager.shared.get(url: NetworkHelper.shared.generalURL) { m in
            complete(m)
        }
    }
    func getNextPageData(url:String,complete:@escaping (MainData)->()){
        NetworkManager.shared.get(url: url) { m in
            complete(m)
        }
    }
}
