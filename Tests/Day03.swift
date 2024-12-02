@testable import AdventOfCode
import Testing

struct Day03Tests {
  // Smoke test data provided in the challenge question
  let testData = """

    """

  @Test func testPart1() async throws {
    let challenge = Day03(data: testData)
    try await #expect(challenge.part1() == 2)
  }

  @Test func testPart2() async throws {
    let challenge = Day03(data: testData)
    try await #expect(challenge.part2() == 4)
  }
}
