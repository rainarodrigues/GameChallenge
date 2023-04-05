
//  Created by Raina Rodrigues de Lima on 24/03/23.
//

import SwiftUI
import SpriteKit

struct GameView : UIViewRepresentable{
    
    func makeUIView(context: Context) -> SKView {
        let view = SKView()
        
        view.frame = UIScreen.main.bounds
        
        let scene = CountScene(size: view.bounds.size)
        scene.scaleMode = .aspectFill
        
        view.presentScene(scene)
        
        return view
    }
    
    func updateUIView(_ uiView: SKView, context: Context) {
    
    }
}

struct CountDownView: View{
    var body: some View{
        VStack{
            GameView().frame(
                width: 300,
                height: 300
            )
            
            Text("Olá")
        }
        
    }
}

struct CountDownView_Previews: PreviewProvider {
    static var previews: some View {
        CountDownView()
    }
}

