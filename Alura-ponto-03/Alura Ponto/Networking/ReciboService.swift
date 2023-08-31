//
//  ReciboService.swift
//  Alura Ponto
//
//  Created by Leandro Rodrigues on 31.08.23.
//

import Foundation

class ReciboService {
    
    func post(_ recibo: Recibo, completion: @escaping(_ salvo: Bool) -> Void) {
        let baseURL = "http://localhost:8080/"
        let path = "recibos"
        
        let parametros: [String: Any] = [
            "data": FormatadorDeData().getData(recibo.data),
            "status": recibo.status,
            "localizacao": [
                "latitude": recibo.latitude,
                "longitude": recibo.longitude
            ]
        ]
        
        guard let body = try? JSONSerialization.data(withJSONObject: parametros, options: []) else {return}
        
        guard let url = URL(string: baseURL + path) else {return}
        
        var requisicao = URLRequest(url: url)
        
        requisicao.httpMethod = "POST"
        
        requisicao.setValue("application/json", forHTTPHeaderField: "Content-Type")
        requisicao.httpBody = body
        
        URLSession.shared.dataTask(with: requisicao) {
            data, resposta, error in
            
            if let resposta = resposta {
                print(resposta)
            }
        
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print(json)
                } catch {
                    print(error)
                }
            }
            
            if error == nil {
                completion(true)
                return
            }
            
            completion(false)
        }.resume()
    }
    
}
