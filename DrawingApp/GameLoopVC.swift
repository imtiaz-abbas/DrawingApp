//
//  GameLoopVC.swift
//  DrawingApp
//
//  Created by imtiaz abbas on 14/05/19.
//  Copyright © 2019 Imtiaz. All rights reserved.
//

import Foundation

import UIKit
import Stevia
import AVFoundation
import RxSwift

class Message {
    public let timestamp: Date?
    public let color: Int?
    public var discarded: Bool?
    init(timestamp: Date?, color: Int?) {
        self.timestamp = timestamp
        self.color = color
        self.discarded = false
    }
    func discard() {
        self.discarded = true
    }
}

class GameLoopVC : UIViewController {
    let screenSize = UIScreen.main.bounds
    let upcomingQueueView = UIView()
    let completedQueueView = UIView()
    var upcomingMessages: Array<Message> = []
    var completedMessages: Array<Message> = []
    
    override func viewDidLoad() {
        runGameLoop()
        view.backgroundColor = .white
        view.sv(upcomingQueueView, completedQueueView)
        upcomingQueueView.width(screenSize.width / 2)
        completedQueueView.width(screenSize.width / 2)
        upcomingQueueView.height(screenSize.height)
        completedQueueView.height(screenSize.height)
        upcomingQueueView.Left == 0
        completedQueueView.Left == upcomingQueueView.Right
        upcomingQueueView.backgroundColor = UIColor(red: 1, green: 0, blue: 0, alpha: 0.2)
        completedQueueView.backgroundColor = UIColor(red: 0, green: 1, blue: 0, alpha: 0.2)
    }
    
    func refreshUpcomingQueueView() {
        for subView in upcomingQueueView.subviews {
            subView.removeFromSuperview()
        }
        for (index, message) in upcomingMessages.enumerated() {
            let dateTimeLabel = UILabel()
            let messageView = UIView()
            self.upcomingQueueView.sv(messageView)
            messageView.width((screenSize.width / 2) - 40)
            messageView.height(50)
            messageView.Top == CGFloat(index + 1) * CGFloat(100)
            messageView.Left == 20
            messageView.Right == 20
            messageView.backgroundColor = Pencil(tag: message.color ?? 2)?.color
            messageView.sv(dateTimeLabel)
            dateTimeLabel.centerHorizontally()
            dateTimeLabel.centerVertically()
            let calendar = Calendar.current
            let components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second, .nanosecond], from: message.timestamp!)
            dateTimeLabel.text = "\(String(format: "%02d", components.hour ?? 0)):\(String(format: "%02d", components.minute ?? 0)):\(String(format: "%02d", components.second ?? 0))"
        }
    }
    func refreshCompletedQueueView() {
        for subView in completedQueueView.subviews {
            subView.removeFromSuperview()
        }
        for (index, message) in completedMessages.enumerated() {
            let dateTimeLabel = UILabel()
            let messageView = UIView()
            self.completedQueueView.sv(messageView)
            messageView.width((screenSize.width / 2) - 40)
            messageView.height(50)
            messageView.Top == CGFloat(index + 1) * CGFloat(100)
            messageView.Left == 20
            messageView.Right == 20
            messageView.backgroundColor = Pencil(tag: message.color ?? 2)?.color
            messageView.sv(dateTimeLabel)
            dateTimeLabel.centerHorizontally()
            dateTimeLabel.centerVertically()
            if (message.discarded ?? false) {
                let discardedView = UIView()
                messageView.sv(discardedView)
                discardedView.backgroundColor = .red
                discardedView.layer.borderColor = UIColor.black.cgColor
                discardedView.layer.borderWidth = 1
                discardedView.height(20)
                discardedView.width(20)
                discardedView.Right == 20
                discardedView.Top == 20
            }
            
            
            let calendar = Calendar.current
            let components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second, .nanosecond], from: message.timestamp!)
            dateTimeLabel.text = "\(String(format: "%02d", components.hour ?? 0)):\(String(format: "%02d", components.minute ?? 0)):\(String(format: "%02d", components.second ?? 0))"
        }
    }
    
    
    func emitMessages() {
        Observable<Int>.timer(0, period: 4, scheduler: MainScheduler.instance)
            .subscribe(onNext: {value in
                let calendar = Calendar.current
                let randomNumber = Int.random(in: 2 ..< 10)
                let time = calendar.date(byAdding: .second, value: randomNumber, to: Date())
                // adding new message to upcoming messages
                self.upcomingMessages.append(Message(timestamp: time, color: randomNumber))
                self.refreshUpcomingQueueView()
                
            }, onError: nil, onCompleted: nil, onDisposed: nil)

    }
    
    func observeMessages() {
        Observable<Int>.timer(0, period: 0.1, scheduler: MainScheduler.instance)
            .subscribe(onNext: {value in
                // filtering completed messages and discarded messages from upcoming messages
                self.upcomingMessages = self.upcomingMessages
                    .enumerated()
                    .filter {
                        let messageDateTime = $1.timestamp
                        let difference = Calendar.current.dateComponents([.second, .nanosecond], from: Date(), to: messageDateTime!)
                        let nanoSeconds = difference.nanosecond!
                        let milliSeconds = nanoSeconds / 1_000_000
                        let seconds = difference.second!
                        if (seconds <= 0 && milliSeconds <= 0) {
                            if (seconds == 0 && milliSeconds >= -100) {
                                self.completedMessages.insert($1, at: 0)
                            } else {
                                // discarding the message if the delay is more than 100ms
                                $1.discard()
                                self.completedMessages.insert($1, at: 0)
                            }
                            return false
                        }
                        return true
                    }
                    .map { $0.element }
                // updating upcoming and completed views after updating upcoming and completed messages
                self.refreshUpcomingQueueView()
                self.refreshCompletedQueueView()
            }, onError: nil, onCompleted: nil, onDisposed: nil)
    }
    
    func runGameLoop() {
        emitMessages()
        observeMessages()
    }
}
