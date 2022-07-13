//: [Previous](@previous)

import UIKit

// iOS15부터 나온 Formatted API
// 숫자, 날짜, 시간 등과 같은 데이터를 사용자가 원하는 현지화된 문자열로 변환해준다.
// 사용자의 디바이스의 위치와 언어설정에 따라 다르게 나올 수 있다.

let value = Date()

print(value) // 2022-07-13 07:10:50 +0000
print(value.formatted()) // PM/AM으로 정리되어서 나옴
print(value.formatted(date: .omitted, time: .shortened)) // 시간만 나옴
print(value.formatted(date: .complete, time: .shortened)) // 전체날짜가 영어로 나옴
print(value.formatted(date: .abbreviated, time: .shortened)) // July 대신 Jul
print(value.formatted(date: .long, time: .standard)) // 초까지 나옴
print(value.formatted(date: .numeric, time: .omitted)) // 7/13/2022

let locale = Locale(identifier: "ko-KR")

let result = value.formatted(.dateTime.locale(locale).day().month(.twoDigits).year())
print(result) // 한국식으로 나옴

let result2 = value.formatted(.dateTime.day().month(.twoDigits).year())
print(result2) // 기존 영어권으로 나옴


// Number String

print(50.formatted(.percent)) // %가 붙음
print(234234534.formatted()) // 3개씩 콤마 찍혀서 나옴
print(78652.formatted(.currency(code: "krw"))) // 우리나라 화폐단위로 나옴

let result3 = ["올라프", "엘사", "안나"].formatted()
print(result3) // 영어 and를 앞에서 두 번째에 자동 추가
//: [Next](@next)
