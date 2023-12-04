//
//  HitEntity.swift
//
//  Created by Giorgi Kratsashvili on 12/2/23.
//

public struct HitEntity: Decodable, Hashable {
    public let id: Int?
    public let type: String?
    public let tags: String?
    public let previewURL: String?
    public let largeImageURL: String?
    public let imageSize: Int?
    public let views: Int?
    public let downloads: Int?
    public let collections: Int?
    public let likes: Int?
    public let comments: Int?
    public let user: String?

    public init(id: Int?,
                type: String?,
                tags: String?,
                previewURL: String?,
                largeImageURL: String?,
                imageSize: Int?,
                views: Int?,
                downloads: Int?,
                collections: Int?,
                likes: Int?,
                comments: Int?,
                user: String?) {
        self.id = id
        self.type = type
        self.tags = tags
        self.previewURL = previewURL
        self.largeImageURL = largeImageURL
        self.imageSize = imageSize
        self.views = views
        self.downloads = downloads
        self.collections = collections
        self.likes = likes
        self.comments = comments
        self.user = user
    }
}
