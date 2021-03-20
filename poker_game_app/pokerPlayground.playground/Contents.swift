import Foundation
//let a=GeneratePokers()
//GamePlay(DECK: a, peoples: 3)

//func input() -> String {
//   let keyboard = FileHandle.standardInput
//   let inputData = keyboard.availableData
//   return String(data: inputData, encoding: .utf8)!
//}
//let con1=[10,8,6,4,2,0]
//let con2=[1,3,5,7,9,11]
//print((con1+con2).sorted(by:>))
//let constArr=[1,4,2,5,3,6,9,7,0,8,11]
//print(constArr.sorted(by:>))
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

let SHUNZINOR=[[11,10,9,8,7],
               [10,9,8,7,6],
               [9,8,7,6,5],
               [8,7,6,5,4],
               [7,6,5,4,3],
               [6,5,4,3,2],
               [5,4,3,2,1],
               [4,3,2,1,0]]
let SHUNZISP=[[12,3,2,1,0],//2,6,5,4,3  //2,3,4,5,6
              [12,11,2,1,0]]//2,A,5,4,3 //A,2,3,4,5

print("testing")

var samp=fakeGeneratePokers()
samp.sort(by:PokerSuitCompare)
print("After Suit Sort:")
PrintCards(cards:samp)
//samp.sort(by:PokerNumCompare)
//print("After Num Sort:")
//PrintCards(cards:samp)

let origins=samp

var tmpSuit=origins.sorted(by:PokerSuitCompare)
var pokersArray=[pokerClass]()
var miniTonghuaShun=[pokerClass]()
var hulu=[pokerClass]()
var tonghua=[pokerClass]()
var suntiao=[pokerClass]()
var yidui=[pokerClass]()
//var classingNum=7//同花順=7,同花=4
var suitsCount = 0
var ele = 1
//print("tmpSuit:\(tmpSuit.count)")

/*同花順最大分類begin*/
//while(ele<tmpSuit.count){
//    var firLoc=Int()
//    if(tmpSuit[ele].num==12/*SHUNZISP[0][0]*/){
//        firLoc=ele
//        //print("firLoc=\(firLoc)")
//    }
//    else{
//        ele+=1
//        continue
//    }
//
//    var srh=ele+1,shunC=1
//    //print("tmpSuit.count=\(tmpSuit.count) SHUNZISP[0].count=\(SHUNZISP[0].count)")
//    var boolloop=true
//    var loc=[Int]()
//    while(srh<tmpSuit.count && shunC<SHUNZISP[0].count){
//        if(tmpSuit[srh].num==SHUNZISP[0][shunC] && tmpSuit[srh].suitnum==tmpSuit[ele].suitnum){
//            //print("tmpSuit[\(srh)].num=\(tmpSuit[srh].num) SHUNZISP[0][\(shunC)]=\(SHUNZISP[0][shunC])")
//            shunC+=1
//            //print("tmpSuit[\(srh)].num=\(tmpSuit[srh].num) loc: \(srh)")
//            loc.append(srh)
//            boolloop=true
//        }
//        else{
//            //print("tmpSuit[\(srh)].num=\(tmpSuit[srh].num) SHUNZISP[0][\(shunC)]=\(SHUNZISP[0][shunC])")
//            //print("loc:\(loc)")
//            //print("boolloop false\n")
//            boolloop=false
//        }
//        srh+=1
//    }
//    if(boolloop){
//        loc.append(firLoc)
//        loc.sort(by: >)
//        //print("loc:\(loc)")
//        let ttmp=[tmpSuit[loc[0]],tmpSuit[loc[1]],tmpSuit[loc[2]],tmpSuit[loc[3]],tmpSuit[loc[4]]].sorted(by: PokerNumCompare)
//        pokersArray.append(pokerClass(cards: ttmp, classing: 7))
//        for cun in 0...4{ tmpSuit.remove(at: loc[cun]) }
//        ele-=1
//        print("\nAdd: ",terminator: "")
//        PrintCards(cards:ttmp)
//        print("")
//    }
//    ele+=1
//}
//print("最大同花順篩選:")
//PrintCards(cards:tmpSuit)
//print("")
//samp.sort(by:PokerSuitCompare)
//print("After Suit Sort:")
//PrintCards(cards:samp)

