import Foundation
import AVFoundation

public class Player {
    
    var player = AVAudioPlayer()
    
    public init() {}
    
    public func createPlayer(from filename: String) -> AVAudioPlayer? {
        guard let url = Bundle.main.url(forResource: filename, withExtension: "mp3") else {
            return nil
        }
        
        do {
            try player = AVAudioPlayer(contentsOf: url)
            player.prepareToPlay()
        } catch {
            print("Error loading \(url.absoluteString): \(error)")
        }
        
        return player
    }
}
