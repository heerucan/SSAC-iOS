//
//  ContentView.swift
//  SwiftUIDemo
//
//  Created by heerucan on 2022/12/19.
//

import SwiftUI

/*
 SwiftUI - iOS13부터 가능 / WWDC19
 UIKit
 WatchKit - AppleWatch
 AppKit - MacApp
 
 Kit마다 다양한 앱을 만들 수 있는데 스유로는 다 가능
 */

/*
 - UIKit과 다르게 prefix가 떨어짐!!!!
 - 상속이 불가능함 왜냐? 구조체로 기반된 스유거든!!
 - TableView 대신 List ..! 접근법이 완전 달라짐
 */

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "star.fill")
                .imageScale(.large)
                .foregroundColor(Color.pink)
            Text("루힁")
        }
        .padding()
        .border(.red)
        .padding()
        .border(.green)
        .frame(width: 400, height: 700)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.gray)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
