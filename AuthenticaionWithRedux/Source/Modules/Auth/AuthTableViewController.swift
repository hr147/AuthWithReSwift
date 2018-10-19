//
//  AuthTableViewController.swift
//  AuthenticaionWithRedux
//
//  Created by Haroon Ur Rasheed on 06/10/2018.
//  Copyright © 2018 Haroon Ur Rasheed. All rights reserved.
//

import UIKit
import SwiftLCS
import ReSwift


enum AuthCellType:String {
    case titleLogo = "CELL_ID_LOGO"
    case titleCreateUser = "CELL_ID_CREATE_TITLE"
    case titleUserLogin = "CELL_ID_LOGIN_TITLE"
    case titleForgot = "CELL_ID_FORGOT_TITLE"
    case emailTextField = "CELL_ID_EMAIL"
    case userNameTextField = "CELL_ID_USERNAME"
    case passwordTextField = "CELL_ID_PASSWORD"
    case nameTextField = "CELL_ID_NAME"
    case loginButton = "CELL_ID_LOGIN"
    case sendButton = "CELL_ID_SEND"
    case createUserButton = "CELL_ID_CREATE"
    case fogotButton = "CELL_ID_FORGOT"
    case dontHaveAccountButton = "CELL_ID_DONT_HAVE_ACCT"
    case alreadyHaveAccountButton = "CELL_ID_HAVE_ACCT"
}

class AuthTableViewController: UITableViewController {
    
    
    lazy var store:Store<AuthState> = {
        Store<AuthState>(reducer: authReducer,state:authReducer(AuthAction.auth, nil))
    }()
    var authDataSource:[AuthCellType] = []
    
    
    lazy var backgroundImageView:UIImageView = {
        let image = #imageLiteral(resourceName: "bg_auth")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
        
    }()
    
    lazy var custombackgroundView:UIView = {
        let view = UIView(frame: UIScreen.main.bounds)
        view.backgroundColor = .white
        return view
    }()
    
    //MARK:- Private Methods
    
    private func configureUI() {
        custombackgroundView.addSubview(backgroundImageView)
        //AutoLayout configuration
        backgroundImageView.topAnchor.constraint(equalTo: custombackgroundView.topAnchor).isActive = true
        backgroundImageView.centerXAnchor.constraint(equalTo: custombackgroundView.centerXAnchor).isActive = true
        //tableView configuration
        tableView.backgroundView = custombackgroundView
        tableView.contentInset = .init(top: backgroundImageView.bounds.height, left: 0, bottom: 0, right: 0)
    }
    
    //MARK:- View LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        store.subscribe(self){
            $0.select {
                AuthStatePresenter(authState: $0)
            }
        }
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        store.unsubscribe(self)
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return authDataSource.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = authDataSource[indexPath.row].rawValue
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        return cell
    }
    
    func transitionToViewState(newDataSource: [AuthCellType]) {
        let diff = authDataSource.diff(newDataSource)
        authDataSource = newDataSource
        
        tableView?.beginUpdates()
        tableView?.insertRows(at: indexPaths(fromIndexes: diff.addedIndexes), with: .fade)
        tableView?.deleteRows(at: indexPaths(fromIndexes: diff.removedIndexes), with: .fade)
        tableView?.endUpdates()
    }
    
    func indexPaths(fromIndexes indexes:[Int]) -> [IndexPath] {
        return indexes.compactMap {
            IndexPath(row: $0, section: 0)
        }
    }
    
   
    
    // MARK: - User Actions
    
    @IBAction func loginTouchedUp(_ sender: UIButton){
        store.dispatch(AuthAction.login)
    }
    
    @IBAction func forgotTouchedUp(_ sender: UIButton){
        store.dispatch(AuthAction.forgot)
    }
    
    @IBAction func dontHaveAccountTouchedUp(_ sender: UIButton){
        store.dispatch(AuthAction.create)
    }
    
    @IBAction func createAccountTouchedUp(_ sender: UIButton){
        store.dispatch(AuthAction.auth)
    }
    
    @IBAction func alreadyHaveAccountTouchedUp(_ sender: UIButton) {
        store.dispatch(AuthAction.login)
    }
    
    @IBAction func sendTouchedUp(_ sender: UIButton) {
        store.dispatch(AuthAction.auth)
    }
    
}

extension AuthTableViewController:StoreSubscriber{
    
    func newState(state: AuthStatePresenter) {
        
        if authDataSource.isEmpty {
            authDataSource = state.dataSource
            tableView.reloadData()
            return
        }
        
        transitionToViewState(newDataSource: state.dataSource)
    }
    
}
