//
//  CountDownScene.swift
//  GameChallenge
//
//  Created by Raina Rodrigues de Lima on 29/03/23.
//

import SpriteKit

class CountScene: SKScene{
    var contando: SKLabelNode!
    
    //    override func didMove(to view: SKView){
    //        contando = SKLabelNode(text: "Seu texto aqui")
    //
    //        contando.position = CGPoint(x: size.width/2, y: size.height/2)
    //
    //        addChild(contando)
    
    
    override func didMove(to view: SKView){
        super.didMove(to: view)
        
        let label = SKLabelNode(text: "")
        label.fontSize = 75
        
        label.position = CGPoint(x: size.width/2, y: size.height/2)
        
        
        self.addChild(label)
        
        var count = 10
        
        label.run(.repeat(.sequence([
            .run{
                count -= 1
                label.text = "\(count)"
            },
            .wait(forDuration: 1)
        ]), count: 10))
        
        
        
        
    }
}


