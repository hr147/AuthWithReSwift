//
//  AuthRedux.swift
//  AuthenticaionWithRedux
//
//  Created by Haroon Ur Rasheed on 18/10/2018.
//  Copyright © 2018 Haroon Ur Rasheed. All rights reserved.
//

import UIKit
import ReSwift

enum AuthViewState<T>{
    case auth(T)
    case login(T)
    case create(T)
    case forgot(T)
    case none
}

struct AuthState:StateType {
    var authViewState:AuthViewState<[AuthCellType]> = .none
}

enum AuthAction:Action {
    case login
    case forgot
    case create
    case auth
}

func authReducer(_ action: Action, _ state: AuthState?) -> AuthState{
    var state = state ?? AuthState()
    switch action as? AuthAction {
    case nil:
        break
    case .login?:
        state.authViewState = .login([
            .titleUserLogin,
            .emailTextField,
            .passwordTextField,
            .loginButton,
            .fogotButton,
            .dontHaveAccountButton
            ])
    case .forgot?:
        state.authViewState = .forgot([
            .titleForgot,
            .emailTextField,
            .sendButton,
            .alreadyHaveAccountButton
            ])
    case .create?:
        state.authViewState = .create([
            .titleCreateUser,
            .nameTextField,
            .userNameTextField,
            .emailTextField,
            .passwordTextField,
            .createUserButton,
            .alreadyHaveAccountButton
            ])
    case .auth?:
        state.authViewState = .auth([
            .titleLogo,
            .loginButton,
            .createUserButton
            ])
        
    }
    
    return state
}


struct AuthStatePresenter {
    let dataSource:[AuthCellType]
    
    init(authState:AuthState) {
        switch authState.authViewState {
        case .auth(let value):
            dataSource = value
        case .create(let value):
            dataSource = value
        case .forgot(let value):
            dataSource = value
        case .login(let value):
            dataSource = value
        default:
            dataSource = []
        }
    }
    
}
