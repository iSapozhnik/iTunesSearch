//
//  DataPresenter.swift
//  iTunesSearch
//
//  Created by Sapozhnik Ivan on 24.08.16.
//  Copyright © 2016 Sapozhnik Ivan. All rights reserved.
//

import Foundation

class DataPresenter {
	static func filteredArtists(data: [Artist]) -> [Artist] {
		let filteredArray = data.filter() {
			if let discCont = $0.discCount {
				return discCont >= 1
			} else {
				return false
			}
		}
		return filteredArray
	}
	
	static func formattPriceForArtistsAlbums(data: [Artist]) -> [Artist] {
		
		let formatter = NSNumberFormatter()
		formatter.numberStyle = NSNumberFormatterStyle.CurrencyStyle
		formatter.locale = NSLocale(localeIdentifier: "en_US")
		
		for artistData in data {
			if let price = artistData.collectionPrice {
				artistData.collectionPriceFormatted = formatter.stringFromNumber(NSNumber(double: price))
			} else {
				artistData.collectionPriceFormatted = "Free"
			}
		}
		
		return data
	}
}