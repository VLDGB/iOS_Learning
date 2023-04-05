//
//  App+Injection.swift
//  iOS_Learning
//
//  Created by Vlad_Rosca on 30.03.2023.
//

import Resolver

extension Resolver: ResolverRegistering {
    public static func registerAllServices() {
//        register { URLSessionRestClient() }.implements(RestClientProtocol.self)
        register { AlamofireRestClient() }.implements(RestClientProtocol.self)
        register { UserDefaultsStorageService() } .implements(StorageServiceProtocol.self)
        register { UserService() }.implements(UserServiceProtocol.self)
        register { LoginService() }.implements(LoginServiceProtocol.self)
        register { SignUpService() }.implements(SignUpServiceProtocol.self)
        register { LoginManager() }.implements(LoginManagerProtocol.self)
        register { SignUpManager() }.implements(SignUpManagerProtocol.self)
    }
}
