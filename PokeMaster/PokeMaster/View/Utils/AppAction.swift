//
//  AppAction.swift
//  PokeMaster
//
//  Created by ruanjianyingyongbu on 2021/3/31.
//  Copyright © 2021 OneV's Den. All rights reserved.
//

import Foundation

enum AppAction {
    case login(email: String, password: String)
    case accountBehaviorDone(result: Result<User, AppError>)
    
    case loadPokemons
    case loadPokemonsDone(result: Result<[PokemonViewModel], AppError>)
}