/*同花順最大分類end*/

///*同花順最大分類begin*/
//while(ele<tmpSuit.count){
//    var firLoc=Int()
//    if(tmpSuit[ele].num==12/*SHUNZISP[0][0]*/){
//        firLoc=ele
//        print("firLoc=\(firLoc)")
//    }
//    else{
//        ele+=1
//        continue
//    }
//
//    var srh=tmpSuit.count-1,shunC=SHUNZISP[0].count-1
//    print("tmpSuit.count=\(tmpSuit.count) SHUNZISP[0].count=\(SHUNZISP[0].count)")
//    var boolloop=true
//    var loc=[Int]()
//    while(srh>=0 && shunC>0){
//        if(tmpSuit[srh].num==SHUNZISP[0][shunC] && tmpSuit[srh].suitnum==tmpSuit[ele].suitnum){
//            print("tmpSuit[\(srh)].num=\(tmpSuit[srh].num) SHUNZISP[0][\(shunC)]=\(SHUNZISP[0][shunC])")
//            shunC-=1
//            print("tmpSuit[\(srh)].num=\(tmpSuit[srh].num) loc: \(srh)")
//            loc.append(srh)
//            boolloop=true
//        }
//        else{
//            print("tmpSuit[\(srh)].num=\(tmpSuit[srh].num) SHUNZISP[0][\(shunC)]=\(SHUNZISP[0][shunC])")
//            print("loc:\(loc)")
//            print("boolloop false\n")
//            boolloop=false
//        }
//        srh-=1
//    }
//    if(boolloop){
//        loc.append(firLoc)
//        print("loc:\(loc)")
//        let ttmp=[tmpSuit[loc[0]],tmpSuit[loc[1]],tmpSuit[loc[2]],tmpSuit[loc[3]],tmpSuit[loc[4]]].sorted(by: PokerNumCompare)
//        pokersArray.append(pokerClass(cards: ttmp, classing: 7))
//        for cun in 0...4{ tmpSuit.remove(at: loc[cun]) }
//        ele-=1
//        print("\nAdd: ",terminator: "")
//        PrintCards(cards:ttmp)
//        print("")
//    }
//    ele+=1
//}
//print("最大同花順篩選:")
//PrintCards(cards:tmpSuit)
//
////samp.sort(by:PokerSuitCompare)
////print("After Suit Sort:")
////PrintCards(cards:samp)
//
//ele=1
///*同花順最大分類end*/

