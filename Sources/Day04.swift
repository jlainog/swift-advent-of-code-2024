import Algorithms
import Parsing

struct Day04: AdventDay {

  // Save your data in a corresponding text file in the `Data` directory.
  var data: String

  func part1() async throws -> Int {
    let input = data.split(separator: "\n").reduce(into: [[Character]]()) { result, line in
      result.append(
        line.reduce(into: [Character]()) { result, char in
          result.append(char)
        }
      )
    }
    let lines = input.count
    let columns = input[0].count
    var fordwardHorizontalLineCount = 0
    var backwardHorizontalLineCount = 0
    var fordwardVerticalLineCount = 0
    var backwardVerticalLineCount = 0
    var fordwardDiagonalLineCount = 0
    var backwardDiagonalLineCount = 0
    var fordwardInvertedDiagonalLineCount = 0
    var backwardInvertedDiagonalLineCount = 0

    for i in 0..<lines {
      for j in 0..<columns {
        if input[i][j] == "X", j < columns - 3 {
          if input[i][j + 1] == "M", input[i][j + 2] == "A", input[i][j + 3] == "S" {
            fordwardHorizontalLineCount += 1
          }
        }

        if input[i][j] == "S", j < columns - 3 {
          if input[i][j + 1] == "A", input[i][j + 2] == "M", input[i][j + 3] == "X" {
            backwardHorizontalLineCount += 1
          }
        }

        if input[i][j] == "X", i < lines - 3 {
          if input[i + 1][j] == "M", input[i + 2][j] == "A", input[i + 3][j] == "S" {
            fordwardVerticalLineCount += 1
          }
        }

        if input[i][j] == "S", i < lines - 3 {
          if input[i + 1][j] == "A", input[i + 2][j] == "M", input[i + 3][j] == "X" {
            backwardVerticalLineCount += 1
          }
        }

        if input[i][j] == "X", i < lines - 3, j < columns - 3 {
          if input[i + 1][j + 1] == "M", input[i + 2][j + 2] == "A", input[i + 3][j + 3] == "S" {
            fordwardDiagonalLineCount += 1
          }
        }

        if input[i][j] == "S", i < lines - 3, j < columns - 3 {
          if input[i + 1][j + 1] == "A", input[i + 2][j + 2] == "M", input[i + 3][j + 3] == "X" {
            backwardDiagonalLineCount += 1
          }
        }

        if input[i][j] == "X", i > 2, j < columns - 3 {
          if input[i - 1][j + 1] == "M", input[i - 2][j + 2] == "A", input[i - 3][j + 3] == "S" {
            fordwardInvertedDiagonalLineCount += 1
          }
        }

        if input[i][j] == "S", i > 2, j < columns - 3 {
          if input[i - 1][j + 1] == "A", input[i - 2][j + 2] == "M", input[i - 3][j + 3] == "X" {
            backwardInvertedDiagonalLineCount += 1
          }
        }
      }
    }

    return fordwardHorizontalLineCount
      + backwardHorizontalLineCount
      + fordwardVerticalLineCount
      + backwardVerticalLineCount
      + fordwardDiagonalLineCount
      + backwardDiagonalLineCount
      + fordwardInvertedDiagonalLineCount
      + backwardInvertedDiagonalLineCount
  }

  func part2() async throws -> Int {
    throw PartUnimplemented(day: day, part: 2)
  }
}
