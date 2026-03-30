import Foundation

extension Double {
    var currencyFormatted: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "BGN"
        formatter.maximumFractionDigits = 2
        return formatter.string(from: NSNumber(value: self)) ?? "\(self) BGN"
    }

    var twoDecimalString: String {
        String(format: "%.2f", self)
    }
}
