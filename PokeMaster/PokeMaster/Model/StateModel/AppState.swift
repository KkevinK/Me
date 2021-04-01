//
//  AppState.swift
//  PokeMaster
//
//  Created by ruanjianyingyongbu on 2021/3/30.
//  Copyright © 2021 OneV's Den. All rights reserved.
//

import Foundation

struct AppState {
    var settings = Settings()
    var pokemonList = PokemonList()
}

extension AppState {
    struct Settings {
        enum Sorting: CaseIterable {
            case id, name, color, favorite
        }
        var showEnglishName = true
        var sorting = Sorting.id
        var showFavoriteOnly = false
        
        enum AccountBehavior: CaseIterable {
            case register, login
        }
        var accountBehavior = AccountBehavior.login
        var email = ""
        var password = ""
        var verifyPassword = ""
        
        var loginUser: User?
        var loginRequesting = false
        var loginError: AppError?
    }
}


extension AppState {
    struct PokemonList {
        var pokemons: [Int: PokemonViewModel]?
        var loadingPokemons = false
        var allPokemonsByID: [PokemonViewModel] {
            guard let pokemons = pokemons?.values else {
                return []
            }
            return pokemons.sorted { $0.id < $1.id }
        }
    }
}

struct User: Codable {
    var email: String
    var favoritePokemonIDs: Set<Int>
    func isFavoritePokemon(id: Int) -> Bool {
        favoritePokemonIDs.contains(id)
    }
}
