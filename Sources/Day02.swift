import Algorithms
import Parsing

struct Report {
  var levels: [Int]
}

struct Day02: AdventDay {

  struct ReportParser: Parser {
    var body: some Parser<Substring, [Report]> {
      Many {
        Many {
          Int.parser()
        } separator: {
          " "
        }.map { Report(levels: $0) }
      } separator: {
        "\n"
      }
    }
  }

  // Save your data in a corresponding text file in the `Data` directory.
  var data: String

  func part1() async throws -> Int {
    let input = try ReportParser().parse(data)
    return input.reduce(0) { partialResult, report in
      partialResult + (report.isSafe ? 1 : 0)
    }
  }

  func part2() async throws -> Int {
    let input = try ReportParser().parse(data)
    return input.reduce(0) { partialResult, report in
      partialResult + (report.isSafeWithDampener ? 1 : 0)
    }
  }
}

extension Report {
  enum Direction {
    case none, increasing, decreasing
  }

  var isSafe: Bool {
    var isSafe = true
    var direction = Direction.none

    //    for window in self.windows(ofCount: 2) {
    //      let diff = window.first! - window.last!
    for pair in self.levels.adjacentPairs() {
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

    for index in self.levels.indices {
      var new = self.levels
      new.remove(at: index)

      if Report(levels: new).isSafe {
        return true
      }
    }

    return false
  }
}
