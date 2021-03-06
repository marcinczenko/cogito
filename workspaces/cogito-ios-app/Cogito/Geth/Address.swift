import Foundation
import Geth

struct Address: Codable {
    let value: String

    init(from gethAddress: GethAddress) {
        value = gethAddress.getHex()
    }

    init?(fromHex hex: String) {
        guard GethAddress(fromHex: hex) != nil else {
            return nil
        }
        value = hex
    }

    func toGethAddress() -> GethAddress {
        return GethAddress(fromHex: value)
    }

    init(from decoder: Decoder) throws {
        value = try String(from: decoder)
    }

    func encode(to encoder: Encoder) throws {
        try value.encode(to: encoder)
    }
}

extension Address: CustomStringConvertible {
    var description: String {
        return value
    }
}

extension Address: Equatable {
    static func == (lhs: Address, rhs: Address) -> Bool {
        return lhs.value.lowercased() == rhs.value.lowercased()
    }
}
