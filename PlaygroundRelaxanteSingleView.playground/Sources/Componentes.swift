import Foundation
import UIKit

public class Componentes {
    public let botaoMudarTema = UIButton()
    public let botaoPararIniciarMusica = UIButton()
    public let caixaTextoView = UIImageView()
    
    public init() {
        // Botão mudar tema
        botaoMudarTema.frame = CGRect(x: 1263, y: 13, width: 164, height: 35)
        let imagemBotaoMudarTema = UIImage(named: "Mudar tema-2.png")
        botaoMudarTema.setBackgroundImage(imagemBotaoMudarTema, for: .normal)
        
        // Botão iniciar/parar música
        botaoPararIniciarMusica.frame = CGRect(x: 1263, y: 56, width: 164, height: 35)
        let imagemBotaoMusica = UIImage(named: "Parar música-2.png")//#imageLiteral(resourceName: "Parar música.png")
        botaoPararIniciarMusica.setBackgroundImage(imagemBotaoMusica, for: .normal)
        
        // Caixa de texto
        let imagemCaixaTexto = UIImage(named: "Caixa de texto-2.png")
        caixaTextoView.image = imagemCaixaTexto
        caixaTextoView.frame = CGRect(x: 394, y: 221, width: 651, height: 458)
    }
    
    public func alterarBackgroundBotaoMusica (estadoBotao: String) {
        let imagemIniciarMusica = UIImage(named: "Iniciar música-2.png")
        let imagemPararMusica = UIImage(named: "Parar música-2.png")
        if estadoBotao == "iniciar" {
            botaoPararIniciarMusica.setBackgroundImage(imagemIniciarMusica, for: .normal)
        } else {
            botaoPararIniciarMusica.setBackgroundImage(imagemPararMusica, for: .normal)
        }
    }
    
    public func verificaImagemBotaoMusica (isPlaying: Bool) {
        if isPlaying == true {
            alterarBackgroundBotaoMusica(estadoBotao: "parar")
        } else {
            alterarBackgroundBotaoMusica(estadoBotao: "iniciar")
        }
    }
}
