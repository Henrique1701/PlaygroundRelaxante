//: # Playground Relaxante
import UIKit
import PlaygroundSupport
import AVFoundation
import WebKit

//: ## Tema
// Background tema
var backgroundImagem = UIImage(named: "tema01.png")
//let backgroundView = UIImageView(image: backgroundImagem)
//backgroundView.frame = CGRect(x: 0, y: 0, width: 1440, height: 900)

// Música tema
private var chompPlayer: AVAudioPlayer?
let player = Player()
chompPlayer = player.createPlayer(from: "som tema floresta")
chompPlayer?.numberOfLoops = 10
chompPlayer?.play()


// Controle música tema
var temaAtual = 1
//: ## Fontes
let cfURL = Bundle.main.url(forResource: "DancingScript", withExtension: "ttf")! as CFURL
CTFontManagerRegisterFontsForURL(cfURL, CTFontManagerScope.process, nil)
let dancingScript = UIFont(name: "Dancing Script", size: 45)
let dancingScript60 = UIFont(name: "Dancing Script", size: 60)
let dancingScript30 = UIFont(name: "Dancing Script", size: 30)
//: ## Entrada text fild
let textFieldSeuNome = UITextField()
var nomeUsuario = ""
//: ## View controller
class TelaInicialViewController : UIViewController, UIGestureRecognizerDelegate {
    
    let componentes = Componentes()
    let backgroundView = UIImageView(frame: CGRect(x: 0, y: 0, width: 1440, height: 900))
    
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .red
        
        // Imagem de fundo (tema)
        