ele=1
while(ele<tmpSuit.count)/*for ele in 1...tmpSuit.count*/{
    //print("ele:\(ele)")
    if(tmpSuit[ele-1].suitnum==tmpSuit[ele].suitnum){
        suitsCount+=1
    }
    else{
        suitsCount=0
    }
    if(suitsCount>=4){//至少有同花
        var breakloop=false
        var level=SHUNZI.count
        var cmp=0
        while(cmp<SHUNZI.count)/*for cmp in SHUNZI*/{
            let eleS=ele-4
            print("eleS=\(eleS)")
            for times in 0...4{
                if(tmpSuit[eleS+times].num==SHUNZI[cmp][times]){
                    breakloop=true
                }
                else{
                    breakloop=false
                    break
                }
            }
            if(breakloop){ break }
            cmp+=1
        }
        level-=cmp
        if(breakloop) {//同花順
            let ttmp=[tmpSuit[ele-4],tmpSuit[ele-3],tmpSuit[ele-2],tmpSuit[ele-1],tmpSuit[ele]].sorted(by: PokerNumCompare)
            pokersArray.append(pokerClass(cards: ttmp, classing: 7,level: level))
            for _ in 0...4{ tmpSuit.remove(at: ele-4) }
            ele-=5
            
            print("\nAdd LV\(level).: ",terminator: "")
            PrintCards(cards:ttmp)
            print("")
            //break
        }
//        else{//同花
//            let ttmp=[tmpSuit[ele-4],tmpSuit[ele-3],tmpSuit[ele-2],tmpSuit[ele-1],tmpSuit[ele]]
//            tonghua.append(pokerClass(cards: ttmp, classing: 4))
//
//            print("\nAdd tonghua: ",terminator: "")
//            PrintCards(cards:ttmp)
//            print("")
//        }
    }
    ele+=1
}
print("同花順篩選:")
PrintCards(cards:tmpSuit)
//
//ele=1
///*同花順最小分類begin*/
//while(ele<tmpSuit.count){
//    var firLoc=Int()
//    if(tmpSuit[ele].num==12 && tmpSuit[ele+1].num==11/*SHUNZISP[1][1]*/){
//        firLoc=ele
//    }
//    else{
//        ele+=1
//        continue
//    }
//
//
//    var srh=ele+2,shunC=2
//    print("tmpSuit.count=\(tmpSuit.count) SHUNZISP[0].count=\(SHUNZISP[0].count)")
//    var boolloop=true
//    var loc=[Int]()
//    while(srh<tmpSuit.count && shunC<SHUNZISP[1].count){
//        if(tmpSuit[srh].num==SHUNZISP[0][shunC] && tmpSuit[srh].suitnum==tmpSuit[ele].suitnum){
//            print("tmpSuit[\(srh)].num=\(tmpSuit[srh].num) SHUNZISP[0][\(shunC)]=\(SHUNZISP[0][shunC])")
//            shunC+=1
//            loc.append(srh)
//            boolloop=true
//        }
//        else{
//            print("tmpSuit[\(srh)].num=\(tmpSuit[srh].num) SHUNZISP[0][\(shunC)]=\(SHUNZISP[0][shunC])")
//            print("loc:\(loc)")
//            print("boolloop false")
//            boolloop=false
//            break
//        }
//        srh+=1
//    }
//    if(boolloop){
//        loc.append(firLoc)
//        loc.append(firLoc+1)
//        loc.sort(by: >)
//        let ttmp=[tmpSuit[loc[0]],tmpSuit[loc[1]],tmpSuit[loc[2]],tmpSuit[loc[3]],tmpSuit[loc[4]]].sorted(by: PokerNumCompare)
//        pokersArray.append(pokerClass(cards: ttmp, classing: 7))
//        for cun in 0...4{ tmpSuit.remove(at: loc[cun]) }
//        ele-=1
//    }
//
//    ele+=1
//}
//print("最小同花順篩選:")
//PrintCards(cards:tmpSuit)

/*同花順最小分類end*/





var tmpNum=tmpSuit.sorted(by:PokerNumCompare)

print("After Num Sort:")
PrintCards(cards:tmpNum)

ele = 1
var numCount = 0
while(ele<=tmpNum.count){
    print("tmpNum:\(tmpNum.count)")
    print("ele:\(ele)")
    if(ele<1){ ele=1 }
    if(ele<tmpNum.count && tmpNum[ele-1].num==tmpNum[ele].num){
        numCount+=1
    }
    else if(numCount>=2){//三條ele-3...ele-1
        let ttmp=[tmpNum[ele-3],tmpNum[ele-2],tmpNum[ele-1]]
        suntiao.append(pokerClass(cards: ttmp, classing: 2))
        for _ in 0...2{ tmpNum.remove(at: ele-3) }//在剩下牌堆中刪除三條組合
        numCount=0
        ele-=3
        print("\nAdd 三條: ",terminator: "")
        PrintCards(cards:ttmp)
        print("")
    }
    else if(numCount>=1){//一對ele-2...ele-1
        let ttmp=[tmpNum[ele-2],tmpNum[ele-1]]
        yidui.append(pokerClass(cards: ttmp, classing: 1))
        for _ in 0...1{ tmpNum.remove(at: ele-2) }//在剩下牌堆中刪除一對組合
        numCount=0
        ele-=2
        print("\nAdd 一對: ",terminator: "")
        PrintCards(cards:ttmp)
        print("")
    }
    
    if(numCount>=3){//四條ele-3...ele
        let ttmp=[tmpNum[ele-3],tmpNum[ele-2],tmpNum[ele-1],tmpNum[ele]]
        pokersArray.append(pokerClass(cards: ttmp, classing: 6))
        for _ in 0...3{ tmpNum.remove(at: ele-3) }//在剩下牌堆中刪除四條組合
        numCount=0
        ele-=4
        print("\nAdd 四條: ",terminator: "")
        PrintCards(cards:ttmp)
        print("")
    }
    ele+=1
}
print("四條三條一對篩選:")
PrintCards(cards:tmpNum)
//print("三條:")
//PrintPokerClass(clas:suntiao)
//print("一對:")
//PrintPokerClass(clas:yidui)

