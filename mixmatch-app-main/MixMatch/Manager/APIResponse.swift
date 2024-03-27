struct APIResponse: Decodable {
    let results: Results

    struct Results: Decodable {
        let songs: Songs
    }

    struct Songs: Decodable {
        let data: [SongData]
    }

    struct SongData: Decodable {
        let id: String
        let attributes: Attributes

        struct Attributes: Decodable {
            let name: String
            let artistName: String
            let genreNames: [String]
            let artwork: Artwork

            struct Artwork: Decodable {
                let url: String
            }
        }
    }
}
