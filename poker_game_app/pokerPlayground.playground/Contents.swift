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
let SHUNZI=[[12,0,1,2,3],
            [7,8,9,10,11],
            [6,7,8,9,10],
            [5,6,7,8,9],
            [4,5,6,7,8],
            [3,4,5,6,7],
            [2,3,4,5,6],
            [1,2,3,4,5],
            [0,1,2,3,4],
            [11,12,0,1,2]]

print("testing")

var samp=fakeGeneratePokers()
samp.sort(by:PokerSuitCompare)
print("After Suit Sort:")
PrintCards(cards:samp)
samp.sort(by:PokerNumCompare)
print("After Num Sort:")
PrintCards(cards:samp)

let origins=samp

var tmpSuit=origins.sorted(by:PokerSuitCompare)
var pokersArray=[pokerClass]()
var hulu=[pokerClass]()
var tonghua=[pokerClass]()
var suntiao=[pokerClass]()
var yidui=[pokerClass]()
//var classingNum=7//同花順=7,同花=4
var suitsCount = 0
var ele = 1
while(ele<tmpSuit.count)/*for ele in 1...tmpSuit.count*/{
    print("ele:\(ele)")
    if(tmpSuit[ele-1].suitnum==tmpSuit[ele].suitnum){
        suitsCount+=1
    }
    else{
        suitsCount=0
    }
    if(suitsCount>=4){//至少有同花
        //var pokerTmp=Array<poker>()
        var breakloop=false
        for cmp in SHUNZI{
            for times in ele-4...ele{
                if(tmpSuit[times].num==cmp[times]){
                    breakloop=true
                }
                else{
                    breakloop=false
                    break
                }
            }
            if(breakloop) {//同花順
                let ttmp=[tmpSuit[ele-4],tmpSuit[ele-3],tmpSuit[ele-2],tmpSuit[ele-1],tmpSuit[ele]].sorted(by: PokerNumCompare)
                pokersArray.append(pokerClass(cards: ttmp, classing: 7))
                for _ in 0...4{ tmpSuit.remove(at: ele-4) }
                ele-=5
            }
            else{//同花
                let ttmp=[tmpSuit[ele-4],tmpSuit[ele-3],tmpSuit[ele-2],tmpSuit[ele-1],tmpSuit[ele]]
                tonghua.append(pokerClass(cards: ttmp, classing: 4))
            }
        }
    }
    ele+=1
}


var tmpNum=tmpSuit.sorted(by:PokerNumCompare)
var numCount = 0
ele = 1
while(ele<tmpNum.count){
    if(tmpNum[ele-1].num==tmpNum[ele].num){
        numCount+=1
    }
    else if(numCount>=2){//三條ele-3...ele-1
        let ttmp=[tmpNum[ele-3],tmpNum[ele-2],tmpNum[ele-1]]
        suntiao.append(pokerClass(cards: ttmp, classing: 2))
        for _ in 0...2{ tmpNum.remove(at: ele-3) }//在剩下牌堆中刪除三條組合
    }
    else if(numCount>=1){//一對ele-2...ele-1
        let ttmp=[tmpNum[ele-2],tmpNum[ele-1]]
        yidui.append(pokerClass(cards: ttmp, classing: 1))
        for _ in 0...1{ tmpNum.remove(at: ele-2) }//在剩下牌堆中刪除一對組合
    }
    if(numCount>=3){//四條ele-3...ele
        let ttmp=[tmpNum[ele-3],tmpNum[ele-2],tmpNum[ele-1],tmpNum[ele]]
        pokersArray.append(pokerClass(cards: ttmp, classing: 6))
        for _ in 0...3{ tmpNum.remove(at: ele-3) }//在剩下牌堆中刪除四條組合
        ele-=4
    }
    ele+=1
}


let sun_duiCount = suntiao.count < yidui.count ? suntiao.count : yidui.count
for _ in 1...sun_duiCount{//三條一對 轉 葫蘆
    let ttmp = (suntiao[0].cards+yidui[0].cards).sorted(by: PokerNumCompare)
    hulu.append(pokerClass(cards: ttmp, classing: 5))
    for t in 0...4{//在剩下牌堆中刪除葫蘆組合
        var times=0
        while(times<tmpNum.count){
            if(tmpNum[times].num==hulu.last!.cards[t].num && tmpNum[times].suitnum==hulu.last!.cards[t].suitnum){
                tmpNum.remove(at: times)
                break
                //times-=1
            }
            times+=1
        }
    }
    suntiao.removeFirst()
    yidui.removeFirst()
}
pokersArray+=hulu

if(tonghua.count>0){
    for _ in 1...tonghua.count{//同花個數
        for t in 0...4{//在剩下牌堆中刪除同花組合
            var times=0
            while(times<tmpNum.count){
                if(tmpNum[times].num==tonghua.last!.cards[t].num && tmpNum[times].suitnum==tonghua.last!.cards[t].suitnum){
                    tmpNum.remove(at: times)
                    break
                    //times-=1
                }
                times+=1
            }
        }
    }
}
pokersArray+=tonghua

var elet = 1
while(elet<tmpNum.count){
    var breakloop=false
    for cmp in SHUNZI{
        for times in elet-4...elet{
            if(tmpNum[times].num==cmp[times]){
                breakloop=true
            }
            else{
                breakloop=false
                break
            }
        }
        if(breakloop) {//順子
            let ttmp=[tmpNum[elet-4],tmpNum[elet-3],tmpNum[elet-2],tmpNum[elet-1],tmpNum[elet]].sorted(by: PokerNumCompare)
            pokersArray.append(pokerClass(cards: ttmp, classing: 3))
            for _ in 0...4{ tmpNum.remove(at: elet-4) }
            elet-=5
        }
    }
}

if(suntiao.count>0){ pokersArray+=suntiao }

if(yidui.count>0){ pokersArray+=yidui }

//單張
while(tmpNum.count>0){
    pokersArray.append(pokerClass(cards: [tmpNum.removeFirst()], classing: 0))
}





var tmp=pokersArray
PrintPokerClass(clas:tmp)


//func test(desk:player?){
//    return print(desk==nil)
//}
//
//var desk:player?
//test(desk:desk)
//var arr = [Int]()
//for i in 1...10{
//    arr.append(i)
//}
//var arrcount=arr.count
//var t=0
//while(t < arr.count){
//    print("arr.count:",arr.count)
//    print("t:",t,"arr[t]:",arr[t])
//    if(t==2){
//        print("t>2")
//        for tt in 3...5{
//            print(arr[tt])
//        }
//        print("removeing")
//        for _ in 0...2{
//            arr.remove(at: 3)
//        }
//        print("remove finish")
//        arrcount=arr.count
//    }
//    t+=1
//}
//for v in arr{
//    print(v)
//}
print("testing")

