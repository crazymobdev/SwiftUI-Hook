import Foundation

struct Movie: Codable, Hashable, Identifiable {
    let id: Int
    let title: String
    let overview: String?
    let posterPath: String?
    let backdropPath: String?
    let voteAverage: Float
    let releaseDate: Date
}
