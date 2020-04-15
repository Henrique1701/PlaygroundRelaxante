//: # Playground Relaxante
import UIKit
import PlaygroundSupport
import AVFoundation

//: ## Tema
private var chompPlayer: AVAudioPlayer?
let player = Player()
chompPlayer = player.createPlayer(from: "som tema floresta")
chompPlayer?.numberOfLoops = 10
chompPlayer?.play()

// Controle música tema
var temaAtual = 1

var backgroundImagem = UIImage(named: "tema01.png")
let backgroundView = UIImageView(image: backgroundImagem)
backgroundView.frame = CGRect(x: 0, y: 0, width: 1440, height: 900)

//: ## Fontes
let cfURL = Bundle.main.url(forResource: "DancingScript", withExtension: "ttf")! as CFURL
CTFontManagerRegisterFontsForURL(cfURL, CTFontManagerScope.process, nil)
let dancingScript = UIFont(name: "Dancing Script", size: 45)
let dancingScript60 = UIFont(name: "Dancing Script", size: 60)
let dancingScript30 = UIFont(name: "Dancing Script", size: 30)

//: ## Entrada text fild
let textFieldSeuNome = UITextField()
var nomeUsuario = ""

//: ## Componentes gerais
let componentes = Componentes()
// Botão mudar tema
let botaoMudarTema = UIButton()
botaoMudarTema.frame = CGRect(x: 1260, y: 13, width: 164, height: 35)
let imagemBotaoMudarTema = UIImage(named: "Mudar tema-2.png")//#imageLiteral(resourceName: "Mudar tema.png")
botaoMudarTema.setBackgroundImage(imagemBotaoMudarTema, for: .normal)

// Botão parar/iniciar música
let botaoPararIniciarMusica = UIButton()
botaoPararIniciarMusica.frame = CGRect(x: 1260, y: 57, width: 164, height: 35)
let imagemBotaoMusica = UIImage(named: "Parar música-2.png")//#imageLiteral(resourceName: "Parar música.png")
botaoPararIniciarMusica.setBackgroundImage(imagemBotaoMusica, for: .normal)

// Caixa de texto
let imagemCaixaTexto = UIImage(named: "Caixa de texto-2.png")//#imageLiteral(resourceName: "CaixaDeTexto.png")
let caixaTextoView = UIImageView(image: imagemCaixaTexto)
caixaTextoView.frame = CGRect(x: 394, y: 221, width: 651, height: 458)
//: ## View controller
class TelaInicialViewController : UIViewController, UIGestureRecognizerDelegate {
    
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .systemTeal
        
