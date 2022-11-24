

import Foundation

struct MainData: Codable {
    let info: Info
    let results: [MainResult]
}
struct Info: Codable {
    let count, pages: Int
    var next:String? = nil
    var prev:String? = nil
}
struct MainResult: Codable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let origin, location: Location
    let image: String
    let episode: [String]
    let url: String
    let created: String
}
struct Location: Codable {
    let name: String
    let url: String
}



