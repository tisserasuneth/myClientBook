//
//  LoopingPlayer.swift
//  myClientBook
//
//  Created on 10/30/21.
//
//Plays linked video in view. Used by Frontpage() and Home()

import SwiftUI
import AVFoundation

struct LoopingPlayer: UIViewRepresentable {
    func makeUIView (context: Context) -> UIView {
        return QueuePlayerUIView(frame: .zero)    }
    func updateUIView(_ uiView: UIView, context: Context){
        
    }
}

class QueuePlayerUIView: UIView{
    private var playerLayer = AVPlayerLayer()
    private var playerLooper: AVPlayerLooper?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //Load Asset
        let fileUrl = Bundle.main.url(forResource: "production ID_3996898", withExtension: "mp4")!
                                                    //Video removed due to Github file size issues
        let playerItem = AVPlayerItem(url: fileUrl)
        //Setup Player
        let player = AVQueuePlayer(playerItem: playerItem)
        playerLayer.player = player
        playerLayer.videoGravity = .resizeAspectFill
        layer.addSublayer(playerLayer)
        
        // Loop
        playerLooper = AVPlayerLooper(player: player, templateItem: playerItem)
        
        //Play Video
        player.play()
    }
    
    @objc
    
    func rewindVideo(notification: Notification){
        playerLayer.player?.seek(to: .zero)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer.frame = bounds
    }
    required init?(coder: NSCoder){
        fatalError("init(coder: ) has not been implemented")
    }
}

struct LoopingPlayer_Previews: PreviewProvider {
    static var previews: some View {
        ZStack{
            FrontPage()
            LoopingPlayer()
                .ignoresSafeArea()
            
        }
    }
}
