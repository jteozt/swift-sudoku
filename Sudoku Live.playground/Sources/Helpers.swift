import Foundation

extension Sequence {
    
    public func all(_ predicate: (Self.Iterator.Element) throws -> Bool) rethrows -> Bool {
        for element in self {
            let result = try predicate(element)
            if !result {
                return false
            }
        }
        return true
    }

}

extension Collection where Self.Indices.Iterator.Element == Self.Index {
    public func withIndexes() -> AnySequence<(Index, Iterator.Element)> {
        return AnySequence(zip(self.indices, self))
    }
}
