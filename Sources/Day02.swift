import Algorithms
import Parsing

struct Day02: AdventDay {

  typealias Levels = Int
  typealias Report = [Levels]

  // Save your data in a corresponding text file in the `Data` directory.
  var data: String

  func parseInput() throws -> [Report] {
    return data.split(separator: "\n").map {
      $0.split(separator: " ").compactMap { Int($0) }
    }
  }

  func part1() async throws -> Int {
    let input = try parseInput()
    return input.reduce(0) { partialResult, report in
      partialResult + (report.isSafe ? 1 : 0)
    }
  }

  func part2() async throws -> Int {
    let input = try parseInput()
    return input.reduce(0) { partialResult, report in
      partialResult + (report.isSafeWithDampener ? 1 : 0)
    }
  }
}

extension Day02.Report {
  enum Direction {
    case none, increasing, decreasing
  }

  var isSafe: Bool {
    var isSafe = true
    var direction = Direction.none

    //    for window in self.windows(ofCount: 2) {
    //      let diff = window.first! - window.last!
    for pair in self.adjacentPairs() {
      let diff = pair.0 - pair.1

      isSafe = abs(diff) <= 3

      if diff == 0 {
        isSafe = false
      } else if diff > 0, direction == .none {
        direction = .increasing
      } else if diff < 0, direction == .none {
        direction = .decreasing
      } else if diff > 0, direction == .decreasing {
        isSafe = false
      } else if diff < 0, direction == .increasing {
        isSafe = false
      }

      if isSafe == false {
        break
      }
    }

    return isSafe
  }

  var isSafeWithDampener: Bool {
    guard self.isSafe == false else {
      return true
    }

    for index in self.indices {
      var new = self
      new.remove(at: index)

      if new.isSafe {
        return true
      }
    }

    return false
  }
}
