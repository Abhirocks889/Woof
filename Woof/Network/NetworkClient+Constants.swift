//
//  NetworkClient+Constants.swift
//  Woof
//
//  Created by Rajeev Ranganathan on 25/12/18.
//  Copyright © 2018 Rajeev Ranganathan. All rights reserved.
//

import Foundation
extension NetworkClient {
    struct Constants {
        
        struct DogCeo {
            static let apiScheme = "https"
            static let apiHost = "api.thedogapi.com"
            static let apiPath = "/v1"
            static let apiPathExtension = "/images/search"
            static let apiPathExtensionBreeds = "/breeds"
        }
        //mime_types=jpg&format=json&has_breeds=true&page=0&limit=25
        struct ParameterKeys {
            static let MimeTypes = "mime_types"
            static let Format = "format"
            static let HasBreeds = "has_breeds"
            static let Page = "page"
            static let Limit = "limit"
            static let Size = "size"
            static let BreedId = "breed_id"
        }
        
        struct ParameterValues {
            static let ValueMimeType = "jpg"
            static let ValueFormat = "json"
            static let ValueHasBreeds = "true"
            static let ValuePageDefault = "0"
            static let ValueLimitDefault = "25"
            static let ValueBreedsLimitDefault = "100000"
            static let ValueSize = "med"
        }
        
        struct ResponseKeys {
            static let Breeds = "breeds"
            static let Id = "id"
            static let Name = "name"
            static let LifeSpan = "life_span"
            static let BredFor = "bred_for"
            static let BreedGroup = "breed_group"
            static let Tempermant = "temperament"
            static let Weight = "weight"
            static let Height = "height"
            static let Imperial = "imperial"
            static let Metric = "metric"
            static let Url = "url"
        }
        
        struct Header {
            static let Authorization = "x-api-key"
        }
    }
}
