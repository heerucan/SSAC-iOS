//
//  SocketIOManager.swift
//  socket
//
//  Created by heerucan on 2022/11/23.
//

import Foundation

import SocketIO

class SocketIOManager {
    static let shared = SocketIOManager()
    
    // 서버와 메시지를 주고 받기 위한 클래스
    var manager: SocketManager!
    var socket: SocketIOClient!
    
    private init() {
        manager = SocketManager(
            socketURL: URL(string: APIKey.socket)!,
            config: [
                .log(true),
                .extraHeaders(["auth": APIKey.header])
            ]
        )
        
        /* http://~/2022로 통신하겠다.
         1:1 카톡방은 개별 공간이 만들어지는 거고
         1500명이 한 방에 같이 카톡하고 주고 받을 수 있잖아?
         그래서 별도로 링크에 대한 세부 정보를 만들어두지 않아서 가입한 모든 유저가 그 채팅방에 들어와 쓸 수 있는 것
         
         근데 정보가 바뀌면, defaultSocket의 정보가 바껴서 1:1로 채팅할 수 있는 공간이 있다.
         */
        socket = manager.defaultSocket // http://api.sesac.co.kr:2022/ 이걸루 기본 서버 링크로 소통할 것임
        
        
        // 연결
        socket.on(clientEvent: .connect) { data, ack in
            print("SOCKET IS CONNECTED", data, ack)
        }
        
        // 연결 해제
        socket.on(clientEvent: .disconnect) { data, ack in
            print("SOCKET IS DISCONNECTED", data, ack)
        }
        
        // 이벤트 수신
        socket.on("sesac") { dataArray, ack in
            print("SESAC RECEIVED", dataArray, ack)
            // 프린트만 하는 것이 아니라
            // 데이터가 뷰로 보일 수 있게 -> chat에 내용을 담아야 한다.
            
            let data = dataArray[0] as! NSDictionary
            let chat = data["text"] as! String
            let name = data["name"] as! String
            let userId = data["userId"] as! String
            let createdAt = data["createdAt"] as! String
            
            print("Check >>>>", chat, name, createdAt)
            
            NotificationCenter.default.post(name: NSNotification.Name("getMessage"),
                                            object: self,
                                            userInfo: ["chat" : chat,
                                                       "name" : name,
                                                       "createdAt" : createdAt,
                                                       "userId" : userId])
        }
    }
    
    // 실질적으로 connect, disconnect 해주는 메소드
    func establishConnection() {
        socket.connect()
    }
    
    func closeConnection() {
        socket.disconnect()
    }
}
//