        // Botão mudar tema
        let botaoMudarTema = componentes.botaoMudarTema
        botaoMudarTema.addTarget(self, action: #selector(mudarTema), for: .touchUpInside)
    
        // Botão parar música
        let botaoPararIniciarMusica = componentes.botaoPararIniciarMusica
        componentes.verificaImagemBotaoMusica(isPlaying: chompPlayer?.isPlaying ?? true)
        botaoPararIniciarMusica.addTarget(self, action: #selector(pararIniciarMusica), for: .touchUpInside)
        
        // Caixa de texto
        let caixaTextoView = componentes.caixaTextoView
        caixaTextoView.isUserInteractionEnabled = true
        let tocouCaixaTextoView = UITapGestureRecognizer(target: self, action: #selector(clicouCaixaTexto))
        caixaTextoView.addGestureRecognizer(tocouCaixaTextoView)
        
        // Texto
        let textoBoasVindas = UILabel(frame: CGRect(x: 485, y: 378, width: 469, height: 144))
        textoBoasVindas.font = dancingScript60
        textoBoasVindas.textAlignment = .center
        textoBoasVindas.lineBreakMode = .byWordWrapping
        textoBoasVindas.numberOfLines = 2
        textoBoasVindas.text = "Seja bem-vindo(a) ao\nPlayground Relaxante"
        
        let textoContinuar = UILabel(frame: CGRect(x: 756, y: 618, width: 268, height: 42))
        textoContinuar.font = dancingScript30
        textoContinuar.textColor = .darkGray
        textoContinuar.textAlignment = .right
        textoContinuar.text = "Clique para continuar"
        
        // Adiciona Subviews
        view.addSubview(backgroundView)
        view.addSubview(botaoMudarTema)
        view.addSubview(botaoPararIniciarMusica)
        view.addSubview(caixaTextoView)
        view.addSubview(textoBoasVindas)
        view.addSubview(textoContinuar)
        
        self.view = view
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print(backgroundView.superview?.backgroundColor == .red)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        backgroundView.image = backgroundImagem
    }
    
    // Funções
    @objc func clicouCaixaTexto() {
        print("Clicou na caixa de texto")
        navigationController?.pushViewController(primeiraViewController, animated: true)
    }
    
    @objc func pararIniciarMusica() {
        print("Clicou no botão")
        if chompPlayer?.isPlaying == true {
            print(" Parar música")
            chompPlayer?.pause()
            componentes.alterarBackgroundBotaoMusica(estadoBotao: "iniciar")
        } else {
            print(" Iniciar música")
            chompPlayer?.play()
            componentes.alterarBackgroundBotaoMusica(estadoBotao: "parar")
        }
    }
    
    @objc func mudarTema() {
        navigationController?.pushViewController(temasViewController, animated: true)
    }
}

class PrimeiraViewController : UIViewController, UITextFieldDelegate, UIGestureRecognizerDelegate {
    
    let componentes = Componentes()
    let backgroundView = UIImageView(frame: CGRect(x: 0, y: 0, width: 1440, height: 900))
    
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .red
        
        // Imagem de fundo (tema)
        backgroundView.image = backgroundImagem
        
        // Botão mudar tema
        let botaoMudarTema = componentes.botaoMudarTema
        botaoMudarTema.addTarget(self, action: #selector(mudarTema), for: .touchUpInside)
        
        // Botão parar música
        let botaoPararIniciarMusica = componentes.botaoPararIniciarMusica
        componentes.verificaImagemBotaoMusica(isPlaying: chompPlayer?.isPlaying ?? true)
        botaoPararIniciarMusica.addTarget(self, action: #selector(pararIniciarMusica), for: .touchUpInside)
        
        // Caixa de texto, com label
        let caixaTextoView = componentes.caixaTextoView
        caixaTextoView.isUserInteractionEnabled = true
        let tocouCaixaTexto = UITapGestureRecognizer(target: self, action: #selector(clicouCaixaTexto))
        caixaTextoView.addGestureRecognizer(tocouCaixaTexto)
        
        // Texto
        let textoConversa = UILabel(frame: CGRect(x: 542, y: 420, width: 357, height: 60))
        textoConversa.font = dancingScript
        textoConversa.backgroundColor = UIColor.transparente()
        textoConversa.text = "Qual é o seu nome ?"
        textoConversa.textAlignment = .center
        
        // Text field seu nome
        textFieldSeuNome.frame = CGRect(x: 394, y: 738, width: 651, height: 78)
        textFieldSeuNome.delegate = self
        textFieldSeuNome.background = UIImage(named: "Text field-2.png")//#imageLiteral(resourceName: "ImagemTextField.png")
        textFieldSeuNome.placeholder = "Seu nome"
        textFieldSeuNome.font = dancingScript?.withSize(40)
        textFieldSeuNome.textAlignment = .center
        
        // Adiciona Subviews
        view.addSubview(textFieldSeuNome)
        view.addSubview(caixaTextoView)
        view.addSubview(textoConversa)
        view.addSubview(botaoMudarTema)
        view.addSubview(botaoPararIniciarMusica)
        //view.addSubview(animalView)
        
        self.view = view
        
    }
    
    override func viewDidLoad() {
        // Imprimir todas as fontes
        view.addSubview(backgroundView)
//        for family in UIFont.familyNames {
//            print("\(family)")
//            for name in UIFont.fontNames(forFamilyName: family) {
//                print("   \(name)")
//            }
//        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print(self.backgroundView.superview)
        self.backgroundView.image = backgroundImagem
    }
    
    // Funções
    @objc func clicouCaixaTexto() {
        print("Clicou na caixa de texto")
        //show(secondViewController, sender: nil)
        //present(secondViewController, animated: true, completion: nil)
        //navigationController?.pushViewController(segundaViewController, animated: true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        nomeUsuario = textFieldSeuNome.text!
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textFieldSeuNome.resignFirstResponder()
        print(nomeUsuario)
        return true;
    }
    
    @objc func pararIniciarMusica() {
        if chompPlayer?.isPlaying == true {
            chompPlayer?.pause()
            componentes.alterarBackgroundBotaoMusica(estadoBotao: "iniciar")
        } else {
            chompPlayer?.play()
            componentes.alterarBackgroundBotaoMusica(estadoBotao: "parar")
        }
        
    }
    
    @objc func mudarTema() {
        navigationController?.pushViewController(temasViewController, animated: true)
    }
}

class TemasViewController: UIViewController {
    
    let componentes = Componentes()
    let backgroundView = UIImageView(frame: CGRect(x: 0, y: 0, width: 1440, height: 900))
    
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .systemTeal
        
        // Imagem de fundo (tema)
        backgroundView.image = backgroundImagem
        
        // Botão mudar tema
        let botaoMudarTema = componentes.botaoMudarTema
        
        // Botão parar música
        let botaoPararIniciarMusica = componentes.botaoPararIniciarMusica
        componentes.verificaImagemBotaoMusica(isPlaying: chompPlayer?.isPlaying ?? true)
        botaoPararIniciarMusica.addTarget(self, action: #selector(pararIniciarMusica), for: .touchUpInside)
        
        // Caixa de texto
        let caixaTextoView = componentes.caixaTextoView

        let titulo = UILabel(frame: CGRect(x: 665, y: 237, width: 108, height: 42))
        titulo.font = dancingScript
        titulo.textAlignment = .center
        titulo.text = "Temas"
        
        // Botões mudar tema
        let botaoTema01 = UIButton(frame: CGRect(x: 487, y: 299, width: 139, height: 139))
        botaoTema01.setBackgroundImage(UIImage(named: "Botão tema 01.png"), for: .normal)
        botaoTema01.tag = 1
        botaoTema01.addTarget(self, action: #selector(TemasViewController.mudarTema(sender:)), for: .touchUpInside)
        
        let botaoTema02 = UIButton(frame: CGRect(x: 650, y: 299, width: 139, height: 139))
        botaoTema02.setBackgroundImage(UIImage(named: "Botão tema02.png"), for: .normal)
        botaoTema02.tag = 2
        botaoTema02.addTarget(self, action: #selector(TemasViewController.mudarTema(sender:)), for: .touchUpInside)
        
        let botaoTema03 = UIButton(frame: CGRect(x: 813, y: 299, width: 139, height: 139))
        botaoTema03.setBackgroundImage(UIImage(named: "Botão tema03.png"), for: .normal)
        botaoTema03.tag = 3
        botaoTema03.addTarget(self, action: #selector(TemasViewController.mudarTema(sender:)), for: .touchUpInside)
        
        let botaoTema04 = UIButton(frame: CGRect(x: 487, y: 462, width: 139, height: 139))
        botaoTema04.setBackgroundImage(UIImage(named: "Botão tema04.png"), for: .normal)
        botaoTema04.tag = 4
        botaoTema04.addTarget(self, action: #selector(TemasViewController.mudarTema(sender:)), for: .touchUpInside)
        
        let botaoTema05 = UIButton(frame: CGRect(x: 651, y: 462, width: 139, height: 139))
        botaoTema05.setBackgroundImage(UIImage(named: "Botão tema05.png"), for: .normal)
        botaoTema05.tag = 5
        botaoTema05.addTarget(self, action: #selector(TemasViewController.mudarTema(sender:)), for: .touchUpInside)
        
        let botaoTema06 = UIButton(frame: CGRect(x: 813, y: 462, width: 139, height: 139))
        botaoTema06.setBackgroundImage(UIImage(named: "Botão tema06.png"), for: .normal)
        botaoTema06.tag = 6
        botaoTema06.addTarget(self, action: #selector(TemasViewController.mudarTema(sender:)), for: .touchUpInside)
        
        // Adiciona Subviews
        view.addSubview(backgroundView)
        view.addSubview(caixaTextoView)
        view.addSubview(titulo)
        view.addSubview(botaoMudarTema)
        view.addSubview(botaoPararIniciarMusica)
        view.addSubview(botaoTema01)
        view.addSubview(botaoTema02)
        view.addSubview(botaoTema03)
        view.addSubview(botaoTema04)
        view.addSubview(botaoTema05)
        view.addSubview(botaoTema06)
        self.view = view
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        backgroundView.image = backgroundImagem
//    }
    
    // Funções
    @objc func pararIniciarMusica() {
        if chompPlayer?.isPlaying == true {
            chompPlayer?.pause()
            componentes.alterarBackgroundBotaoMusica(estadoBotao: "iniciar")
        } else {
            chompPlayer?.play()
            componentes.alterarBackgroundBotaoMusica(estadoBotao: "parar")
        }
    }
    
    @objc func mudarTema(sender: UIButton) {
        
        let tema = sender.tag
        let temaAnterior = temaAtual
        
        if tema == 1 {
            print("Clicou no tema 1")
            backgroundImagem = UIImage(named: "tema01.png")
            backgroundView.image = backgroundImagem
            temaAtual = 1
        } else if tema == 2 {
            print("Clicou no tema 2")
            backgroundImagem = UIImage(named: "tema02.jpg")
            backgroundView.image = backgroundImagem
            temaAtual = 2
        } else if tema == 3 {
            print("Clicou no tema 3")
            backgroundImagem = UIImage(named: "tema03.jpg")
            backgroundView.image = backgroundImagem
            temaAtual = 3
        } else if tema == 4 {
            print("Clicou no tema 4")
            backgroundImagem = UIImage(named: "tema04.jpeg")
            backgroundView.image = backgroundImagem
            temaAtual = 4
        } else if tema == 5 {
            print("Clicou no tema 5")
            backgroundImagem = UIImage(named: "tema05.jpg")
            backgroundView.image = backgroundImagem
            temaAtual = 5
        } else {
            print("Clicou no tema 6")
            backgroundImagem = UIImage(named: "tema06.jpg")
            backgroundView.image = backgroundImagem
            temaAtual = 6
        }
        
        if temaAtual == 1 || temaAtual == 2 || temaAtual == 3 {
            if temaAnterior == 4 || temaAnterior == 5 || temaAnterior == 6 {
                chompPlayer = player.createPlayer(from: "som tema floresta")
                chompPlayer?.numberOfLoops = 10
                chompPlayer?.play()
            }
        } else {
            if temaAnterior == 1 || temaAnterior == 2 || temaAnterior == 3 {
                chompPlayer = player.createPlayer(from: "som tema agua")
                chompPlayer?.numberOfLoops = 10
                chompPlayer?.play()
            }
        }
        
        navigationController?.popViewController(animated: true)
    }
}


class TesteWebView: UIViewController, WKUIDelegate {
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .systemTeal
        
        let url = URL(string: "https://www.youtube.com/watch?v=mTJ56qy2Flg")!
        
        let request = URLRequest(url: url)
        
        let webConfiguration = WKWebViewConfiguration()
        webConfiguration.ignoresViewportScaleLimits = true
        
        let webView = WKWebView(frame: CGRect(x: 227, y: 174, width: 985, height: 552), configuration: webConfiguration)
        //webView.configuration = webConfiguration
        webView.load(request)
        webView.uiDelegate = self
        
        view.addSubview(webView)
        
        self.view = view
    }
}
extension UIColor {
    class func transparente() -> UIColor {
        return UIColor(white: 1.0, alpha: 0)
    }
}

// Present the view controller in the Live View window
let telaInicial = TelaInicialViewController(screenType: .mac, isPortrait: true)
let primeiraViewController = PrimeiraViewController(screenType: .mac, isPortrait: true)
let temasViewController = TemasViewController(screenType: .mac, isPortrait: true)
let testeWebView = TesteWebView(screenType: .mac, isPortrait: true)

let navigation = UINavigationController(screenType: .mac, isPortrait: true)
navigation.navigationBar.isHidden = true
navigation.pushViewController(telaInicial, animated: true)

PlaygroundPage.current.liveView = navigation.scale(to: 0.5)

//: # Navegação

