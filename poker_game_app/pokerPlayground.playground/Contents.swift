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

ele=0
//var breakCount = 0
while(ele<tmpSuit.count && tmpSuit.count>4 /*&& breakCount<=100*/)/*for ele in 1...tmpSuit.count*/{
    //breakCount+=1
    if(ele<0){ ele=0 }
    var coun=ele
    var suitS=ele
    var suitE=suitS
    //print("suitS:\(suitS), ",terminator: "")
    //do{ sleep(3) }
    //print(" tmpSuit[\(suitS)].suitnum=\(tmpSuit[suitS].suitnum)\n")
    var suitreg=tmpSuit[suitS].suitnum
    while(coun<tmpSuit.count){
        if(!(tmpSuit[coun].suitnum==suitreg)){
            ele=coun
            break
        }
        coun+=1
    }
    //print("ele:\(ele)\nsuitS:\(suitS)\n")
    suitE=coun-1
    //print("coun:\(coun)\nsuitE:\(suitE)\ntmpSuit.count:\(tmpSuit.count)")
    if(/*!(suitS==suitE) && */suitE-suitS > 3){
        coun=suitS
        var cmp=0
        var breakloop=false
        while(coun<suitE-3){
            //print("tmpSuit[\(coun)].num=\(tmpSuit[coun].num)\n")
            if(tmpSuit[coun].num==SHUNZI[cmp][0]){
                //print("tmpSuit[\(coun)].num=\(tmpSuit[coun].num) ,cmp=\(cmp)\n")
                var times=1
                var loc=[Int]()
                loc.append(coun)
                var count = coun
                while(count<=suitE && times<5){
                    //TODO:檢查是否有同花順 並加入pokerArray
                    if(tmpSuit[count].num==SHUNZI[cmp][times]){
                        times+=1
                        loc.append(count)
                    }
                    count+=1
                }
                //print("times=\(times)")
                //print("loc:\(loc)\n")
                if(times==5){//有同花順
                    let level=SHUNZI.count-cmp
                    loc.sort(by: >)
                    let ttmp=[tmpSuit[loc[0]],tmpSuit[loc[1]],tmpSuit[loc[2]],tmpSuit[loc[3]],tmpSuit[loc[4]]].sorted(by: PokerNumCompare)
                    pokersArray.append(pokerClass(cards: ttmp, classing: 7,level: level))
                    for _ in 0...4{ tmpSuit.remove(at: loc.removeFirst()) }
                    
                    ele-=5
                    //suitE-=5
                    //coun += 1
                    cmp = 0
                    breakloop=true
                    
                    print("\nAdd LV\(level).: ",terminator: "")
                    PrintCards(cards:ttmp)
                    print("")
                }
            }
            if(breakloop){//已加同花順 需跳出迴圈 找下一個同花順
                breakloop=false
                break
            }
            if(cmp==SHUNZI.count-1){
                //print("coun:\(coun)")
                coun += 1
                cmp = -1
            }
            cmp+=1
        }
    }
    //print("THE END tmpSuit.count:\(tmpSuit.count), ele=\(ele)")
    //print("suitreg=\(suitreg)")
    if(suitreg==0){
        break
    }
}
print("同花順篩選:")
PrintCards(cards:tmpSuit)

var tmpNum=tmpSuit.sorted(by:PokerNumCompare)

//print("After Num Sort:")
//PrintCards(cards:tmpNum)

ele = 1
var numCount = 0
while(ele<=tmpNum.count){
    //print("tmpNum:\(tmpNum.count)")
    //print("ele:\(ele)")
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

let sun_duiCount = suntiao.count < yidui.count ? suntiao.count : yidui.count
//print("sun_duiCount:\(sun_duiCount)\n")
var coun = 0
while(coun<sun_duiCount)/*for _ in 1...sun_duiCount*/{//三條一對 轉 葫蘆
    let ttmp = (suntiao[0].cards+yidui[0].cards).sorted(by: PokerNumCompare)
    hulu.append(pokerClass(cards: ttmp, classing: 5))
    print("\nAdd 葫蘆: ",terminator: "")
    PrintCards(cards:ttmp)
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
    //print("ele:\(ele)")
    if(tmpNum[ele-1].suitnum==tmpNum[ele].suitnum){
        suitsCount+=1
    }
    else{
        suitsCount=0
    }
    if(suitsCount>=4){
        let ttmp=[tmpNum[ele-4],tmpNum[ele-3],tmpNum[ele-2],tmpNum[ele-1],tmpNum[ele]]
        for _ in 0...4{ tmpNum.remove(at: ele-4) }
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

ele = 1
var cmp=0
while(ele<tmpNum.count && tmpNum.count > 4){
    if(tmpNum[ele].num==SHUNZI[cmp][0]){
        //print("SHUNZI[\(cmp)]:\(SHUNZI[cmp])\nsearching...\n")
        var times=1
        var eleS=ele
        let level=10-cmp
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
            //print("loc:\(loc)")
            let ttmp=[tmpNum[loc[0]],tmpNum[loc[1]],tmpNum[loc[2]],tmpNum[loc[3]],tmpNum[loc[4]]].sorted(by: PokerNumCompare)
            pokersArray.append(pokerClass(cards: ttmp, classing: 3,level: level))
            for _ in 0...4{ tmpNum.remove(at: loc.removeFirst()) }
    
            print("\nAdd LV\(level).: ",terminator: "")
            PrintCards(cards:ttmp)
            print("")
        }
    }
    else{
        //print("SHUNZI[\(cmp)]:\(SHUNZI[cmp])\ncontinue\n")
        cmp+=1
        continue
    }
    ele+=1
}
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

PrintPokerClass(clas:pokersArray)

//let tmp=ClassingPokers(origins:samp)!
//PrintPokerClass(clas:tmp)


print("testing")

