import Foundation

struct CoinoneTicker: Decodable {
    let result: String
    let errorCode: String
    let timestamp: String
    let currency: String
    let todayVolume: String
    let yesterdayVolume: String
    let todayFirst: String
    let yesterdayFirst: String
    let todayLast: String
    let yesterdayLast: String
    let todayHigh: String
    let yesterdayHigh: String
    let todayLow: String
    let yesterdayLow: String
    
    enum CodingKeys: String, CodingKey {
        case result
        case errorCode
        case timestamp
        case currency
        case todayVolume = "volume"
        case yesterdayVolume = "yesterday_volume"
        case todayFirst = "first"
        case yesterdayFirst = "yesterday_first"
        case todayLast = "last"
        case yesterdayLast = "yesterday_last"
        case todayHigh = "high"
        case yesterdayHigh = "yesterday_high"
        case todayLow = "low"
        case yesterdayLow = "yesterday_low"
    }
}

extension CoinoneTicker {
    static func getURL(currency: Currency) -> URL {
        return URL(string: "https://api.coinone.co.kr/ticker/?format=json&currency=" + currency.rawValue)!
    }
    
    func getData() {
        DispatchQueue.global(qos: .background).async {
            do {
                let url = CoinoneTicker.getURL(currency: .bitcoinCash)
                let data = try Data(contentsOf: url)
                
                let decoder = JSONDecoder()
                
                let downloadedTicker = try decoder.decode(CoinoneTicker.self, from: data)
                
                DispatchQueue.main.async {
                    print(downloadedTicker.currency)
                    print(downloadedTicker.todayVolume)
                    print(downloadedTicker.todayLast)
                }
            } catch {
                fatalError(error.localizedDescription)
            }
        }
    }
}
