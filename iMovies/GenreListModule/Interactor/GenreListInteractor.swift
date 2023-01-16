//
//  GenreListInteractor.swift
//  iMovies
//
//  Created by Gilbert Nicholas on 13/1/23.
//

import Alamofire

class GenreListInteractor: GenreListPresenterToInteractorProtocol {
    var presenter: GenreListInteractorToPresenterProtocol?
    
    let baseUrl = Utilities.getInfoPlist(plistKey: PlistKey.BaseURLGenreList.rawValue)
    
    let params: [String: String] = [
        "api_key": Utilities.getInfoPlist(plistKey: PlistKey.APIKey.rawValue),
        "language": "en-US"
    ]
    
    func fetchGenre() {
        AF.request(baseUrl, parameters: params).responseDecodable(of: GenreResponse.self) { [weak self] genreResponse in
            switch genreResponse.result {
            case .success(let resp):
                self?.presenter?.fetchGenreSuccess(genre: resp.genres)
            case .failure(let error):
                self?.presenter?.fetchGenreFailed(error: error.localizedDescription)
            }
        }
    }
}
