//
//  GFAvatarImageView.swift
//  GitHubFollowers
//
//  Created by Yash Shah on 20/02/2024.
//

import UIKit

class GFAvatarImageView: UIImageView {
	private let placeholderImage = UIImage(named: "avatar-placeholder")!
	
	private let imageCache = NetworkManager.shared.cache
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		configure()
	}
	
	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init?(coder: NSCoder) has not been implemented")
	}
	
	private func configure() {
		translatesAutoresizingMaskIntoConstraints = false
		layer.cornerRadius = 10
		clipsToBounds = true
		image = placeholderImage
	}
	
	func downloadImage(from urlString: String) {
		if let cachedImage = imageCache.object(forKey: urlString as NSString) {
			image = cachedImage
			return
		}
		
		guard let url = URL(string: urlString) else { return }
		
		URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
			guard let self else { return }
			guard error == nil, (response as? HTTPURLResponse)?.statusCode == 200 else { return }
			guard let data, let downloadedImage = UIImage(data: data) else { return }
			imageCache.setObject(downloadedImage, forKey: urlString as NSString)
			DispatchQueue.main.async { self.image = downloadedImage }
		}.resume()
	}
	
}
