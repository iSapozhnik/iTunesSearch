//
//  APIService.swift
//  iTunesSearch
//
//  Created by Sapozhnik Ivan on 24.08.16.
//  Copyright © 2016 Sapozhnik Ivan. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

class APIService {
	static func artistByName(name: String, success: (data: [Artist]) -> (), failure: (error: NSError) -> ()) {
		
		let params = ["term":name]
		
		Alamofire.request(AppRouter.Artist(params)).responseArray(keyPath: "results") { (response: Response<[Artist], NSError>) in
			switch response.result {
			case .Success(let value):
				let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
				dispatch_async(dispatch_get_global_queue(priority, 0)) {
					let filteredData = DataPresenter.filteredArtists(value)
					let formattedData = DataPresenter.formattPriceForArtistsAlbums(filteredData)
					dispatch_async(dispatch_get_main_queue()) {
						success(data: formattedData)
					}
				}
			case .Failure(let error):
				failure(error: error)
			}
		}
	}
}