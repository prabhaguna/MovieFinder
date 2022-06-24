//
//  MovieListController.swift
//  MFinder
//
//  Created by Saadhurya on 23/06/22.
//

import UIKit

class MovieListController: UIViewController {
    
    @IBOutlet weak var txtSearch : UITextField?
    @IBOutlet weak var clMoviews : UICollectionView?
    @IBOutlet weak var activityIndicator : UIActivityIndicatorView?
    @IBOutlet weak var lblNoMovies : UILabel?
    
    var viewModel: MoviesListViewModel?
    let reuseIdentifier = "MoviesCell"
    
    var isLoading : Bool {        
        get { return activityIndicator?.isAnimating ?? false}
        set {
            if newValue {
                activityIndicator?.isHidden = false
                activityIndicator?.startAnimating()
            } else {
                activityIndicator?.isHidden = true
                activityIndicator?.stopAnimating()
        }
      }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = MoviesListViewModel(delegate: self)
        txtSearch?.tintColor = UIColor.white
        isLoading = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
       //fetch(searchText: "Marvel")
        refresh()
    }
    
    func fetch(searchText : String) {
        self.isLoading = true
        viewModel?.searchText = searchText
        viewModel?.fetch(page: .First)
    }

}

extension MovieListController : MoviesRefreshProtocol {
    
    func refresh() {

        DispatchQueue.main.async { [weak self] in
            if let isEmpty = self?.viewModel?.movies?.isEmpty, isEmpty {
                self?.lblNoMovies?.isHidden = false
                self?.clMoviews?.isHidden = true
                self?.lblNoMovies?.text = "No Movies Found"
            } else {
                self?.lblNoMovies?.isHidden = true
                self?.clMoviews?.isHidden = false
                self?.clMoviews?.reloadData()
            }
            self?.isLoading = false
        }
    }
}

extension MovieListController : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel?.movies?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! MoviesCollectionViewCell
        
        //Cancel previous request
        cell.cancelImageRequest()
        
        if let info = viewModel?.movies?[indexPath.row] {
            cell.setTitle(title: info.Title)
            cell.display(url: info.Poster)
        }
        
        if(indexPath.row + 1 == viewModel?.movies?.count) {
            viewModel?.fetch(page: .Next)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        //Cancel request for cancelled cell
        if let cell = cell as? MoviesCollectionViewCell {
            cell.cancelImageRequest()
        }
        
    }
    
}

extension MovieListController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize(width: self.view.frame.size.width / 2 - 5, height: 250)
        return size
    }
    
}

extension MovieListController : UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField,
                       shouldChangeCharactersIn range: NSRange,
                       replacementString string: String) -> Bool {
        if let text = textField.text,
           let textRange = Range(range, in: text) {
           let updatedText = text.replacingCharacters(in: textRange,
                                                       with: string)
           fetch(searchText: updatedText)
        }
        return true
     }
    
}