        // Botão mudar tema
        let botaoMudarTema = componentes.botaoMudarTema
        botaoMudarTema.addTarget(self, action: #selector(mudarTema), for: .touchUpInside)
    
        // Botão parar música
        let botaoPararIniciarMusica = componentes.botaoPararIniciarMusica
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
        view.addSubview(componentes.backgroundView)
        view.addSubview(botaoMudarTema)
        view.addSubview(botaoPararIniciarMusica)
        view.addSubview(caixaTextoView)
        view.addSubview(textoBoasVindas)
        view.addSubview(textoContinuar)
        
        self.view = view
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
    
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .systemTeal
        
        // Imagem de fundo (tema)
        
        // Botão mudar tema
        botaoMudarTema.addTarget(self, action: #selector(mudarTema), for: .touchUpInside)
        
        // Botão parar música
        botaoPararIniciarMusica.addTarget(self, action: #selector(pararIniciarMusica), for: .touchUpInside)
        
        // Caixa de texto, com label
        let textConversa = UILabel(frame: CGRect(x: 542, y: 420, width: 357, height: 60))
        textConversa.font = dancingScript
        textConversa.backgroundColor = UIColor.transparente()
        textConversa.text = "Qual é o seu nome ?"
        textConversa.textAlignment = .center
        
        caixaTextoView.isUserInteractionEnabled = true
        let tocouCaixaTexto = UITapGestureRecognizer(target: self, action: #selector(clicouCaixaTexto))
        caixaTextoView.addGestureRecognizer(tocouCaixaTexto)
        
        
        // Text field seu nome
        textFieldSeuNome.frame = CGRect(x: 394, y: 738, width: 651, height: 78)
        textFieldSeuNome.delegate = self
        textFieldSeuNome.background = UIImage(named: "Text field-2.png")//#imageLiteral(resourceName: "ImagemTextField.png")
        textFieldSeuNome.placeholder = "Seu nome"
        textFieldSeuNome.font = dancingScript?.withSize(40)
        textFieldSeuNome.textAlignment = .center
        
        // Adiciona Subviews
        view.addSubview(backgroundView)
        view.addSubview(textFieldSeuNome)
        view.addSubview(caixaTextoView)
        view.addSubview(textConversa)
        view.addSubview(botaoMudarTema)
        view.addSubview(botaoPararIniciarMusica)
        //view.addSubview(animalView)
        
        self.view = view
        
    }
    
    override func viewDidLoad() {
        // Imprimir todas as fontes
        for family in UIFont.familyNames {
            print("\(family)")
            for name in UIFont.fontNames(forFamilyName: family) {
                print("   \(name)")
            }
        }
    }
    
    // Funções
    @objc func clicouCaixaTexto() {
        print("Clicou na caixa de texto")
        //show(secondViewController, sender: nil)
        //present(secondViewController, animated: true, completion: nil)
        navigationController?.pushViewController(segundaViewController, animated: true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        nomeUsuario = textFieldSeuNome.text!
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textFieldSeuNome.resignFirstResponder()
        return true;
    }
    
    @objc func pararIniciarMusica() {
        if chompPlayer?.isPlaying == true {
            chompPlayer?.pause()
            let imagemIniciarMusica = UIImage(named: "Iniciar música-2.png")//#imageLiteral(resourceName: "Inicar música.png")
            botaoPararIniciarMusica.setBackgroundImage(imagemIniciarMusica, for: .normal)
        } else {
            chompPlayer?.play()
            let imagemPararMusica = UIImage(named: "Parar música-2.png")//#imageLiteral(resourceName: "Parar música.png")
            botaoPararIniciarMusica.setBackgroundImage(imagemPararMusica, for: .normal)
        }
        
    }
    
    @objc func mudarTema() {
        navigationController?.pushViewController(temasViewController, animated: true)
    }
}

class SegundaViewController : UIViewController {
    override func loadView() {
        view = UIView()
        view.backgroundColor = .systemTeal
        
        // Botão mudar tema
        botaoMudarTema.addTarget(self, action: #selector(mudarTema), for: .touchUpInside)
        
        // Botão parar música
        botaoPararIniciarMusica.addTarget(self, action: #selector(pararIniciarMusica), for: .touchUpInside)
        
        // Caixa de texto, com label
        let textConversa = UILabel(frame: CGRect(x: 542, y: 420, width: 357, height: 60))
        textConversa.font = dancingScript
        textConversa.backgroundColor = UIColor.transparente()
        textConversa.text = "Qual é o seu nome ?"
        textConversa.textAlignment = .center
        
        caixaTextoView.isUserInteractionEnabled = true
        let tocouCaixaTexto = UITapGestureRecognizer(target: self, action: #selector(clicouCaixaTexto))
        caixaTextoView.addGestureRecognizer(tocouCaixaTexto)
        
        view.addSubview(backgroundView)
        view.addSubview(botaoMudarTema)
        view.addSubview(botaoPararIniciarMusica)
        
        self.view = view
    }
    
    // Funções
    @objc func clicouCaixaTexto() {
        print("Clicou na caixa de texto")
        //show(secondViewController, sender: nil)
        //present(secondViewController, animated: true, completion: nil)
        //navigationController?.pushViewController(segundaViewController, animated: true)
    }
    
    @objc func pararIniciarMusica() {
        if chompPlayer?.isPlaying == true {
            chompPlayer?.pause()
            let imagemIniciarMusica = UIImage(named: "Iniciar música-2.png")//#imageLiteral(resourceName: "Inicar música.png")
            botaoPararIniciarMusica.setBackgroundImage(imagemIniciarMusica, for: .normal)
        } else {
            chompPlayer?.play()
            let imagemPararMusica = UIImage(named: "Parar música-2.png")//#imageLiteral(resourceName: "Parar música.png")
            botaoPararIniciarMusica.setBackgroundImage(imagemPararMusica, for: .normal)
        }
        
    }
    
    @objc func mudarTema() {
        navigationController?.pushViewController(temasViewController, animated: true)
    }
}

/*
class SegundaViewController: UIViewController {
    
    let botaoPararIniciarMusica = UIButton()
    
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .systemTeal
        
        // Imagem de fundo (tema)
        //let backgroundImagem = #imageLiteral(resourceName: "tema01.png")
        let backgroundView = UIImageView(image: backgroundImagem)
        backgroundView.frame = CGRect(x: 0, y: 0, width: 1440, height: 900)
        
        // Botão mudar tema
        let botaoMudarTema = UIButton()
        botaoMudarTema.frame = CGRect(x: 1260, y: 13, width: 164, height: 35)
        let imagemBotaoMudarTema = #imageLiteral(resourceName: "Mudar tema.png")
        botaoMudarTema.setBackgroundImage(imagemBotaoMudarTema, for: .normal)
        
        // Botão parar música
        botaoPararIniciarMusica.frame = CGRect(x: 1260, y: 57, width: 164, height: 35)
        if chompPlayer?.isPlaying == true {
            let imagemIniciarMusica = #imageLiteral(resourceName: "Inicar música.png")
            botaoPararIniciarMusica.setBackgroundImage(imagemIniciarMusica, for: .normal)
        } else {
            let imagemPararMusica = #imageLiteral(resourceName: "Parar música.png")
            botaoPararIniciarMusica.setBackgroundImage(imagemPararMusica, for: .normal)
        }
        botaoPararIniciarMusica.addTarget(self, action: #selector(pararIniciarMusica), for: .touchUpInside)
        
        // Caixa de texto, com label
        let imagemCaixaTexto = #imageLiteral(resourceName: "CaixaDeTexto.png")
        let caixaTextoView = UIImageView(image: imagemCaixaTexto)
        caixaTextoView.frame = CGRect(x: 394, y: 221, width: 651, height: 458)
        
        let textViewConversa = UITextView(frame: CGRect(x: 545, y: 375, width: 350, height: 179))
        textViewConversa.backgroundColor = UIColor.transparente()
        textViewConversa.text = "Então, \(nomeUsuario), não sei o que está causando a sua ansiedade."
        textViewConversa.textAlignment = .center
        
        // Botão caixa de texto
        let botaoCaixaTexto = UIButton(frame: CGRect(x: 394, y: 221, width: 651, height: 458))
        botaoCaixaTexto.backgroundColor = UIColor.transparente()
        botaoCaixaTexto.addTarget(nil, action: #selector(clicouCaixaTexto), for: .touchUpInside)
        
        // Adiciona Subviews
        view.addSubview(backgroundView)
        view.addSubview(caixaTextoView)
        view.addSubview(textViewConversa)
        view.addSubview(botaoMudarTema)
        view.addSubview(botaoPararIniciarMusica)
        view.addSubview(botaoCaixaTexto)
        self.view = view
    }
    
    override func viewDidLoad() {
        // Imagem de fundo (tema)
        //let backgroundView = UIImageView(image: backgroundImagem)
        //backgroundView.frame = CGRect(x: 0, y: 0, width: 1440, height: 900)
        backgroundView.image = backgroundImagem
    }
    
    // Funções
    @objc func clicouCaixaTexto() {
        navigationController?.pushViewController(terceiraViewController, animated: true)
    }
    
    @objc func pararIniciarMusica() {
        if chompPlayer?.isPlaying == true {
            chompPlayer?.pause()
            let imagemIniciarMusica = #imageLiteral(resourceName: "Inicar música.png")
            botaoPararIniciarMusica.setBackgroundImage(imagemIniciarMusica, for: .normal)
        } else {
            chompPlayer?.play()
            let imagemPararMusica = #imageLiteral(resourceName: "Parar música.png")
            botaoPararIniciarMusica.setBackgroundImage(imagemPararMusica, for: .normal)
        }
        
    }
}

class TerceiraViewController: UIViewController {
    
    let botaoPararIniciarMusica = UIButton()
    
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .systemTeal
        
        // Imagem de fundo (tema)
        let backgroundImagem = #imageLiteral(resourceName: "tema01.png")
        let backgroundView = UIImageView(image: backgroundImagem)
        backgroundView.frame = CGRect(x: 0, y: 0, width: 1440, height: 900)
        
        // Botão mudar tema
        let botaoMudarTema = UIButton()
        botaoMudarTema.frame = CGRect(x: 1260, y: 13, width: 164, height: 35)
        let imagemBotaoMudarTema = #imageLiteral(resourceName: "Mudar tema.png")
        botaoMudarTema.setBackgroundImage(imagemBotaoMudarTema, for: .normal)
        
        // Botão parar música
        botaoPararIniciarMusica.frame = CGRect(x: 1260, y: 57, width: 164, height: 35)
        if chompPlayer?.isPlaying == true {
            let imagemIniciarMusica = #imageLiteral(resourceName: "Inicar música.png")
            botaoPararIniciarMusica.setBackgroundImage(imagemIniciarMusica, for: .normal)
        } else {
            let imagemPararMusica = #imageLiteral(resourceName: "Parar música.png")
            botaoPararIniciarMusica.setBackgroundImage(imagemPararMusica, for: .normal)
        }
        botaoPararIniciarMusica.addTarget(self, action: #selector(pararIniciarMusica), for: .touchUpInside)
        
        // Caixa de texto, com label
        let imagemCaixaTexto = #imageLiteral(resourceName: "CaixaDeTexto.png")
        let caixaTextoView = UIImageView(image: imagemCaixaTexto)
        caixaTextoView.frame = CGRect(x: 394, y: 221, width: 651, height: 458)
        
        let textViewConversa = UITextView(frame: CGRect(x: 545, y: 375, width: 350, height: 179))
        textViewConversa.backgroundColor = UIColor.transparente()
        textViewConversa.text = "Mas, estou aqui para te ajudar a controlar essa ansiedade !"
        textViewConversa.textAlignment = .center
        
        // Botão caixa de texto
        let botaoCaixaTexto = UIButton(frame: CGRect(x: 394, y: 221, width: 651, height: 458))
        botaoCaixaTexto.backgroundColor = UIColor.transparente()
        botaoCaixaTexto.addTarget(nil, action: #selector(clicouCaixaTexto), for: .touchUpInside)
        
        // Adiciona Subviews
        view.addSubview(backgroundView)
        view.addSubview(caixaTextoView)
        view.addSubview(textViewConversa)
        view.addSubview(botaoMudarTema)
        view.addSubview(botaoPararIniciarMusica)
        view.addSubview(botaoCaixaTexto)
        self.view = view
    }
    
    // Funções
    @objc func clicouCaixaTexto() {
        navigationController?.pushViewController(quartaViewController, animated: true)
    }
    
    @objc func pararIniciarMusica() {
        if chompPlayer?.isPlaying == true {
            chompPlayer?.pause()
            let imagemIniciarMusica = #imageLiteral(resourceName: "Inicar música.png")
            botaoPararIniciarMusica.setBackgroundImage(imagemIniciarMusica, for: .normal)
        } else {
            chompPlayer?.play()
            let imagemPararMusica = #imageLiteral(resourceName: "Parar música.png")
            botaoPararIniciarMusica.setBackgroundImage(imagemPararMusica, for: .normal)
        }
        
    }
}

class QuartaViewController: UIViewController {
    
    let botaoPararIniciarMusica = UIButton()
    
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .systemTeal
        
        // Imagem de fundo (tema)
        let backgroundImagem = #imageLiteral(resourceName: "tema01.png")
        let backgroundView = UIImageView(image: backgroundImagem)
        backgroundView.frame = CGRect(x: 0, y: 0, width: 1440, height: 900)
        
        // Botão mudar tema
        let botaoMudarTema = UIButton()
        botaoMudarTema.frame = CGRect(x: 1260, y: 13, width: 164, height: 35)
        let imagemBotaoMudarTema = #imageLiteral(resourceName: "Mudar tema.png")
        botaoMudarTema.setBackgroundImage(imagemBotaoMudarTema, for: .normal)
        
        // Botão parar música
        botaoPararIniciarMusica.frame = CGRect(x: 1260, y: 57, width: 164, height: 35)
        if chompPlayer?.isPlaying == true {
            let imagemIniciarMusica = #imageLiteral(resourceName: "Inicar música.png")
            botaoPararIniciarMusica.setBackgroundImage(imagemIniciarMusica, for: .normal)
        } else {
            let imagemPararMusica = #imageLiteral(resourceName: "Parar música.png")
            botaoPararIniciarMusica.setBackgroundImage(imagemPararMusica, for: .normal)
        }
        botaoPararIniciarMusica.addTarget(self, action: #selector(pararIniciarMusica), for: .touchUpInside)
        
        // Caixa de texto, com label
        let imagemCaixaTexto = #imageLiteral(resourceName: "CaixaDeTexto.png")
        let caixaTextoView = UIImageView(image: imagemCaixaTexto)
        caixaTextoView.frame = CGRect(x: 394, y: 221, width: 651, height: 458)
        
        let textViewConversa = UITextView(frame: CGRect(x: 545, y: 375, width: 350, height: 179))
        textViewConversa.backgroundColor = UIColor.transparente()
        textViewConversa.text = "O que você gostaria de fazer agora ?"
        textViewConversa.textAlignment = .center
        
        // Botão caixa de texto
        let botaoCaixaTexto = UIButton(frame: CGRect(x: 394, y: 221, width: 651, height: 458))
        botaoCaixaTexto.backgroundColor = UIColor.transparente()
        botaoCaixaTexto.addTarget(nil, action: #selector(clicouCaixaTexto), for: .touchUpInside)
        
        // Adiciona Subviews
        view.addSubview(backgroundView)
        view.addSubview(caixaTextoView)
        view.addSubview(textViewConversa)
        view.addSubview(botaoMudarTema)
        view.addSubview(botaoPararIniciarMusica)
        view.addSubview(botaoCaixaTexto)
        self.view = view
    }
    
    // Funções
    @objc func clicouCaixaTexto() {
        
    }
    
    @objc func pararIniciarMusica() {
        if chompPlayer?.isPlaying == true {
            chompPlayer?.pause()
            let imagemIniciarMusica = #imageLiteral(resourceName: "Inicar música.png")
            botaoPararIniciarMusica.setBackgroundImage(imagemIniciarMusica, for: .normal)
        } else {
            chompPlayer?.play()
            let imagemPararMusica = #imageLiteral(resourceName: "Parar música.png")
            botaoPararIniciarMusica.setBackgroundImage(imagemPararMusica, for: .normal)
        }
    }
}
*/

class TemasViewController: UIViewController {
    
    let botaoPararIniciarMusica = UIButton()
    
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .systemTeal
        
        // Imagem de fundo (tema)
        let backgroundView = UIImageView(image: backgroundImagem)
        backgroundView.frame = CGRect(x: 0, y: 0, width: 1440, height: 900)
        
        // Botão mudar tema
        let botaoMudarTema = UIButton()
        botaoMudarTema.frame = CGRect(x: 1260, y: 13, width: 164, height: 35)
        let imagemBotaoMudarTema = #imageLiteral(resourceName: "Mudar tema.png")
        botaoMudarTema.setBackgroundImage(imagemBotaoMudarTema, for: .normal)
        
        // Botão parar música
        botaoPararIniciarMusica.frame = CGRect(x: 1260, y: 57, width: 164, height: 35)
        if chompPlayer?.isPlaying == true {
            let imagemIniciarMusica = #imageLiteral(resourceName: "Inicar música.png")
            botaoPararIniciarMusica.setBackgroundImage(imagemIniciarMusica, for: .normal)
        } else {
            let imagemPararMusica = #imageLiteral(resourceName: "Parar música.png")
            botaoPararIniciarMusica.setBackgroundImage(imagemPararMusica, for: .normal)
        }
        botaoPararIniciarMusica.addTarget(self, action: #selector(pararIniciarMusica), for: .touchUpInside)
        
        // Caixa de texto, com label
        let imagemCaixaTexto = #imageLiteral(resourceName: "CaixaDeTexto.png")
        let caixaTextoView = UIImageView(image: imagemCaixaTexto)
        caixaTextoView.frame = CGRect(x: 394, y: 221, width: 651, height: 458)
        
        let textViewConversa = UITextView(frame: CGRect(x: 665, y: 237, width: 108, height: 42))
        textViewConversa.backgroundColor = UIColor.transparente()
        textViewConversa.text = "Temas"
        textViewConversa.textAlignment = .center
        
        // Botões mudar tema
        let botaoTema01 = UIButton(frame: CGRect(x: 457, y: 303, width: 139, height: 139))
        botaoTema01.setBackgroundImage(UIImage(named: "Botão tema 01.png"), for: .normal)
        botaoTema01.addTarget(self, action: #selector(mudarTema1), for: .touchUpInside)
        
        let botaoTema02 = UIButton(frame: CGRect(x: 650, y: 303, width: 139, height: 139))
        botaoTema02.setBackgroundImage(UIImage(named: "Botão tema02.png"), for: .normal)
        botaoTema02.addTarget(self, action: #selector(mudarTema2), for: .touchUpInside)
        
        let botaoTema03 = UIButton(frame: CGRect(x: 843, y: 303, width: 139, height: 139))
        botaoTema03.setBackgroundImage(UIImage(named: "Botão tema03.png"), for: .normal)
        botaoTema03.addTarget(self, action: #selector(mudarTema3), for: .touchUpInside)
        
        let botaoTema04 = UIButton(frame: CGRect(x: 457, y: 495, width: 139, height: 139))
        botaoTema04.setBackgroundImage(UIImage(named: "Botão tema04.png"), for: .normal)
        botaoTema04.addTarget(self, action: #selector(mudarTema4), for: .touchUpInside)
        
        let botaoTema05 = UIButton(frame: CGRect(x: 650, y: 495, width: 139, height: 139))
        botaoTema05.setBackgroundImage(UIImage(named: "Botão tema05.png"), for: .normal)
        botaoTema05.addTarget(self, action: #selector(mudarTema5), for: .touchUpInside)
        
        let botaoTema06 = UIButton(frame: CGRect(x: 843, y: 495, width: 139, height: 139))
        botaoTema06.setBackgroundImage(UIImage(named: "Botão tema06.png"), for: .normal)
        botaoTema06.addTarget(self, action: #selector(mudarTema6), for: .touchUpInside)
        
        // Adiciona Subviews
        view.addSubview(backgroundView)
        view.addSubview(caixaTextoView)
        view.addSubview(textViewConversa)
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
    
    // Funções
    @objc func pararIniciarMusica() {
        if chompPlayer?.isPlaying == true {
            chompPlayer?.pause()
            let imagemIniciarMusica = #imageLiteral(resourceName: "Inicar música.png")
            botaoPararIniciarMusica.setBackgroundImage(imagemIniciarMusica, for: .normal)
        } else {
            chompPlayer?.play()
            let imagemPararMusica = #imageLiteral(resourceName: "Parar música.png")
            botaoPararIniciarMusica.setBackgroundImage(imagemPararMusica, for: .normal)
        }
    }
    
    @objc func mudarTema1() {
        print("Clicou no tema 1")
        backgroundView.image = UIImage(named: "tema01.png")
        if temaAtual == 4 || temaAtual == 5 || temaAtual == 6 {
            chompPlayer = player.createPlayer(from: "som tema floresta")
            chompPlayer?.numberOfLoops = 10
            chompPlayer?.play()
        }
        temaAtual = 1
        navigationController?.popViewController(animated: true)
    }
    
    @objc func mudarTema2() {
        print("Clicou no tema 2")
        backgroundView.image = UIImage(named: "tema02.jpg")
        if temaAtual == 4 || temaAtual == 5 || temaAtual == 6 {
            chompPlayer = player.createPlayer(from: "som tema floresta")
            chompPlayer?.numberOfLoops = 10
            chompPlayer?.play()
        }
        temaAtual = 2
        navigationController?.popViewController(animated: true)
    }
    
    @objc func mudarTema3() {
        print("Clicou no tema 3")
        backgroundView.image = UIImage(named: "tema03.jpg")
        if temaAtual == 4 || temaAtual == 5 || temaAtual == 6 {
            chompPlayer = player.createPlayer(from: "som tema floresta")
            chompPlayer?.numberOfLoops = 10
            chompPlayer?.play()
        }
        temaAtual = 3
        navigationController?.popViewController(animated: true)
    }
    
    @objc func mudarTema4() {
        print("Clicou no tema 4")
        backgroundView.image = UIImage(named: "tema04.jpeg")
        if temaAtual == 1 || temaAtual == 2 || temaAtual == 3 {
            chompPlayer = player.createPlayer(from: "som tema agua")
            chompPlayer?.numberOfLoops = 10
            chompPlayer?.play()
        }
        temaAtual = 4
        navigationController?.popViewController(animated: true)
    }
    
    @objc func mudarTema5() {
        print("Clicou no tema 5")
        backgroundView.image = UIImage(named: "tema05.jpg")
        if temaAtual == 1 || temaAtual == 2 || temaAtual == 3 {
            chompPlayer = player.createPlayer(from: "som tema agua")
            chompPlayer?.numberOfLoops = 10
            chompPlayer?.play()
        }
        temaAtual = 5
        navigationController?.popViewController(animated: true)
    }
    
    @objc func mudarTema6() {
        print("Clicou no tema 6")
        backgroundView.image = UIImage(named: "tema06.jpg")
        if temaAtual == 1 || temaAtual == 2 || temaAtual == 3 {
            chompPlayer = player.createPlayer(from: "som tema agua")
            chompPlayer?.numberOfLoops = 10
            chompPlayer?.play()
        }
        temaAtual = 6
        navigationController?.popViewController(animated: true)
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

let segundaViewController = SegundaViewController(screenType: .mac, isPortrait: true)
 /*
let terceiraViewController = TerceiraViewController(screenType: .mac, isPortrait: true)
let quartaViewController = QuartaViewController(screenType: .mac, isPortrait: true)
 */
let temasViewController = TemasViewController(screenType: .mac, isPortrait: true)

let navigation = UINavigationController(screenType: .mac, isPortrait: true)
navigation.navigationBar.isHidden = true
navigation.pushViewController(telaInicial, animated: true)

PlaygroundPage.current.liveView = navigation.scale(to: 0.5)

//: # Navegação

