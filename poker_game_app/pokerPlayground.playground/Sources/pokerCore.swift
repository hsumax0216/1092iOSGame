import Foundation

public struct player{
    public var cards: Array<poker>? = nil
    public var name: String = "empty"
}

public struct poker{
    public let suit: String
    public let suitnum: Int
    public let num: Int //num: 0=3 1=4 2=5 ... 8=J 9=Q 10=K 11=A 12=2
}

extension poker {
  static func == (left: poker, right: poker) -> Bool {
    return left.num==right.num && left.suitnum==right.suitnum
  }
}

public struct pokerClass{
//    public var cards=[poker]()
//    public var classing=Int()
    public var level: Int
    public var cards: Array<poker>
    public var classing: Int
    public init(cards:Array<poker>,classing:Int) {
        self.cards=cards
        self.classing=classing
        self.level=0
    }
    public init(cards:Array<poker>,classing:Int,level:Int) {
        self.cards=cards
        self.classing=classing
        self.level=level
    }
    //同花順=7,四條=6,葫蘆=5,同花=4,順子=3,三條=2,一對=1,單張=0
}

extension pokerClass {
    static func == (left: pokerClass, right: pokerClass) -> Bool {
        return left.classing==right.classing && left.level==right.level
    }
    static func > (left: pokerClass, right: pokerClass) -> Bool{
        if(left.classing==right.classing){
            return left.level>right.level
        }
        return false
    }
    static func < (left: pokerClass, right: pokerClass) -> Bool{
        if(left.classing==right.classing){
            return left.level<right.level
        }
        return false
    }
}

public func GeneratePokers()->Array<poker>{
    //♣♦♥♠
    let suits=["♣","♦","♥","♠"]
    var arra=[poker]()
    var i=0,j=0
    while(i<4){
        arra.append(poker(suit:suits[i],suitnum: i,num:j))
        j+=1
        if(j>=13){
            j=0
            i+=1
        }
    }
    return arra
}

public func fakeGeneratePokers()->Array<poker>{
    let cards=13
    var i=0
    let suits=["♣","♦","♥","♠"]
//    let  pokernum = [12,11,10, 9, 8, 7, 6, 5, 5, 5, 5, 4, 4]
//    let pokersuit = [ 3, 3, 3, 2, 1, 0, 3, 3, 2, 1, 0, 3, 2]
//    let  pokernum = [10, 8, 6, 4, 2, 1,12, 2, 1, 8, 2, 8, 2]
//    let pokersuit = [ 0, 0, 0, 0, 0, 0, 1, 1, 1, 2, 2, 3, 3]
    let pokernum=[12,11,10,9,8,7,6,2,1,0,7,8,9]//num: 0=3 1=4 2=5 ... 8=J 9=Q 10=K 11=A 12=2
    //let pokernum=[2,3,4,5,6,6,6,6,2,2,7,8,9]//num: 0=3 1=4 2=5 ... 8=J 9=Q 10=K 11=A 12=2
    let pokersuit=[1,1,0,0,0,0,0,1,1,1,3,3,3]//♣0♦1♥2♠3
    //let pokersuit=[0,0,0,0,0,1,2,3,1,2,3,3,3]//♣0♦1♥2♠3
    var arra=[poker]()
    while(i<cards){
        arra.append(poker(suit:suits[pokersuit[i]],suitnum: pokersuit[i],num:pokernum[i]))
        i+=1
    }
    PrintCards(cards: arra)
    
    return arra
}

func ShufflePoker(arra:Array<poker>)->Array<poker>{
    let a=arra.shuffled()
    return a
}

let sample=["3","4","5","6","7","8","9","10","J","Q","K","A","2"]
func PrintPoker(card:poker){
    let temp = sample[card.num]
    print("\(card.suit)\(temp) ",terminator: "")
    //print("suit:"+card.suit,", suitNum:"+String(card.suitnum),", number:"+temp)
}

public func PrintCards(cards:Array<poker>)->Int{
    if(cards.count==0){
        print("空牌組")
        return 0
    }
    var count=0
    for card in cards{
        PrintPoker(card: card)
        count+=1
    }
    print("")
    return count
}

let pokerRank=["單張","一對","三條","順子","同花","葫蘆","四條","同花順"]

public func PrintPokerClass(clas:Array<pokerClass>){
    print("此人持有牌組：")
    var count=0
    var pokerC=0
    for set in clas{
        print(pokerRank[set.classing])
        pokerC+=PrintCards(cards: set.cards)
        count+=1
    }
    print("共 \(count) 組牌組")
    print("共 \(pokerC) 張牌")
}
public func PokerNumCompare(this:poker,that:poker)->Bool{
    guard !(this.num==that.num) else {
        return this.suitnum > that.suitnum
    }
    return this.num > that.num
}

