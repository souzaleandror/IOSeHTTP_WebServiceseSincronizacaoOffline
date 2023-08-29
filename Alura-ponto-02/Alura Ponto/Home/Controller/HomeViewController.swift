//
//  HomeViewController.swift
//  Alura Ponto
//
//  Created by Ândriu Felipe Coelho on 22/09/21.
//

import UIKit
import CoreData

class HomeViewController: UIViewController {

    // MARK: - IBOutlets

    @IBOutlet weak var horarioView: UIView!
    @IBOutlet weak var horarioLabel: UILabel!
    @IBOutlet weak var registrarButton: UIButton!

    // MARK: - Attributes
    
    private var timer: Timer?
    private lazy var camera = Camera()
    private lazy var controladorDeImagem = UIImagePickerController()
    
    private var latitude: CLLocationDegrees?
    private var longitude: CLLocationDegrees?
    
    var contexto: NSManagedObjectContext = {
        let contexto = UIApplication.shared.delegate as! AppDelegate
        
        return contexto.persistentContainer.viewContext
    }()
    
    lazy var gerenciadorDeLocalizacao = CLLocationManager()
    private lazy var localizacao = Localizacao()
    
    // MARK: - View life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configuraView()
        atualizaHorario()
        requisicaoDaLocalizacaoDoUsuario()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        configuraTimer()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        timer?.invalidate()
    }
    
    // MARK: - Class methods
    
    func configuraView() {
        configuraBotaoRegistrar()
        configuraHorarioView()
    }
    
    func configuraBotaoRegistrar() {
        registrarButton.layer.cornerRadius = 5
    }
    
    func configuraHorarioView() {
        horarioView.backgroundColor = .white
        horarioView.layer.borderWidth = 3
        horarioView.layer.borderColor = UIColor.systemGray.cgColor
        horarioView.layer.cornerRadius = horarioView.layer.frame.height/2
    }
    
    func configuraTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(atualizaHorario), userInfo: nil, repeats: true)
    }
    
    @objc func atualizaHorario() {
        let horarioAtual = FormatadorDeData().getHorario(Date())
        horarioLabel.text = horarioAtual
    }
    
    func tentaAbrirCamera() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            camera.delegate = self
            camera.abrirCamera(self, controladorDeImagem)
        }
    }
    
    func requisicaoDaLocalizacaoDoUsuario() {
        localizacao.delegate = self
        localizacao.permissao(gerenciadorDeLocalizacao)
    }
    
    // MARK: - IBActions
    
    @IBAction func registrarButton(_ sender: UIButton) {
        tentaAbrirCamera()
    }
}

extension HomeViewController: CameraDelegate {
    func didSelectFoto(_ image: UIImage) {
        let recibo = Recibo(status: false, data: Date(), foto: image, latitude: latitude ?? 0.0, longitude: longitude ?? 0.0)
        recibo.salvar(contexto)
    }
}

extension HomeViewController: LocalizacaoDelegate {
    func atualizaLocalizacaoDoUsuario(latitude: Double?, longitude: Double?) {
        self.latitude = latitude ?? 0.0
        self.longitude = longitude ?? 0.0
    }
}
