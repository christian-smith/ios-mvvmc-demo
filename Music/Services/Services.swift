class Services {
    let apiClient: APIClient
    let imageCache: ImageCache

    init(apiClient: APIClient, imageCache: ImageCache? = nil) {
        self.apiClient = apiClient
        self.imageCache = imageCache ?? ImageCache(apiClient: apiClient)
    }
}