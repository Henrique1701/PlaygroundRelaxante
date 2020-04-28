//: # Playground Relaxante
import UIKit
import PlaygroundSupport
import AVFoundation
import WebKit

//: ## Tema
// Background tema
var backgroundImagem = UIImage(named: "tema01.png")

// Música tema
public var chompPlayer: AVAudioPlayer?
let player = Player()
chompPlayer = player.createPlayer(from: "som tema floresta")
chompPlayer?.numberOfLoops = 10
//chompPlayer?.play()

// Controle música tema
var temaAtual = 1
//: ## Fontes
let cfURL = Bundle.main.url(forResource: "DancingScript", withExtension: "ttf")! as CFURL
CTFontManagerRegisterFontsForURL(cfURL, CTFontManagerScope.process, nil)
let dancingScript = UIFont(name: "Dancing Script", size: 45)
let dancingScript60 = UIFont(name: "Dancing Script", size: 60)
let dancingScript30 = UIFont(name: "Dancing Script", size: 30)
//: ## Entrada text fild
//let textFieldSeuNome = UITextField()
var nomeUsuario = ""

//: ## Variáveis de controle
var controleVideo = 0
// Controlar reprodução da música de fundo
var estadoMusica = chompPlayer?.isPlaying

//: ### PrimeiraViewController
class PrimeiraViewController : UIViewController, UIGestureRecognizerDelegate {
    
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
        textoBoasVindas.font = dancingScript
        textoBoasVindas.textAlignment = .center
        textoBoasVindas.lineBreakMode = .byWordWrapping
        textoBoasVindas.numberOfLines = 2
        textoBoasVindas.text = "Seja bem-vindo(a) ao\nPlayground Relaxante"
        
        let textoContinuar = UILabel(frame: CGRect(x: 756, y: 618, width: 268, height: 42))
        textoContinuar.font = dancingScript30
        textoContinuar.textColor = .darkGray
        textoContinuar.textAlignment = .right
        textoContinuar.text = "Clique para continuar"
        
        let textoMotivacao1 = UILabel(frame: CGRect(x: 476, y: 356, width: 488, height: 189))
        textoMotivacao1.font = dancingScript
        textoMotivacao1.textAlignment = .center
        
        // Adiciona Subviews
        view.addSubview(backgroundView)
        view.addSubview(botaoMudarTema)
        view.addSubview(botaoPararIniciarMusica)
        view.addSubview(caixaTextoView)
        view.addSubview(textoBoasVindas)
        view.addSubview(textoContinuar)
        
