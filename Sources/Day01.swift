import Algorithms
import Parsing

struct Day01: AdventDay {

  typealias LocationId = Int

  struct LocationIdParser: Parser {
    var body: some Parser<Substring, ([LocationId], [LocationId])> {
      Many {
        Int.parser()
        "   "
        Int.parser()
      } separator: {
        "\n"
      } terminator: {
        Whitespace()
      }.map { rows in
        rows.reduce(into: ([LocationId](), [LocationId]())) { result, row in
          result.0.append(row.0)
          result.1.append(row.1)
        }
      }
    }
  }

  // Save your data in a corresponding text file in the `Data` directory.
  var data: String

  func part1() async throws -> Int {
    let input = try LocationIdParser().parse(data)
    let list1 = input.0.sorted()
    let list2 = input.1.sorted()
    return zip(list1, list2).reduce(0) { result, pair in
      result + abs(pair.0 - pair.1)
    }
  }

  func part2() async throws -> Int {
    let input = try LocationIdParser().parse(data)
    let list1 = input.0
    let list2 = input.1
    var similarityScore = 0

    let dic = list2.reduce([Int: Int]()) { partialResult, value in
      partialResult.merging([value: 1]) { (current, _) in current + 1 }
    }

    for value in list1 {
      if let similarity = dic[value] {
        similarityScore += similarity * value
      }
    }

    return similarityScore
  }
}
