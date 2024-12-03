import Algorithms
import Parsing

struct Day03: AdventDay {

  // Save your data in a corresponding text file in the `Data` directory.
  var data: String

  func parseInput() throws -> [Int] {
    let mulParser = Parse {
      "mul("
      Int.parser()
      ","
      Int.parser()
      ")"
    }.map { $0.0 * $0.1 }
    let mulOptionsParser = OneOf {
      Parse {
        Skip {
          PrefixUpTo("mul(")
        }
        mulParser
      }

      Parse {
        Skip {
          PrefixUpTo("mul(")
        }
        "mul("
        Int.parser()
        ","
        Int.parser()
      }.map { _ in 0 }

      Parse {
        Skip {
          PrefixUpTo("mul(")
        }
        "mul("
        Int.parser()
        ","
      }.map { _ in 0 }

      Parse {
        Skip {
          PrefixUpTo("mul(")
        }
        "mul("
        Int.parser()
      }.map { _ in 0 }

      Parse {
        Skip {
          PrefixUpTo("mul(")
        }
        "mul("
      }.map { _ in 0 }
    }

    let parser = Many {
      mulOptionsParser
    } separator: {
      PrefixUpTo("mul(")
    } terminator: {
      Rest()
    }

    return try parser.parse(data)
  }

  func part1() async throws -> Int {
    let input = try parseInput()
    return input.reduce(0, +)
  }

  func part2() async throws -> Int {
    enum Operation {
      case `do`
      case dont
      case mul(Int)
      case noop
    }

    let mulParser = Parse {
      "mul("
      Int.parser()
      ","
      Int.parser()
      ")"
    }.map { $0.0 * $0.1 }
    let parser = Many {
      OneOf {
        "do()".map { Operation.do }
        "don't()".map { Operation.dont }
        mulParser.map { Operation.mul($0) }
        Skip { First() }.map { Operation.noop }
      }
    }
    let input = try parser.parse(data)
    var doOp = true
    return input.reduce(0) {
      switch $1 {
      case .do: doOp = true
      case .dont: doOp = false
      case .noop: break
      case .mul(let valule):
        return doOp ? $0 + valule : $0
      }
      return $0
    }
  }
}
