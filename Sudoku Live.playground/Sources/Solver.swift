import Foundation

public class Solver {
    public var board: Board
    
    public init(board: Board) {
        self.board = board
    }
    
    public var isSolved: Bool {
        return board.isSolved
    }
    
    public func solve() {
        while !isSolved {
            var foundSomethingThisIteration = false

            for (index, cell) in board.cells.withIndexes() {

                if cell.isSettled {
                    continue
                }

                let possibleValues = (1...9).filter({ value in
                    return board.canUpdate(index: index, toValue: value)
                })

                if possibleValues.isEmpty {
                    return
                }

                if possibleValues.count == 1 {
                    foundSomethingThisIteration = true
                }

                try? board.update(index: index, values: possibleValues)

            }

            if !foundSomethingThisIteration {
                return
            }
        }
    }

    public func bruteForce() {
        self.solve()

        if isSolved {
            return
        }

        let optionalTuple = board.cells
            .withIndexes()
            .sorted(by: { left, right in
                return left.1.values.count < right.1.values.count
            })
            .first(where: { !$0.1.isSettled })

        guard let (index, cell) = optionalTuple else { return }

        for value in cell.values {

            var copy = board

            do {
                try copy.update(index: index, values: [value])
                print(copy)
            } catch {
                if error is ConsistencyError {
                    continue
                }
            }

            let solver = Solver(board: copy)
            solver.bruteForce()
            if solver.isSolved {
                self.board = solver.board
                return
            }

        }
    }
    
}












