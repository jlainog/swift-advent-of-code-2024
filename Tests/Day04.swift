import Testing

@testable import AdventOfCode

struct Day04Tests {
  // Smoke test data provided in the challenge question
  let testData = """
    MMMSXXMASM
    MSAMXMSMSA
    AMXSXMAAMM
    MSAMASMSMX
    XMASAMXAMM
    XXAMMXXAMA
    SMSMSASXSS
    SAXAMASAAA
    MAMMMXMMMM
    MXMXAXMASX
    """

  @Test func testPart1() async throws {
    let challenge = Day04(data: testData)
    try await #expect(challenge.part1() == 18)
  }

  @Test func testPart2() async throws {
    let challenge = Day04(data: testData)
    try await #expect(challenge.part2() == 48)
  }
}
