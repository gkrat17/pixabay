//
//  RequestBuilder.swift
//
//  Created by Giorgi Kratsashvili on 12/2/23.
//

import DI
import Network

extension RequestBuilder {
    func configure() -> Self {
        @Inject(container: .default) var config: Config
        return self
            .set(scheme: config.API_SCHEME)
            .set(host: config.API_HOST)
            .set(path: config.API_PATH)
            .set(contentType: .json)
            .set(query: [("key", config.API_KEY)])
    }
}