//print("\ntesting 葫蘆:")
//PrintCards(cards: (suntiao[0].cards+yidui[0].cards).sorted(by: PokerNumCompare))
//print("")
let sun_duiCount = suntiao.count < yidui.count ? suntiao.count : yidui.count
//print("sun_duiCount:\(sun_duiCount)\n")
var coun = 0
while(coun<sun_duiCount)/*for _ in 1...sun_duiCount*/{//三條一對 轉 葫蘆
    let ttmp = (suntiao[0].cards+yidui[0].cards).sorted(by: PokerNumCompare)
    hulu.append(pokerClass(cards: ttmp, classing: 5))
    print("\nAdd 葫蘆: ",terminator: "")
    PrintCards(cards:ttmp)
    
    /*葫蘆刪除begin 前面三條一對已刪除 故不用*/
//    for t in 0...4{//在剩下牌堆中刪除葫蘆組合
//        var times=0
//        while(times<tmpNum.count){
//            if(tmpNum[times].num==hulu.last!.cards[t].num && tmpNum[times].suitnum==hulu.last!.cards[t].suitnum){
//                tmpNum.remove(at: times)
//                break
//                //times-=1
//            }
//            times+=1
//        }
//    }
    /*葫蘆刪除end*/
    suntiao.removeFirst()
    yidui.removeFirst()
    coun+=1
}
if(hulu.count > 0){ pokersArray+=hulu }
print("\n葫蘆篩選:")
PrintCards(cards:tmpNum)


tmpNum.sort(by:PokerSuitCompare)
print("After Suit Sort:")
PrintCards(cards:tmpNum)

ele=1
suitsCount=0
while(ele<tmpNum.count && tmpNum.count>4)/*for ele in 1...tmpSuit.count*/{
    print("ele:\(ele)")
    if(tmpNum[ele-1].suitnum==tmpNum[ele].suitnum){
        suitsCount+=1
    }
    else{
        suitsCount=0
    }
    if(suitsCount>=4){//有同花
//        var breakloop=false
//        while(cmp<SHUNZI.count)/*for cmp in SHUNZI*/{
//            var eleS=ele-4
//            print("eleS=\(eleS)")
//            for times in 0...4{
//                if(tmpSuit[eleS+times].num==SHUNZI[cmp][times]){
//                    breakloop=true
//                }
//                else{
//                    breakloop=false
//                    break
//                }
//            }
//            if(breakloop){ break }
//            cmp+=1
//        }
//        level-=cmp
//        if(breakloop) {//同花順
//            let ttmp=[tmpSuit[ele-4],tmpSuit[ele-3],tmpSuit[ele-2],tmpSuit[ele-1],tmpSuit[ele]].sorted(by: PokerNumCompare)
//            pokersArray.append(pokerClass(cards: ttmp, classing: 7,level: level))
//            for _ in 0...4{ tmpSuit.remove(at: ele-4) }
//            ele-=5
//
//            print("\nAdd LV\(level).: ",terminator: "")
//            PrintCards(cards:ttmp)
//            print("")
//            //break
//        }
        let ttmp=[tmpSuit[ele-4],tmpSuit[ele-3],tmpSuit[ele-2],tmpSuit[ele-1],tmpSuit[ele]]
        for _ in 0...4{ tmpSuit.remove(at: ele-4) }
        pokersArray.append(pokerClass(cards: ttmp, classing: 4))
        ele-=5
        
        print("\nAdd tonghua: ",terminator: "")
        PrintCards(cards:ttmp)
        print("")
    }
    ele+=1
}
tmpNum.sort(by:PokerNumCompare)
print("\n同花篩選:")
PrintCards(cards:tmpNum)

