import Hooks
import XCTest

final class AsyncStatusTests: XCTestCase {
    func testIsPending() {
        let statuses: [AsyncStatus<Int, URLError>] = [
            .pending,
            .running,
            .success(0),
            .failure(URLError(.badURL)),
        ]

        let expected = [
            true,
            false,
            false,
            false,
        ]

        for (status, expected) in zip(statuses, expected) {
            XCTAssertEqual(status.isPending, expected)
        }
    }

    func testIsRunning() {
        let statuses: [AsyncStatus<Int, URLError>] = [
            .pending,
            .running,
            .success(0),
            .failure(URLError(.badURL)),
        ]

        let expected = [
            false,
            true,
            false,
            false,
        ]

        for (status, expected) in zip(statuses, expected) {
            XCTAssertEqual(status.isRunning, expected)
        }
    }

    func testIsSuccess() {
        let statuses: [AsyncStatus<Int, URLError>] = [
            .pending,
            .running,
            .success(0),
            .failure(URLError(.badURL)),
        ]

        let expected = [
            false,
            false,
            true,
            false,
        ]

        for (status, expected) in zip(statuses, expected) {
            XCTAssertEqual(status.isSuccess, expected)
        }
    }

    func testIsFailure() {
        let statuses: [AsyncStatus<Int, URLError>] = [
            .pending,
            .running,
            .success(0),
            .failure(URLError(.badURL)),
        ]

        let expected = [
            false,
            false,
            false,
            true,
        ]

        for (status, expected) in zip(statuses, expected) {
            XCTAssertEqual(status.isFailure, expected)
        }
    }

    func testValue() {
        let statuses: [AsyncStatus<Int, URLError>] = [
            .pending,
            .running,
            .success(0),
            .failure(URLError(.badURL)),
        ]

        let expected: [Int?] = [
            nil,
            nil,
            0,
            nil,
        ]

        for (status, expected) in zip(statuses, expected) {
            XCTAssertEqual(status.value, expected)
        }
    }

    func testError() {
        let statuses: [AsyncStatus<Int, URLError>] = [
            .pending,
            .running,
            .success(0),
            .failure(URLError(.badURL)),
        ]

        let expected: [URLError?] = [
            nil,
            nil,
            nil,
            URLError(.badURL),
        ]

        for (status, expected) in zip(statuses, expected) {
            XCTAssertEqual(status.error, expected)
        }
    }

    func testResult() {
        let statuses: [AsyncStatus<Int, URLError>] = [
            .pending,
            .running,
            .success(0),
            .failure(URLError(.badURL)),
        ]

        let expected: [Result<Int, URLError>?] = [
            nil,
            nil,
            .success(0),
            .failure(URLError(.badURL)),
        ]

        for (status, expected) in zip(statuses, expected) {
            XCTAssertEqual(status.result, expected)
        }
    }

    func testMap() {
        let statuses: [AsyncStatus<Int, URLError>] = [
            .pending,
            .running,
            .success(0),
            .failure(URLError(.badURL)),
        ]

        let expected: [AsyncStatus<Int, URLError>] = [
            .pending,
            .running,
            .success(100),
            .failure(URLError(.badURL)),
        ]

        for (status, expected) in zip(statuses, expected) {
            XCTAssertEqual(status.map { _ in 100 }, expected)
        }
    }

    func testMapError() {
        let statuses: [AsyncStatus<Int, URLError>] = [
            .pending,
            .running,
            .success(0),
            .failure(URLError(.badURL)),
        ]

        let expected: [AsyncStatus<Int, URLError>] = [
            .pending,
            .running,
            .success(0),
            .failure(URLError(.cancelled)),
        ]

        for (status, expected) in zip(statuses, expected) {
            XCTAssertEqual(
                status.mapError { _ in URLError(.cancelled) },
                expected
            )
        }
    }

    func testFlatMap() {
        let statuses: [AsyncStatus<Int, URLError>] = [
            .pending,
            .running,
            .success(0),
            .failure(URLError(.badURL)),
        ]

        let expected: [AsyncStatus<Int, URLError>] = [
            .pending,
            .running,
            .failure(URLError(.callIsActive)),
            .failure(URLError(.badURL)),
        ]

        for (status, expected) in zip(statuses, expected) {
            XCTAssertEqual(
                status.flatMap { _ in .failure(URLError(.callIsActive)) },
                expected
            )
        }
    }

    func testFlatMapError() {
        let statuses: [AsyncStatus<Int, URLError>] = [
            .pending,
            .running,
            .success(0),
            .failure(URLError(.badURL)),
        ]

        let expected: [AsyncStatus<Int, URLError>] = [
            .pending,
            .running,
            .success(0),
            .success(100),
        ]

        for (status, expected) in zip(statuses, expected) {
            XCTAssertEqual(
                status.flatMapError { _ in .success(100) },
                expected
            )
        }
    }
}
