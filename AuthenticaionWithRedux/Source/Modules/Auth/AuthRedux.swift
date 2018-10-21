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
}

struct AuthState:StateType {
    var authViewState:AuthViewState<[AuthCellType]>
}

enum AuthAction:Action {
    case login
    case forgot
    case create
    case auth
}

func authReducer(_ action: Action, _ state: AuthState?) -> AuthState{
    
    let authViewStates:[AuthCellType] = [
        .titleLogo,
        .loginButton,
        .createUserButton
    ]
    
    var state = state ?? AuthState(authViewState: .auth(authViewStates))
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
        state.authViewState = .auth(authViewStates)
        
    }
    
    return state
}


struct AuthStatePresenter {
    let dataSource:[AuthCellType]
    let validator:AuthValidateable?
    
    init(authState:AuthState) {
        
        
        switch authState.authViewState {
        case .auth(let value):
            dataSource = value
            validator = nil
        case .create(let value):
            dataSource = value
            validator = RegisterValidator()
        case .forgot(let value):
            dataSource = value
            validator = ForgotValidator()
        case .login(let value):
            dataSource = value
            validator = LoginValidator()
        }
    }
    
}

enum AuthError:Error {
    case invalidEmail
    case invalidPassword
    case invalidUserName
    case invalidName
}

extension AuthError:CustomStringConvertible {
    var description: String {
        switch self {
        case .invalidEmail: return "Email is inValid"
        case .invalidName: return "Name is inValid"
        case .invalidPassword: return "Password is inValid"
        case .invalidUserName: return "User Name is inValid"
        }
    }
    
    
}

protocol AuthValidateable {
    func validate(withUser user:User) throws
}


struct LoginValidator:AuthValidateable {
    
    func validate(withUser user:User) throws {
        guard !user.email.isEmpty else { throw AuthError.invalidEmail }
        guard !user.password.isEmpty else { throw AuthError.invalidPassword }
        print("valid for Login")
    }
}

struct ForgotValidator:AuthValidateable {
    
    func validate(withUser user:User) throws {
        guard !user.email.isEmpty else { throw AuthError.invalidEmail }
        print("valid for Forgot")
    }
}

struct RegisterValidator:AuthValidateable {
    
   func validate(withUser user:User) throws {
        guard !user.name.isEmpty else { throw AuthError.invalidName }
        guard !user.userName.isEmpty else { throw AuthError.invalidUserName }
        guard !user.email.isEmpty else { throw AuthError.invalidEmail }
        guard !user.password.isEmpty else { throw AuthError.invalidPassword }
        print("valid for signUp")
    }
}

class User {
    var name:String = ""
    var email:String = ""
    var password:String = ""
    var userName:String = ""
}
