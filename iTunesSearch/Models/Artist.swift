//
//  Artist.swift
//  iTunesSearch
//
//  Created by Sapozhnik Ivan on 24.08.16.
//  Copyright © 2016 Sapozhnik Ivan. All rights reserved.
//

import ObjectMapper

class Artist: NSObject, Mappable {
	var artistId: String!
	var name: String?
	var discCount: Int?
	var discNumber: Int?
	var trackNumber: Int?
	var trackCount: Int?
	var artworkUrl100: String?
	var collectionName: String?
	var collectionPrice: Double?
	var collectionPriceFormatted: String?
	
	required init?(_ map: Map) {
		
	}
	
	func mapping(map: Map) {
		artistId		<- map["artistId"]
		name			<- map["artistName"]
		discCount		<- map["discCount"]
		discNumber		<- map["discNumber"]
		trackNumber		<- map["trackNumber"]
		trackCount		<- map["trackCount"]
		artworkUrl100	<- map["artworkUrl100"]
		collectionName	<- map["collectionName"]
		collectionPrice	<- map["collectionPrice"]
	}
}
