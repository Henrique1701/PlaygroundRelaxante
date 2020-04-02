//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

class FirstViewController : UIViewController, UITextFieldDelegate {
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
        let botaoPararIniciarMusica = UIButton()
        botaoPararIniciarMusica.frame = CGRect(x: 1260, y: 57, width: 164, height: 35)
        let imagemBotaoMusica = #imageLiteral(resourceName: "Parar música.png")
        botaoPararIniciarMusica.setBackgroundImage(imagemBotaoMusica, for: .normal)
        
        // Caixa de texto, com label
        let imagemCaixaTexto = #imageLiteral(resourceName: "CaixaDeTexto.png")
        let caixaTextoView = UIImageView(image: imagemCaixaTexto)
        caixaTextoView.frame = CGRect(x: 394, y: 221, width: 651, height: 458)
        
        let textViewConversa = UITextView(frame: CGRect(x: 545, y: 375, width: 350, height: 179))
        textViewConversa.backgroundColor = UIColor.transparente()
        textViewConversa.text = "Qual é o seu nome ?"
        textViewConversa.textAlignment = .center
        
        // Text field seu nome
        let textFieldSeuNome = UITextField()
        textFieldSeuNome.frame = CGRect(x: 394, y: 701, width: 651, height: 106)
        textFieldSeuNome.background = #imageLiteral(resourceName: "ImagemTextField.png")
        textFieldSeuNome.placeholder = "Seu nome"
        //textFieldSeuNome.text = "Seu nome"
        textFieldSeuNome.textAlignment = .center
        //textFieldSeuNome.addTarget(nil, action: #selector(clicouTextField), for: .touchUpInside)
        textFieldSeuNome.delegate = self
        
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.endEditing(true)
        }
        
        // Adiciona Subviews
        view.addSubview(backgroundView)
        view.addSubview(textFieldSeuNome)
        view.addSubview(caixaTextoView)
        view.addSubview(textViewConversa)
        view.addSubview(botaoMudarTema)
        view.addSubview(botaoPararIniciarMusica)
        self.view = view
        
    }
    
    // Funções
    @objc func clicouTextField() {
        print("Clicou no text field")
        show(secondViewControler, sender: nil)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // Do stuff here
        return true
    }
    
}

extension UIColor {
    class func transparente() -> UIColor {
        return UIColor(white: 1.0, alpha: 0)
    }
}

class SecondViewControler: UIViewController {
    
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
        let botaoPararIniciarMusica = UIButton()
        botaoPararIniciarMusica.frame = CGRect(x: 1260, y: 57, width: 164, height: 35)
        let imagemBotaoMusica = #imageLiteral(resourceName: "Parar música.png")
        botaoPararIniciarMusica.setBackgroundImage(imagemBotaoMusica, for: .normal)
        
        // Caixa de texto, com label
        let imagemCaixaTexto = #imageLiteral(resourceName: "CaixaDeTexto.png")
        let caixaTextoView = UIImageView(image: imagemCaixaTexto)
        caixaTextoView.frame = CGRect(x: 394, y: 221, width: 651, height: 458)
        
        let labelConversa = UILabel()
        labelConversa.frame = CGRect(x: 545, y: 375, width: 350, height: 179)
        labelConversa.text = "Então, 'Seu nome', não sei o que está causando a sua ansiedade"
        labelConversa.textColor = .black
        labelConversa.textAlignment = .center
        
        // Adiciona Subviews
        self.view = view
    }
}
// Present the view controller in the Live View window
let firstViewControler = FirstViewController(screenType: .mac, isPortrait: true)
let secondViewControler = SecondViewControler(screenType: .mac, isPortrait: true)
PlaygroundPage.current.liveView = firstViewControler.scale(to: 0.5)

//: # Navegação

