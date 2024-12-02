@testable import AdventOfCode
import Testing

struct Day01Tests {
  // Smoke test data provided in the challenge question
  let testData = """
    3   4
    4   3
    2   5
    1   3
    3   9
    3   3
    """

  @Test func testPart1() async throws {
    let challenge = Day01(data: testData)
    try await #expect(challenge.part1() == 11)
  }

  @Test func testPart2() async throws {
    let challenge = Day01(data: testData)
    try await #expect(challenge.part2() == 31)
  }
}
