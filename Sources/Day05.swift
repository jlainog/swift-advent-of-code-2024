import Algorithms
import Parsing

struct Day05: AdventDay {

  struct PageOrderingRulesParser: Parser {
    var body: some Parser<Substring, [(Int, Int)]> {
      Many {
        Int.parser()
        "|"
        Int.parser()
      } separator: {
        "\n"
      }
    }
  }

  struct PageUpdateParser: Parser {
    var body: some Parser<Substring, [[Int]]> {
      Many {
        Many {
          Int.parser()
        } separator: {
          ","
        }
      } separator: {
        "\n"
      }
    }
  }

  struct InputParser: Parser {
    var body: some Parser<Substring, ([(Int, Int)], [[Int]])> {
      Parse {
        PageOrderingRulesParser()
        Whitespace()
        PageUpdateParser()
      }
    }
  }

  // Save your data in a corresponding text file in the `Data` directory.
  var data: String

  func part1() async throws -> Int {
    let input = try InputParser().parse(data)
    let rules = input.0
    let updates = input.1

    let rulesSimplified = rules.reduce(into: [Int: [Int]]()) { partialResult, result in
      guard let current = partialResult[result.0] else {
        partialResult[result.0] = [result.1]
        return
      }
      partialResult[result.0] = current + [result.1]
    }

    return updates.reduce(into: 0) { partialResult, pages in
      guard pages.isEmpty == false else { return }

      let sortedPages = pages.sorted { page1, page2 in
        let page1Orders = rulesSimplified[page1] ?? []
        let page2Orders = rulesSimplified[page2] ?? []

        if page2Orders.contains(page1) {
          return false
        }
        if page1Orders.contains(page2) {
          return true
        }

        return false
      }

      if pages == sortedPages {
        partialResult += pages[pages.count / 2]
      }
    }
  }

  func part2() async throws -> Int {
    let input = try InputParser().parse(data)
    let rules = input.0
    let updates = input.1

    let rulesSimplified = rules.reduce(into: [Int: [Int]]()) { partialResult, result in
      guard let current = partialResult[result.0] else {
        partialResult[result.0] = [result.1]
        return
      }
      partialResult[result.0] = current + [result.1]
    }

    return updates.reduce(into: 0) { partialResult, pages in
      guard pages.isEmpty == false else { return }

      let sortedPages = pages.sorted { page1, page2 in
        let page1Orders = rulesSimplified[page1] ?? []
        let page2Orders = rulesSimplified[page2] ?? []

        if page2Orders.contains(page1) {
          return false
        }
        if page1Orders.contains(page2) {
          return true
        }

        return false
      }

      if pages != sortedPages {
        partialResult += sortedPages[sortedPages.count / 2]
      }
    }
  }
}
