//
//  ViewController.swift
//  ODRExample
//
//  Created by Eric Berna on 1/22/18.
//  Copyright © 2018 BathWraps. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	// Properties

	lazy var odrManager: ODRManager = {
		let odr = ODRManager()
		odr.delegate = self
		return odr
	}()

	// View lifecycle

	override func viewDidLoad() {
		super.viewDidLoad()

		view.addSubview(imageView)
		imageView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor).isActive = true
		imageView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor).isActive = true
		imageView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor).isActive = true
		imageView.bottomAnchor.constraint(equalTo: view.centerYAnchor).isActive = true

		view.addSubview(secondImageView)
		secondImageView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor).isActive = true
		secondImageView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor).isActive = true
		secondImageView.topAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
		secondImageView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor).isActive = true

		view.addSubview(loadSecondImageButton)
		loadSecondImageButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
		loadSecondImageButton.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor).isActive = true

	}

	override func viewDidAppear(_ animated: Bool) {
		odrManager.load(tag: "First")
	}

	// Views

	func makeImageView() -> UIImageView {
		let iv = UIImageView()
		iv.translatesAutoresizingMaskIntoConstraints = false
		iv.backgroundColor = UIColor.lightGray
		iv.contentMode = .scaleAspectFill
		iv.clipsToBounds = true
		return iv
	}

	lazy var imageView: UIImageView = {
		return makeImageView()
	}()

	lazy var secondImageView: UIImageView = {
		return makeImageView()
	}()

	lazy var errorLabel: UILabel = {
		let el = UILabel()
		el.translatesAutoresizingMaskIntoConstraints = false
		el.textAlignment = .center
		el.textColor = UIColor.red
		return el
	}()

	lazy var loadSecondImageButton: UIButton = {
		let button = UIButton()
		button.translatesAutoresizingMaskIntoConstraints = false
		button.setTitle("Load Second Image", for: .normal)
		button.setTitleColor(UIColor.darkText, for: .normal)
		button.addTarget(self, action: #selector(loadSecondImage(sender:)), for: .touchUpInside)
		return button
	}()

	// Interactions

	func showError(message: String) {
		view.addSubview(errorLabel)
		errorLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor).isActive = true
		errorLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor).isActive = true
		errorLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
		errorLabel.text = message
	}

	@objc func loadSecondImage(sender: UIButton) {
		self.showError(message: "No second image")
	}

}

extension ViewController: ODRManagerDelegate {

	func doneLoading(tag: String, successfully: Bool) {
		if successfully {
			DispatchQueue.main.async {
				if tag == "First" {
					if let image = UIImage(named: "CappedJacuzziShowerRoundButton") {
						self.imageView.image = image
					} else {
						self.showError(message: "Could not load first image")
					}
				}
			}
		} else {
			showError(message: "Could not load tag: \(tag)")
		}
	}

}

