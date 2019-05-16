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
}

class GameLoopVC : UIViewController {

  	let disposeBag = DisposeBag()

    let screenSize = UIScreen.main.bounds
    let upcomingQueueView = UIView()
    let completedQueueView = UIView()
    let scrollView = UIScrollView()
  	var currentTimeView = UILabel()
    var upcomingMessages: Array<Message> = []
    var completedMessages: Array<Message> = []

  	let dateFormatter: DateFormatter = {
    	  let d = DateFormatter()
				d.dateFormat = "HH:mm:ss"
      	return d
  	}()
    
    override func viewDidLoad() {
        runGameLoop()
        view.backgroundColor = .white
        view.sv(upcomingQueueView, scrollView, currentTimeView)

      	currentTimeView.centerHorizontally()
				currentTimeView.Top == view.Top + 40
				updateCurrentTime()

        upcomingQueueView.width(screenSize.width / 2)
        scrollView.width(screenSize.width / 2)
        upcomingQueueView.height(screenSize.height)
        scrollView.fillVertically()
        upcomingQueueView.Left == 0
        scrollView.Left == upcomingQueueView.Right

        upcomingQueueView.backgroundColor = UIColor(red: 1, green: 0, blue: 0, alpha: 0.2)
        scrollView.backgroundColor = UIColor(red: 0, green: 1, blue: 0, alpha: 0.2)

      	scrollView.sv(completedQueueView)
      	completedQueueView.fillContainer()
    }

  private func updateCurrentTime() {
    Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
      self.currentTimeView.text = self.dateFormatter.string(from: Date())
    }
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
            messageView.backgroundColor = message.color //Pencil(tag: message.color ?? 2)?.color
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
            messageView.backgroundColor = message.color // Pencil(tag: message.color ?? 2)?.color
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
            
            
            let calendar = Calendar.current
            let components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second, .nanosecond], from: message.timestamp!)
            dateTimeLabel.text = "\(String(format: "%02d", components.hour ?? 0)):\(String(format: "%02d", components.minute ?? 0)):\(String(format: "%02d", components.second ?? 0))"
        }
    }

    func emitMessages() {
      	Observable<Int>.interval(RxTimeInterval.seconds(4), scheduler: ConcurrentMainScheduler.instance)
      			.observeOn(MainScheduler.asyncInstance)
        		.subscribe(onNext: {value in
                let calendar = Calendar.current
                let randomNumber = Int.random(in: 2 ..< 10)
                let time = calendar.date(byAdding: .second, value: randomNumber, to: Date())
                // adding new message to upcoming messages
              	self.upcomingMessages.append(Message(timestamp: time, color: Pencil(tag: randomNumber)?.color ?? UIColor.black, discarded: false))
              	self.upcomingMessages = self.upcomingMessages.sorted(by: { (message1, message2) -> Bool in
                		message1.timestamp < message2.timestamp
              	})
                self.refreshUpcomingQueueView()
                
            }, onError: nil, onCompleted: nil, onDisposed: nil)
      			.disposed(by: disposeBag)
    }
    
    func observeMessages() {
        Observable<Int>.interval(RxTimeInterval.milliseconds(100), scheduler: ConcurrentMainScheduler.instance)
            .subscribe(onNext: {value in
                // filtering completed messages and discarded messages from upcoming messages
              	if let messagePop = self.upcomingMessages.first {
                  let messageDateTime = messagePop.timestamp
                  let difference = Calendar.current.dateComponents([.second, .nanosecond], from: Date(), to: messageDateTime!)
                  let seconds = difference.second ?? 0
                  let nanoseconds = difference.nanosecond ?? 0
                  let milliSeconds = (seconds * 1000) + (nanoseconds / 1_000_000)

                  if (milliSeconds <= 100 && milliSeconds >= -100) {
                    //valid message emit
                    self.completedMessages.insert(messagePop, at: 0)
                    self.upcomingMessages.removeFirst()
                  } else if (milliSeconds <= -100){
                  	//discarding the message if the delay is more than 100ms
                    let message = Message(timestamp: messagePop.timestamp, color: messagePop.color, discarded: true)
                    self.completedMessages.insert(message, at: 0)
                    self.upcomingMessages.removeFirst()
                  }
              	}

                // updating upcoming and completed views after updating upcoming and completed messages
                self.refreshUpcomingQueueView()
                self.refreshCompletedQueueView()
            }, onError: nil, onCompleted: nil, onDisposed: nil)
      			.disposed(by: disposeBag)
    }
    
    func runGameLoop() {
        emitMessages()
        observeMessages()
    }
}
