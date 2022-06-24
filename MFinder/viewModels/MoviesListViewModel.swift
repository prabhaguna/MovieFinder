//
//  MoviesListViewModel.swift
//  MFinder
//
//  Created by Saadhurya on 23/06/22.
//

import Foundation

protocol MoviesRefreshProtocol : AnyObject {
    func refresh()
}

enum Page {
    case First, Next
}

class MoviesListViewModel {
    
    var movies : [Movie]?
    var searchText : String?
    var currentPage : Int = 0
    
    weak var delegate : MoviesRefreshProtocol?
    
    init(delegate : MoviesRefreshProtocol?) {
        movies = [Movie]()
        self.delegate = delegate
    }
        
    func fetch(page: Page) {
        
        if page == .First {
            currentPage = 0
            movies?.removeAll()
        }
        else if page == .Next {
            currentPage += 1
        }
        
        MovieRequest(s: searchText, page: currentPage).fetch(completion: { [weak self] response ,error  in

            if let movies = response?.Search {
                self?.movies?.append(contentsOf: movies)
            }
            self?.delegate?.refresh()
        })
    }
    
}
