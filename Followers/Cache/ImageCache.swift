//
//  ImageCache.swift
//  Followers
//
//  Created by Eduard Ptushko on 28.02.2024.
//

import UIKit

class ImageCache {
    static let shared = ImageCache()
    let cache = NSCache<NSString, UIImage>()

    private init() {}

    func set(_ image: UIImage, key: String) {
        cache.setObject(image, forKey: key as NSString)
    }

    func get(key: String) -> UIImage? {
        cache.object(forKey: key as NSString)
    }
}
