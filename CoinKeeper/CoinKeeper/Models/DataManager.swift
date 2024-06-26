
import Foundation

protocol DataManager {
    func getTransactions()
    func saveTransactions()
}

class DataManagerImpl: DataManager {
    
    var transactions: [Transaction] = []
    
    func getTransactions() {
        if let savedTransactions = UserDefaults.standard.value(forKey: "transactions") as? Data {
            let decoder = JSONDecoder()
            if let loadedTransactions = try? decoder.decode([Transaction].self, from: savedTransactions) {
                transactions = loadedTransactions
            }
        }
    }
    
    func saveTransactions() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(transactions) {
            UserDefaults.standard.set(encoded, forKey: "transactions")
        }
    }
}
