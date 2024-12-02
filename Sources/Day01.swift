import Algorithms
import Parsing

struct Day01: AdventDay {

  typealias LocationId = Int
  
  // Save your data in a corresponding text file in the `Data` directory.
  var data: String

  func parseInput() throws -> ([LocationId], [LocationId]) {
    let row = Parse(input: Substring.self) {
      Int.parser()
      "   "
      Int.parser()
    }
    let rows = Many {
      row
    } separator: {
      "\n"
    } terminator: {
      Whitespace()
    }.map { rows in
      var list1 = [LocationId]()
      var list2 = [LocationId]()

      for row in rows {
        list1.append(row.0)
        list2.append(row.1)
      }

      return (list1, list2)
    }

    return try rows.parse(data)
  }

  func part1() async throws -> Int {
    let input = try parseInput()
    let list1 = input.0.sorted()
    let list2 = input.1.sorted()
    return zip(list1, list2).reduce(0) { result, pair in
      result + abs(pair.0 - pair.1)
    }
  }

  func part2() async throws -> Int {
    var similarityScore = 0
    let input = try parseInput()
    let list1 = input.0
    let list2 = input.1

    let dic = list2.reduce([Int:Int]()) { partialResult, value in
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
