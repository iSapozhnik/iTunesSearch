//
//  ViewController.swift
//  iTunesSearch
//
//  Created by Sapozhnik Ivan on 24.08.16.
//  Copyright © 2016 Sapozhnik Ivan. All rights reserved.
//

import UIKit
import LoadingViewController

class ViewController: LoadingViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {

	let reuseIdentifier = String(self)
	
	@IBOutlet weak var tableView: UITableView!
	
	var data: [Artist]! {
		didSet {
			tableView.reloadData()
		}
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		
		tableView.rowHeight = UITableViewAutomaticDimension
		tableView.estimatedRowHeight = 120
		tableView.registerNib(UINib(nibName: "ArtistTableViewCell", bundle: nil), forCellReuseIdentifier: reuseIdentifier)
		
		fetchData(nil)
	}

	func fetchData(searchText: String? = "") {
		guard let searchText = searchText else { return }
		setVisibleScreen(.Loading, animated: false)
		APIService.artistByName(searchText, success: { [weak self] (data) in
			self?.setVisibleScreen(.Content)
			self?.data = data
			}) { [weak self] (error) in
				self?.lastError = error
				self?.setVisibleScreen(.Failure)
		}
	}
	
	// MARK: - Table view data source
	
	func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return data == nil ? 0 : data.count
	}
	
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier, forIndexPath: indexPath) as! ArtistTableViewCell
		
		let artist = data[indexPath.row]
		cell.titleLabel.text = artist.name
		cell.collectionLabel.text = artist.collectionName
		cell.priceLabel.text = artist.collectionPriceFormatted
		cell.tag = indexPath.row
		cell.artworkImage.image = nil
		
		cell.activityView.startAnimating()
		UIImage.getImageFromUrl(artist.artworkUrl100, completion: { [weak cell] (image) in
			if indexPath.row == cell?.tag {
				cell?.activityView.stopAnimating()
				cell?.artworkImage.image = image
			}
		})
		
		return cell
	}
	
	// MARK: SearchBar
	
	func searchBarSearchButtonClicked(searchBar: UISearchBar) {
		searchBar.resignFirstResponder()
		fetchData(searchBar.text)
	}
}
