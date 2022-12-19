//
//  ExampleView.swift
//  SwiftUIDemo
//
//  Created by heerucan on 2022/12/19.
//

import SwiftUI

struct ExampleView: View {
    var body: some View {
        VStack {
            Text("안녕하세요")
                .font(.title)
                .foregroundColor(.orange)
                .fontWeight(.heavy)
            Spacer() // 비어있는 공간을 최대한 활용하는 것
            Text("Hello, World!")
                .font(.title3)
                .foregroundColor(.brown)
                .fontWeight(.regular)
                .italic()
            Circle()
                .fill(.yellow)
            Ellipse()
                .fill(.green)
            Image(systemName: "heart.fill")
                .imageScale(.large)
                .foregroundColor(.pink)
            Rectangle()
                .fill(.blue)
                .border(.yellow, width: 10)
            Spacer()
            Text("메시야 축구 이긴 거 축하해 \n호롤 \n호롤호롤")
                .font(.callout)
                .foregroundColor(.cyan)
                .fontWeight(.medium)
                .underline()
                .lineLimit(2)
//                .strikethrough()
//                .kerning(10)
        }
    }
}

struct ExampleView_Previews: PreviewProvider {
    static var previews: some View {
        ExampleView()
//            .previewDevice("iPhone 8")
    }
}
