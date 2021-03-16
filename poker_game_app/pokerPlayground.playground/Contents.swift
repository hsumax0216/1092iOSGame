import Foundation
//let a=GeneratePokers()
//GamePlay(DECK: a, peoples: 3)

//func input() -> String {
//   let keyboard = FileHandle.standardInput
//   let inputData = keyboard.availableData
//   return String(data: inputData, encoding: .utf8)!
//}

//let test = input()
//print("output:",test)
//var i=0
//var arr=[Int]()
//while(i<10){
//    arr.append(i)
//    i+=1
//}
//
//print(arr.count)
//arr.remove(at: 3)
//print(arr.count)
//arr
print("testing")
var samp=fakeGeneratePokers()
samp.sort(by:PokerNumCompare)
print("After Num Sort:")
PrintCards(cards:samp)
samp.sort(by:PokerSuitCompare)
print("After Suit Sort:")
PrintCards(cards:samp)
//func test(desk:player?){
//    return print(desk==nil)
//}
//
//var desk:player?
//test(desk:desk)
print("testing")

