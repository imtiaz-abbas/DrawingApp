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

struct Message {
  public let timestamp: Date!
  public var color: UIColor = UIColor.black
  public var discarded: Bool = false
  public var completed: Bool = false

  func id() -> String {
    let components = Calendar.current.dateComponents([.minute, .second, .nanosecond], from: timestamp)
    return "\(components.minute!) \(components.second!) \(components.nanosecond!)"
  }
}

class GameLoopVC : UIViewController {

  	let disposeBag = DisposeBag()

    let screenSize = UIScreen.main.bounds
  	let upcomingCollectionView: MessageCollectionView = MessageCollectionView()
    let completedCollectionView: MessageCollectionView = MessageCollectionView()

    let completedQueueView = UIView()
    let scrollView = UIScrollView()
  	var currentTimeView = UILabel()
    var completedMessages: Array<Message> = []

  	let dateFormatter: DateFormatter = {
    	  let d = DateFormatter()
				d.dateFormat = "HH:mm:ss"
      	return d
  	}()
    
    override func viewDidLoad() {
        runGameLoop()
        view.backgroundColor = .white
        view.sv(upcomingCollectionView, completedCollectionView, currentTimeView)

      	currentTimeView.centerHorizontally()
				currentTimeView.Top == view.Top + 40
				updateCurrentTime()

        upcomingCollectionView.width(screenSize.width / 2)
        
        upcomingCollectionView.height(screenSize.height)
        
        completedCollectionView.width(screenSize.width / 2)
        
        completedCollectionView.height(screenSize.height)
        
        upcomingCollectionView.Left == 0
        
        completedCollectionView.Left == upcomingCollectionView.Right

    }

  	override func viewWillAppear(_ animated: Bool) {
    	super.viewWillAppear(animated)
    	upcomingCollectionView.setupView()
        completedCollectionView.setupView()
  	}

  	private func updateCurrentTime() {
    	Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
      	self.currentTimeView.text = self.dateFormatter.string(from: Date())
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
            messageView.backgroundColor = message.color
            messageView.sv(dateTimeLabel)
            dateTimeLabel.centerHorizontally()
            dateTimeLabel.centerVertically()
            if (message.discarded) {
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

          	dateTimeLabel.text = self.dateFormatter.string(from: message.timestamp)
        }
    }

    func addMessagToQueue(message: Message) {
      self.upcomingCollectionView.addMessage(message: message)
    }

    func emitMessages() {
      	Observable<Int>.interval(RxTimeInterval.seconds(4), scheduler: ConcurrentMainScheduler.instance)
      			.observeOn(MainScheduler.asyncInstance)
        		.subscribe(onNext: {value in
                let calendar = Calendar.current
                let randomNumber = Int.random(in: 2 ..< 10)
                let time = calendar.date(byAdding: .second, value: randomNumber, to: Date())
                // adding new message to upcoming messages
              	let message = Message(timestamp: time, color: Pencil(tag: randomNumber)?.color ?? UIColor.black, discarded: false, completed: false)
              	self.addMessagToQueue(message: message)
            }, onError: nil, onCompleted: nil, onDisposed: nil)
      			.disposed(by: disposeBag)
    }
    
    func observeMessages() {
        Observable<Int>.interval(RxTimeInterval.milliseconds(100), scheduler: ConcurrentMainScheduler.instance)
            .subscribe(onNext: {value in
                // filtering completed messages and discarded messages from upcoming messages
              	if let messagePop = self.upcomingCollectionView.messages.first {
                  let messageDateTime = messagePop.timestamp
                  let difference = Calendar.current.dateComponents([.second, .nanosecond], from: Date(), to: messageDateTime!)
                  let seconds = difference.second ?? 0
                  let nanoseconds = difference.nanosecond ?? 0
                  let milliSeconds = (seconds * 1000) + (nanoseconds / 1_000_000)

                  if (milliSeconds <= 100 && milliSeconds >= -100) {
                    //valid message emit
                    let message = Message(timestamp: messagePop.timestamp, color: messagePop.color, discarded: false, completed: true)
//                    self.completedMessages.insert(message, at: 0)
                    self.completedCollectionView.addMessage(message: message)
                    self.upcomingCollectionView.removeMessage(message: message)
//                    self.updateMessage(message: message)
                  } else if (milliSeconds <= -100){
                  	//discarding the message if the delay is more than 100ms
                    let message = Message(timestamp: messagePop.timestamp, color: messagePop.color, discarded: true, completed: true)
//                    self.completedMessages.insert(message, at: 0)
                    self.completedCollectionView.addMessage(message: message)
                    self.upcomingCollectionView.removeMessage(message: message)
//                    self.updateMessage(message: message)
                  }
              	}
                
                self.refreshCompletedQueueView()
            }, onError: nil, onCompleted: nil, onDisposed: nil)
      			.disposed(by: disposeBag)
    }
    
    func runGameLoop() {
        emitMessages()
        observeMessages()
    }
}
