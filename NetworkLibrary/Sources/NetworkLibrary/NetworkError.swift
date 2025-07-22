enum NetworkError: Error {
    case invalidURL
    case requestFailed(Error)
    case invalidData
}
