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
}
