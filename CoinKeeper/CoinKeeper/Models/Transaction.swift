
import Foundation

struct Transaction: Codable {
    let id: UUID
    let title: String
    let amount: Double
}
