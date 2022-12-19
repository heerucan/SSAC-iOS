//
//  ListView.swift
//  SwiftUIDemo
//
//  Created by heerucan on 2022/12/19.
//

import SwiftUI

/// 속성들은 modifier를 통해 조정 가능
/// 
struct ListView: View {
    var body: some View {
        List {
            /// 10개까지만 가능
            Text("1위 메시")
                .font(.largeTitle)
            Text("2위 프랑스")
            Text("3위")
                .font(.caption)
            Text("1위")
                .foregroundColor(.yellow) // 뷰 설정 우선
                .background(.brown)
                .multilineTextAlignment(.trailing)
                .font(.caption)
            Text("1위")
            ForEach(0..<50) {
                Text("리스트셀\($0)")
            }
        }
        .listStyle(.plain)
        .font(.largeTitle) // 이런 그룹 설정보다는 저 위 특정 객체에 대한 설정이 더 우선이다.
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
