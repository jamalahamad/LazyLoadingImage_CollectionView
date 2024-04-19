//
//  ViewController.swift
//  LazyLoadingImage
//
//  Created by Jamal Ahamad on 18/04/24.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    let vm = HomeViewModel()
    var modelArray = [DataModel]()
    
    var imageCache = NSCache<NSString, UIImage>()
    var loadingTasks = [IndexPath: URLSessionDataTask]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
        fetchData()
    }
    
    func setUpUI() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(UINib(nibName: "\(CollectionViewCell.self)", bundle: nil), forCellWithReuseIdentifier: "\(CollectionViewCell.self)")
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.estimatedItemSize = .zero
    }
    
    func fetchData() {
        vm.getData { dataArray in
            DispatchQueue.main.async {
                self.modelArray = dataArray
                self.collectionView.reloadData()
            }
        }
    }
    
}

// MARK: - TableView Delegate and Data Source

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.modelArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(CollectionViewCell.self)", for: indexPath) as? CollectionViewCell else {return UICollectionViewCell()}
        cell.imgview.image = UIImage(named: "placeholder.png")
        let model = modelArray[indexPath.item]
        let imgUrl  = model.thumbnail.domain + "/" + model.thumbnail.basePath + "/0/" + model.thumbnail.key
        
        loadImage(at: indexPath, urlString: imgUrl)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth = collectionView.bounds.width
        let spacing: CGFloat = 5
        let numberOfColumns: CGFloat = 3
        let cellWidth = (collectionViewWidth - (numberOfColumns + 2) * spacing) / numberOfColumns
        
        return CGSize(width: cellWidth, height: cellWidth)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    
    // Lazy loading with cancellation
    func loadImage(at indexPath: IndexPath, urlString: String) {
        // let urlString = modelArray[indexPath.item].imageUrl
        if let cachedImage = imageCache.object(forKey: urlString as NSString) {
            // Use cached image if available
            DispatchQueue.main.async {
                if let cell = self.collectionView.cellForItem(at: indexPath) as? CollectionViewCell {
                    cell.imgview.image = cachedImage
                }
            }
        } else {
            // Cancel previous loading task if exists
            if let previousTask = loadingTasks[indexPath] {
                previousTask.cancel()
            }
            
            // Create new loading task
            let url = URL(string: urlString)!
            let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
                guard let self = self else { return }
                guard let data = data, let image = UIImage(data: data) else { return }
                
                // Cache the image
                self.imageCache.setObject(image, forKey: urlString as NSString)
                
                // Display the image in cell
                DispatchQueue.main.async {
                    if let cell = self.collectionView.cellForItem(at: indexPath) as? CollectionViewCell {
                        cell.imgview.image = image
                    }
                }
            }
            
            // Store the loading task
            loadingTasks[indexPath] = task
            
            // Start the loading task
            task.resume()
        }
    }
}


