//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport
import AVFoundation

private var chompPlayer: AVAudioPlayer?
chompPlayer = createPlayer(from: "som tema floresta")
chompPlayer?.play()
func createPlayer(from filename: String) -> AVAudioPlayer? {
    guard let url = Bundle.main.url(forResource: filename, withExtension: "mp3") else {
        return nil
    }
    var player = AVAudioPlayer()
    do {
        try player = AVAudioPlayer(contentsOf: url)
        player.prepareToPlay()
    } catch {
        print("Error loading \(url.absoluteString): \(error)")
    }
    
    return player
}

var nomeUsuario = ""

class PrimeiraViewController : UIViewController, UITextFieldDelegate, UIGestureRecognizerDelegate {
    
    
    
    let botaoPararIniciarMusica = UIButton()
    
    let textFieldSeuNome = UITextField()
    
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .systemTeal

        let label = UILabel()
        label.frame = CGRect(x: 320, y: 320, width: 200, height: 20)
        label.text = "Hello World!"
        label.textColor = .white
        
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
        let imagemBotaoMusica = #imageLiteral(resourceName: "Parar música.png")
        botaoPararIniciarMusica.setBackgroundImage(imagemBotaoMusica, for: .normal)
        botaoPararIniciarMusica.addTarget(self, action: #selector(pararIniciarMusica), for: .touchUpInside)
        
        // Caixa de texto, com label
        let imagemCaixaTexto = #imageLiteral(resourceName: "CaixaDeTexto.png")
        let caixaTextoView = UIImageView(image: imagemCaixaTexto)
        caixaTextoView.frame = CGRect(x: 394, y: 221, width: 651, height: 458)
        
        let textViewConversa = UITextView(frame: CGRect(x: 545, y: 375, width: 350, height: 179))
        textViewConversa.backgroundColor = UIColor.transparente()
        textViewConversa.text = "Qual é o seu nome ?"
        textViewConversa.textAlignment = .center
        
        caixaTextoView.isUserInteractionEnabled = true
        let tocouCaixaTexto = UITapGestureRecognizer(target: self, action: #selector(clicouCaixaTexto))
        caixaTextoView.addGestureRecognizer(tocouCaixaTexto)
        
        
        // Text field seu nome
        textFieldSeuNome.frame = CGRect(x: 394, y: 701, width: 651, height: 106)
        textFieldSeuNome.background = #imageLiteral(resourceName: "ImagemTextField.png")
        textFieldSeuNome.placeholder = "Seu nome"
        textFieldSeuNome.textAlignment = .center
        //textFieldSeuNome.addTarget(nil, action: #selector(clicouTextField), for: .touchUpInside)
        textFieldSeuNome.delegate = self
        textFieldSeuNome.addTarget(self, action: #selector(recebeNome), for: .editingChanged)
        
        // Botão caixa de texto
//        let botaoCaixaTexto = UIButton(frame: CGRect(x: 394, y: 221, width: 651, height: 458))
//        botaoCaixaTexto.backgroundColor = UIColor.transparente()
//        botaoCaixaTexto.addTarget(nil, action: #selector(clicouCaixaTexto), for: .touchUpInside)
        
        // Testando movimento de itens
        let animal = UIImage(named: "animal.jpeg")
        let animalView = UIImageView(image: animal)
        animalView.frame = CGRect(x: 50, y: 50, width: 200, height: 200)
        
        animalView.isUserInteractionEnabled = true
        let panAnimal = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        animalView.addGestureRecognizer(panAnimal)
        
        
        // Adiciona Subviews
        view.addSubview(backgroundView)
        view.addSubview(textFieldSeuNome)
        view.addSubview(caixaTextoView)
        view.addSubview(textViewConversa)
        view.addSubview(botaoMudarTema)
        view.addSubview(botaoPararIniciarMusica)
        //view.addSubview(botaoCaixaTexto)
        view.addSubview(animalView)
        self.view = view
        
    }
    
    // Funções
    @objc func clicouCaixaTexto() {
        print("Clicou na caixa de texto")
        //show(secondViewController, sender: nil)
        //present(secondViewController, animated: true, completion: nil)
        navigationController?.pushViewController(segundaViewController, animated: true)
    }
    
    @objc func recebeNome() {
        nomeUsuario = textFieldSeuNome.text!
    }
    
    @objc func handlePan(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        guard let gestureView = gesture.view else {
            return
        }
        gestureView.center = CGPoint(
            x: gestureView.center.x + translation.x,
            y: gestureView.center.y + translation.y
        )
        gesture.setTranslation(.zero, in: view)
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

class SegundaViewController: UIViewController {
    
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
        let imagemBotaoMusica = #imageLiteral(resourceName: "Parar música.png")
        botaoPararIniciarMusica.setBackgroundImage(imagemBotaoMusica, for: .normal)
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
        let imagemBotaoMusica = #imageLiteral(resourceName: "Parar música.png")
        botaoPararIniciarMusica.setBackgroundImage(imagemBotaoMusica, for: .normal)
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
        let imagemBotaoMusica = #imageLiteral(resourceName: "Parar música.png")
        botaoPararIniciarMusica.setBackgroundImage(imagemBotaoMusica, for: .normal)
        
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

extension UIColor {
    class func transparente() -> UIColor {
        return UIColor(white: 1.0, alpha: 0)
    }
}

// Present the view controller in the Live View window
let primeiraViewController = PrimeiraViewController(screenType: .mac, isPortrait: true)
let segundaViewController = SegundaViewController(screenType: .mac, isPortrait: true)
let terceiraViewController = TerceiraViewController(screenType: .mac, isPortrait: true)
let quartaViewController = QuartaViewController(screenType: .mac, isPortrait: true)

let navigation = UINavigationController(screenType: .mac, isPortrait: true)
navigation.navigationBar.isHidden = true
navigation.pushViewController(primeiraViewController, animated: true)

PlaygroundPage.current.liveView = navigation.scale(to: 0.5)

//: # Navegação

