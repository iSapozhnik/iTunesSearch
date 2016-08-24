//
//  UIImage+Loading.swift
//  iTunesSearch
//
//  Created by Sapozhnik Ivan on 24.08.16.
//  Copyright © 2016 Sapozhnik Ivan. All rights reserved.
//

import Foundation
import Alamofire

extension UIImage {
	public static func getImageFromUrl(urlString: String?, completion: (image: UIImage?) -> Void) {
		if let URLString = urlString {
			Alamofire.request(.GET, URLString).responseData { response in
				if let imageData = response.result.value {
					let image = UIImage(data: imageData, scale:1)
					completion(image:image)
				}
			}
		}
	}
}