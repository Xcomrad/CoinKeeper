
import Foundation

struct Transaction: Codable, Hashable {
    let id: UUID
    let title: String
    let amount: Double
}
