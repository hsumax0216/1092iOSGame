import Foundation


print("testing")

let SHUNZI=[[12,3,2,1,0],
            [11,10,9,8,7],
            [10,9,8,7,6],
            [9,8,7,6,5],
            [8,7,6,5,4],
            [7,6,5,4,3],
            [6,5,4,3,2],
            [5,4,3,2,1],
            [4,3,2,1,0],
            [12,11,2,1,0]]
//let SHUNZINOR=[[11,10,9,8,7],
//               [10,9,8,7,6],
//               [9,8,7,6,5],
//               [8,7,6,5,4],
//               [7,6,5,4,3],
//               [6,5,4,3,2],
//               [5,4,3,2,1],
//               [4,3,2,1,0]]
let SHUNZISP=[[12,3,2,1,0],//2,6,5,4,3  //2,3,4,5,6
              [12,11,2,1,0]]//2,A,5,4,3 //A,2,3,4,5

var samp=fakeGeneratePokers()
samp.sort(by:PokerSuitCompare)
print("After Suit Sort:")
PrintCards(cards:samp)
samp.sort(by:PokerNumCompare)
print("After Num Sort:")
PrintCards(cards:samp)


let tmp=ClassingPokers(origins:samp)!
PrintPokerClass(clas:tmp)


print("testing")

