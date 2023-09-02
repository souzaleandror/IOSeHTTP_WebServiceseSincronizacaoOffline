//
//  AutenticacaoLocal.swift
//  Alura Ponto
//
//  Created by Ândriu Coelho on 01/11/21.
//

import Foundation
import LocalAuthentication

class AutenticacaoLocal {
    
    private let authenticatorContext = LAContext()
    private var error: NSError?
    
    func autorizaUsuario(completion: @escaping(_ autenticao: Bool) -> Void) {
        if authenticatorContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            authenticatorContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "É necessário autenticação para apagar um recibo") { sucesso, error in
                
                completion(sucesso)
            }
        }
    }
}