        self.view = view
    }
    
    override func viewWillAppear(_ animated: Bool) {
        backgroundView.image = backgroundImagem
        
        // Verifica imagem do botão iniciar/parar música
        self.componentes.verificaImagemBotaoMusica(isPlaying: chompPlayer?.isPlaying ?? true)
    }
    
    // Funções
    @objc func clicouCaixaTexto() {
        print("Clicou na caixa de texto")
        navigationController?.pushViewController(SegundaViewController(), animated: true)
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

//: ### SegundaViewController
class SegundaViewController : UIViewController, UITextFieldDelegate, UIGestureRecognizerDelegate {
    
    let botaoMudarTema = UIButton()
    let botaoPararIniciarMusica = UIButton()
    let caixaTextoView = UIImageView()
    let textFieldSeuNome = UITextField()
    let backgroundView = UIImageView(frame: CGRect(x: 0, y: 0, width: 1440, height: 900))
    
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .red
        
        self.view = view
    }
    
    override func viewDidLoad() {
        // Imagem de fundo (tema)
        backgroundView.image = backgroundImagem
        
        // Botão mudar tema
        botaoMudarTema.frame = CGRect(x: 1263, y: 13, width: 164, height: 35)
        let imagemBotaoMudarTema = UIImage(named: "Mudar tema-2.png")
        botaoMudarTema.setBackgroundImage(imagemBotaoMudarTema, for: .normal)
        botaoMudarTema.addTarget(self, action: #selector(mudarTema), for: .touchUpInside)
        
        // Botão parar música
        botaoPararIniciarMusica.frame = CGRect(x: 1263, y: 56, width: 164, height: 35)
        let imagemBotaoMusica = UIImage(named: "Parar música-2.png")
        botaoPararIniciarMusica.setBackgroundImage(imagemBotaoMusica, for: .normal)
        if chompPlayer?.isPlaying == true {
            botaoPararIniciarMusica.setBackgroundImage(UIImage(named: "Parar música-2.png"), for: .normal)
        } else {
            botaoPararIniciarMusica.setBackgroundImage(UIImage(named: "Iniciar música-2.png"), for: .normal)
        }
        botaoPararIniciarMusica.addTarget(self, action: #selector(pararIniciarMusica), for: .touchUpInside)
        
        // Caixa de texto, com label
        let imagemCaixaTexto = UIImage(named: "Caixa de texto-2.png")
        caixaTextoView.image = imagemCaixaTexto
        caixaTextoView.frame = CGRect(x: 394, y: 221, width: 651, height: 458)
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
        view.addSubview(backgroundView)
        view.addSubview(textFieldSeuNome)
        view.addSubview(caixaTextoView)
        view.addSubview(textoConversa)
        view.addSubview(botaoMudarTema)
        view.addSubview(botaoPararIniciarMusica)
        //view.addSubview(animalView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // Gambiarra para resolver bug do Xcode (perte a referencia do backgroundView)
        
        backgroundView.image = backgroundImagem
        view.addSubview(self.backgroundView)
        view.sendSubviewToBack(self.backgroundView)
        
        // Verifica botão iniciar/parar música
        //self.componentes.verificaImagemBotaoMusica(isPlaying: chompPlayer?.isPlaying ?? true)
    }
    // Funções
    @objc func clicouCaixaTexto() {
        print("Clicou na caixa de texto")
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        nomeUsuario = textFieldSeuNome.text!
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textFieldSeuNome.resignFirstResponder()
        nomeUsuario = textFieldSeuNome.text!
        print(nomeUsuario)
        navigationController?.pushViewController(TerceiraViewController(), animated: true)
        return true;
    }
    
    @objc func pararIniciarMusica() {
        if chompPlayer?.isPlaying == true {
            chompPlayer?.pause()
            botaoPararIniciarMusica.setBackgroundImage(UIImage(named: "Iniciar música-2.png"), for: .normal)
        } else {
            chompPlayer?.play()
            botaoPararIniciarMusica.setBackgroundImage(UIImage(named: "Parar música-2.png"), for: .normal)
        }
        
    }
    
    @objc func mudarTema() {
        navigationController?.pushViewController(temasViewController, animated: true)
    }
}

//: ### TerceiraViewController
class TerceiraViewController: UIViewController, UIGestureRecognizerDelegate {
    
    let botaoMudarTema = UIButton()
    let botaoPararIniciarMusica = UIButton()
    let caixaTextoView = UIImageView()
    let textoConversa = UILabel(frame: CGRect(x: 476, y: 356, width: 488, height: 189))
    let backgroundView = UIImageView(frame: CGRect(x: 0, y: 0, width: 1440, height: 900))
    
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .red
        
        self.view = view
        
    }
    
    override func viewDidLoad() {
        // Imagem de fundo (tema)
        backgroundView.image = backgroundImagem
        
        // Botão mudar tema
        botaoMudarTema.frame = CGRect(x: 1263, y: 13, width: 164, height: 35)
        let imagemBotaoMudarTema = UIImage(named: "Mudar tema-2.png")
        botaoMudarTema.setBackgroundImage(imagemBotaoMudarTema, for: .normal)
        botaoMudarTema.addTarget(self, action: #selector(mudarTema), for: .touchUpInside)
        
        // Botão parar música
        botaoPararIniciarMusica.frame = CGRect(x: 1263, y: 56, width: 164, height: 35)
        let imagemBotaoMusica = UIImage(named: "Parar música-2.png")
        botaoPararIniciarMusica.setBackgroundImage(imagemBotaoMusica, for: .normal)
        if chompPlayer?.isPlaying == true {
            botaoPararIniciarMusica.setBackgroundImage(UIImage(named: "Parar música-2.png"), for: .normal)
        } else {
            botaoPararIniciarMusica.setBackgroundImage(UIImage(named: "Iniciar música-2.png"), for: .normal)
        }
        botaoPararIniciarMusica.addTarget(self, action: #selector(pararIniciarMusica), for: .touchUpInside)
        
        // Caixa de texto, com label
        let imagemCaixaTexto = UIImage(named: "Caixa de texto-2.png")
        caixaTextoView.image = imagemCaixaTexto
        caixaTextoView.frame = CGRect(x: 394, y: 221, width: 651, height: 458)
        caixaTextoView.isUserInteractionEnabled = true
        let tocouCaixaTexto = UITapGestureRecognizer(target: self, action: #selector(clicouCaixaTexto))
        caixaTextoView.addGestureRecognizer(tocouCaixaTexto)
        
        // Texto
        textoConversa.font = dancingScript
        textoConversa.textAlignment = .left
        textoConversa.lineBreakMode = .byWordWrapping
        textoConversa.numberOfLines = 0
        
        // Adiciona Subviews
        view.addSubview(backgroundView)
        view.addSubview(caixaTextoView)
        view.addSubview(botaoMudarTema)
        view.addSubview(botaoPararIniciarMusica)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // Gambiarra para resolver bug do Xcode (perte a referencia do backgroundView)
        backgroundView.image = backgroundImagem
        view.addSubview(self.backgroundView)
        view.sendSubviewToBack(self.backgroundView)
        
        textoConversa.text = "Olá, \(nomeUsuario), não sei qual é o motivo da sua ansiedade. Mas vamos controlá-la juntos !"
        view.addSubview(textoConversa)
        
        // Verifica botão iniciar/parar música
        //self.componentes.verificaImagemBotaoMusica(isPlaying: chompPlayer?.isPlaying ?? true)
    }
    // Funções
    @objc func clicouCaixaTexto() {
        print("Clicou na caixa de texto")
        navigationController?.pushViewController(QuartaViewController(), animated: true)
    }
    
    @objc func pararIniciarMusica() {
        if chompPlayer?.isPlaying == true {
            chompPlayer?.pause()
            botaoPararIniciarMusica.setBackgroundImage(UIImage(named: "Iniciar música-2.png"), for: .normal)
        } else {
            chompPlayer?.play()
            botaoPararIniciarMusica.setBackgroundImage(UIImage(named: "Parar música-2.png"), for: .normal)
        }
        
    }
    
    @objc func mudarTema() {
        navigationController?.pushViewController(temasViewController, animated: true)
    }
}

//: ### QuartaViewController
class QuartaViewController: UIViewController, UIGestureRecognizerDelegate {
    
    let botaoMudarTema = UIButton()
    let botaoPararIniciarMusica = UIButton()
    let caixaTextoView = UIImageView()
    let texto = UILabel(frame: CGRect(x: 545, y: 308, width: 350, height: 108))
    let backgroundView = UIImageView(frame: CGRect(x: 0, y: 0, width: 1440, height: 900))
    let botaoControleRespiracao = UIButton(frame: CGRect(x: 564, y: 450, width: 325, height: 39))
    let botaoMindfulness = UIButton(frame: CGRect(x: 570, y: 515, width: 325, height: 40))
    let botaoMeditar = UIButton(frame: CGRect(x: 570, y: 581, width: 325, height: 39))
    
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .red
        
        self.view = view
        
    }
    
    override func viewDidLoad() {
        // Imagem de fundo (tema)
        backgroundView.image = backgroundImagem
        
        // Botão mudar tema
        botaoMudarTema.frame = CGRect(x: 1263, y: 13, width: 164, height: 35)
        let imagemBotaoMudarTema = UIImage(named: "Mudar tema-2.png")
        botaoMudarTema.setBackgroundImage(imagemBotaoMudarTema, for: .normal)
        botaoMudarTema.addTarget(self, action: #selector(mudarTema), for: .touchUpInside)
        
        // Botão parar música
        botaoPararIniciarMusica.frame = CGRect(x: 1263, y: 56, width: 164, height: 35)
        let imagemBotaoMusica = UIImage(named: "Parar música-2.png")
        botaoPararIniciarMusica.setBackgroundImage(imagemBotaoMusica, for: .normal)
        if chompPlayer?.isPlaying == true {
            botaoPararIniciarMusica.setBackgroundImage(UIImage(named: "Parar música-2.png"), for: .normal)
        } else {
            botaoPararIniciarMusica.setBackgroundImage(UIImage(named: "Iniciar música-2.png"), for: .normal)
        }
        botaoPararIniciarMusica.addTarget(self, action: #selector(pararIniciarMusica), for: .touchUpInside)
        
        // Caixa de texto, com label
        let imagemCaixaTexto = UIImage(named: "Caixa de texto-2.png")
        caixaTextoView.image = imagemCaixaTexto
        caixaTextoView.frame = CGRect(x: 394, y: 221, width: 651, height: 458)
        
        // Texto
        texto.font = dancingScript
        texto.textAlignment = .center
        texto.lineBreakMode = .byWordWrapping
        texto.numberOfLines = 0
        texto.text = "O que você gostaria de fazer ?"
        
        // Botão controlar a respiração
        botaoControleRespiracao.setBackgroundImage(UIImage(named: "Botao controlar a respiracao-2.png"), for: .normal)
        botaoControleRespiracao.tag = 1
        botaoControleRespiracao.addTarget(self, action: #selector(QuartaViewController.escolherAtividade(sender:)), for: .touchUpInside)
        
        // Botão meditar
        botaoMeditar.setBackgroundImage(UIImage(named: "Botao meditar-2.png"), for: .normal)
        botaoMeditar.tag = 2
        botaoMeditar.addTarget(self, action: #selector(QuartaViewController.escolherAtividade(sender:)), for: .touchUpInside)
        
        // Botão mindfulness
        botaoMindfulness.setBackgroundImage(UIImage(named: "Botao mindfulness-2.png"), for: .normal)
        botaoMindfulness.tag = 3
        botaoMindfulness.addTarget(self, action: #selector(QuartaViewController.escolherAtividade(sender:)), for: .touchUpInside)
        
        // Adiciona Subviews
        view.addSubview(backgroundView)
        view.addSubview(caixaTextoView)
        view.addSubview(texto)
        view.addSubview(botaoMudarTema)
        view.addSubview(botaoPararIniciarMusica)
        view.addSubview(botaoControleRespiracao)
        view.addSubview(botaoMeditar)
        view.addSubview(botaoMindfulness)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // Gambiarra para resolver bug do Xcode (perte a referencia do backgroundView)
        backgroundView.image = backgroundImagem
        view.addSubview(self.backgroundView)
        view.sendSubviewToBack(self.backgroundView)
        
        // Verifica botão iniciar/parar música
        //self.componentes.verificaImagemBotaoMusica(isPlaying: chompPlayer?.isPlaying ?? true)
    }
    
    // Funções
    @objc func pararIniciarMusica() {
        if chompPlayer?.isPlaying == true {
            chompPlayer?.pause()
            botaoPararIniciarMusica.setBackgroundImage(UIImage(named: "Iniciar música-2.png"), for: .normal)
        } else {
            chompPlayer?.play()
            botaoPararIniciarMusica.setBackgroundImage(UIImage(named: "Parar música-2.png"), for: .normal)
        }
        
    }
    
    @objc func mudarTema() {
        navigationController?.pushViewController(temasViewController, animated: true)
    }
    
    @objc func escolherAtividade(sender: UIButton) {
        let sender = sender.tag
        estadoMusica = chompPlayer?.isPlaying
        
        if sender == 1 {
            print("Escolheu controlar a respiração")
            controleVideo = 1
        } else if sender == 2 {
            print("Escolheu meditar")
            controleVideo = 2
        } else {
            print("Escolheu mindfulness")
            controleVideo = 3
        }
        navigationController?.pushViewController(QuintaViewController(), animated: true)
    }
}

//: ### QuintaViewController
class QuintaViewController: UIViewController, UIGestureRecognizerDelegate, WKUIDelegate {
    
    let backgroundView = UIImageView(frame: CGRect(x: 0, y: 0, width: 1440, height: 900))
    let botaoVoltar = UIButton(frame: CGRect(x: 13, y: 13, width: 164, height: 36))
    let urlVideo1 = URL(string: "https://www.youtube.com/embed/cizpXqVzBjw")!
    let urlVideo2 = URL(string: "https://www.youtube.com/embed/hn3J-d44r94")!
    let urlVideo3 = URL(string: "https://www.youtube.com/embed/xpYMV0Uqc-M")!
    let webView = WKWebView(frame: CGRect(x: 227, y: 174, width: 982, height: 552), configuration: WKWebViewConfiguration())
    
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .red
        
        self.view = view
    }
    
    override func viewDidLoad() {
        // Imagem de fundo (tema)
        backgroundView.image = backgroundImagem
        
        // Botão voltar
        botaoVoltar.setBackgroundImage(UIImage(named: "Voltar-2"), for: .normal)
        botaoVoltar.addTarget(self, action: #selector(QuintaViewController.tocouBotaoVoltar), for: .touchUpInside)
        
        // Adiciona Subviews
        view.addSubview(backgroundView)
        view.addSubview(botaoVoltar)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // Gambiarra para resolver bug do Xcode (perte a referencia do backgroundView)
        backgroundView.image = backgroundImagem
        view.addSubview(self.backgroundView)
        view.sendSubviewToBack(self.backgroundView)
        
        chompPlayer?.pause()
        
        // Videos
        var request = URLRequest(url: urlVideo1)
        if controleVideo == 2 {
            request = URLRequest(url: urlVideo2)
        } else if controleVideo == 3 {
            request = URLRequest(url: urlVideo3)
        }
        
        webView.load(request)
        
        view.addSubview(webView)
    }
    
    // Funções
    @objc func tocouBotaoVoltar() {
        print("Clicou no botão para voltar")
        //webView.endEditing(true)
        if estadoMusica == true {
            chompPlayer?.play()
        }
        navigationController?.popViewController(animated: true)
    }
}


//: ### TemasViewController
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
    
    override func viewWillAppear(_ animated: Bool) {
        //componentes.verificaImagemBotaoMusica(isPlaying: chompPlayer?.isPlaying ?? true)
    }
    
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
                let estadoAnteriorChompPlayer = chompPlayer?.isPlaying
                chompPlayer = player.createPlayer(from: "som tema floresta")
                chompPlayer?.numberOfLoops = 10
                if estadoAnteriorChompPlayer == true {
                    chompPlayer?.play()
                }
            }
        } else {
            if temaAnterior == 1 || temaAnterior == 2 || temaAnterior == 3 {
                let estadoAnteriorChompPlayer = chompPlayer?.isPlaying
                chompPlayer = player.createPlayer(from: "som tema agua")
                chompPlayer?.numberOfLoops = 10
                if estadoAnteriorChompPlayer == true {
                    chompPlayer?.play()
                }
            }
        }
        
        navigationController?.popViewController(animated: true)
    }
}


extension UIColor {
    class func transparente() -> UIColor {
        return UIColor(white: 1.0, alpha: 0)
    }
}

//: ## Navegação
// Present the view controller in the Live View window
let primeiraViewController = PrimeiraViewController(screenType: .mac, isPortrait: true)
let segundaViewController = SegundaViewController(screenType: .mac, isPortrait: true)
let terceiraViewController = TerceiraViewController(screenType: .mac, isPortrait: true)
let quartaViewController = QuartaViewController(screenType: .mac, isPortrait: true)
let quintaViewController = QuintaViewController(screenType: .mac, isPortrait: true)
let temasViewController = TemasViewController(screenType: .mac, isPortrait: true)

let navigation = UINavigationController(screenType: .mac, isPortrait: true)
navigation.navigationBar.isHidden = true
navigation.pushViewController(primeiraViewController, animated: true)

PlaygroundPage.current.liveView = navigation.scale(to: 0.5)