/*舊同花begin*/
//var savArr=[pokerClass]()
//if(tonghua.count>0){
//    for sav in tonghua{//同花個數
//        var removeBool=false
//        var loc=[Int]()
//        //在剩下牌堆中刪除同花組合
//        var times=0
//        var t=0
//        while(times<tmpNum.count || t<5){
//            if(tmpNum[times].num==tonghua.last!.cards[t].num && tmpNum[times].suitnum==tonghua.last!.cards[t].suitnum){
//                removeBool=true
//                loc.append(times)
//                t+=1
//                //times-=1
//            }
//            else{
//                removeBool=false
//            }
//            times+=1
//        }
//
//        if(removeBool){
//            loc.sort(by: >)
//            savArr.append(sav)
//            for Loc in loc{ tmpNum.remove(at: Loc) }
//        }
//    }
//}
//for coun in 0...savArr.count-1{ savArr[coun].level=savArr.count-coun }
//pokersArray+=savArr
/*舊同花end*/
ele = 1
var cmp=0
while(ele<tmpNum.count && tmpNum.count > 4){
    if(tmpNum[ele].num==SHUNZI[cmp][0]){
        print("SHUNZI[\(cmp)]:\(SHUNZI[cmp])\nsearching...\n")
        var times=1
        var eleS=ele
        var level=10-cmp
        var loc=[Int]()
        while(eleS<tmpNum.count && times<SHUNZI[cmp].count/*5*/){
            if(tmpNum[eleS].num==SHUNZI[cmp][times]){
                loc.append(eleS)
                times+=1
            }
            eleS+=1
        }
        if(times==5){
            loc.append(ele)
            loc.sort(by:>)
            print("loc:\(loc)")
            let ttmp=[tmpNum[loc[0]],tmpNum[loc[1]],tmpNum[loc[2]],tmpNum[loc[3]],tmpNum[loc[4]]].sorted(by: PokerNumCompare)
            pokersArray.append(pokerClass(cards: ttmp, classing: 3,level: level))
            for _ in 0...4{ tmpNum.remove(at: loc.removeFirst()) }
    
            print("\nAdd LV\(level).: ",terminator: "")
            PrintCards(cards:ttmp)
            print("")
        }
    }
    else{
        print("SHUNZI[\(cmp)]:\(SHUNZI[cmp])\ncontinue\n")
        cmp+=1
        continue
    }
    ele+=1
}
/*舊順子begin*/
//var elet = 1
//while(elet<tmpNum.count || tmpNum.count > 4){
//    var breakloop=false
//    var level=SHUNZI.count
//    var cmp=0
//    while(cmp<SHUNZI.count)/*for cmp in SHUNZI*/{
//        var eleS=elet
//        print("eleS=\(eleS)")
//
//        var times=0
//        while(eleS<tmpNum.count || times<5){
//            if(tmpSuit[eleS].num==SHUNZI[cmp][times]){
//                breakloop=true
//                times+=1
//            }
//            else{
//                breakloop=false
//            }
//            eleS+=1
//        }
//
//
//        if(breakloop){ break }
//        cmp+=1
//    }
//    level-=cmp
//    if(breakloop) {//順子
//        let ttmp=[tmpSuit[elet-4],tmpSuit[elet-3],tmpSuit[elet-2],tmpSuit[elet-1],tmpSuit[elet]].sorted(by: PokerNumCompare)
//        pokersArray.append(pokerClass(cards: ttmp, classing: 3,level: level))
//        for _ in 0...4{ tmpSuit.remove(at: elet-4) }
//        ele-=5
//
//        print("\nAdd LV\(level).: ",terminator: "")
//        PrintCards(cards:ttmp)
//        print("")
//        //break
//    }
//    elet+=1
//}
/*舊順子end*/
print("\n順子篩選:")
PrintCards(cards:tmpNum)

if(suntiao.count>0){ pokersArray+=suntiao }

if(yidui.count>0){ pokersArray+=yidui }

//單張
while(tmpNum.count>0){
    pokersArray.append(pokerClass(cards: [tmpNum.removeFirst()], classing: 0))
}
print("\n單張篩選:")
PrintCards(cards:tmpNum)





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