public func PokerSuitCompare(this:poker,that:poker)->Bool{
    guard !(this.suitnum==that.suitnum) else {
        return this.num > that.num
    }
    return this.suitnum > that.suitnum
}
//public func PokerClassCompare(this:pokerClass,that:poker)->Bool{
//    
//}
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
let SHUNZISP=[[12,3,2,1,0],//2,6,5,4,3  //2,3,4,5,6
              [12,11,2,1,0]]//2,A,5,4,3 //A,2,3,4,5
public func ClassingPokers(origins:Array<poker>)->Array<pokerClass>?{
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
    
    return pokersArray
}

func ComputerPoker(cards:Array<poker>,desk:Array<poker>?,action:Int)->(Array<poker>?,Array<poker>?){
    let/*var*/ rtn=[poker]()
    let/*var*/ last=[poker]()
    switch action {
    case 0://start play
        print("first start")
        let/*var*/ cardsCount=0
//        for card in cards{
//
//        }
    print(cardsCount)
    case 1://contiune(normial) play
        print("normial")
    default:
        print("ComputerPoker occur error!")
    }
    
    return (rtn,last)
}

public func GamePlay(DECK:Array<poker>,peoples:Int){
    print("In GamePlay.")
    guard peoples>1 && peoples<5/* && ((peoples%2) == 0)*/ else{
        print("The numbers of player out of setting.")
        return
    }
    var plr=[poker]()
    var comp=[Array<poker>]()
    var i=0,j=0,compCount=peoples-1
    let deck=DECK.shuffled()
    let perCards=Int(52/peoples)
    print("perCards:"+String(perCards))
    
    
    var firstPrior = 0//Int.random(in: 0...peoples-1)
    
    while(j<perCards){
        plr.append(poker(suit: deck[j].suit, suitnum: deck[j].suitnum, num: deck[j].num))
        if(deck[j].suitnum==0 && deck[j].num==0){
            print("Human have ♣3.")
            firstPrior = 0
        }
        j+=1
    }
    //plr.sort(by:PokerCompare)
    while(i<compCount){
        var temp=[poker]()
        var times=0
        while(times<perCards){
            temp.append(poker(suit: deck[j].suit, suitnum: deck[j].suitnum, num: deck[j].num))
            if(deck[j].suitnum==0 && deck[j].num==0){
                print("Computer ",i+1," have ♣3.")
                firstPrior = i+1
            }
            j+=1
            times+=1
        }
        comp.append(temp)
        i+=1
    }
    print("J:",j)
//    print("Player:")
//    PrintCards(cards: plr)
//    i=0
//    while(i<compCount){
//        print("\nComputer "+String(i+1)+":")
//        PrintCards(cards: comp[i])
//        i+=1
//    }
    print("firstPrior: ",firstPrior)
    var simulatArray=[player]()
    if(firstPrior > 0){
        //computer have ♣3.
        var ppp=firstPrior-1
        while(ppp<compCount){
            simulatArray.append(player(cards: comp[ppp], name: "Computer "+String(ppp+1)))
            ppp+=1
        }
        simulatArray.append(player(cards: plr, name: "Human"))
        ppp=0
        while(ppp<firstPrior-1){
            simulatArray.append(player(cards: comp[ppp], name: "Computer "+String(ppp+1)))
            ppp+=1
        }
    }
    else{
        //Human have ♣3
        simulatArray.append(player(cards: plr, name: "Human"))
        var ppp=0
        while(ppp<compCount){
            simulatArray.append(player(cards: comp[ppp], name: "Computer "+String(ppp+1)))
            ppp+=1
        }
    }
    
    if(peoples==3){
        simulatArray[0].cards?.append(poker(suit: deck[j].suit, suitnum: deck[j].suitnum, num: deck[j].num))
        j+=1
    }
    
    var currentPlay = 0
    var winnerRank=[String]()
    
    var desk = player()
    var passCount=0
    var (deskTmp,last):(Array<poker>?,Array<poker>?)
    var currentAct=0
    while(false/* simulatArray.count > 0 */){
        (deskTmp,last)=ComputerPoker(cards: simulatArray[currentPlay].cards!, desk: desk.cards, action: currentAct)
        if(deskTmp==nil){//this player passed
            passCount+=1
            if(passCount>simulatArray.count){
                passCount=0
                currentAct=0
            }
            else{
                currentPlay=(currentPlay+1)%simulatArray.count
            }
            continue
        }
        currentAct=1
        if(last==nil){//this player was finished its game
            winnerRank.append(simulatArray.remove(at:currentPlay).name)
            continue
        }
        simulatArray[currentPlay].cards=last!
        desk.cards=deskTmp
        desk.name=simulatArray[currentPlay].name
        currentPlay=(currentPlay+1)%simulatArray.count
    }
    print("Winning priority:")
    for win in winnerRank{
        print("\(win) >")
    }
    
}
