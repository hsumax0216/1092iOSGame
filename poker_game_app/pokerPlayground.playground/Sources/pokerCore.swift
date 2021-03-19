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

public struct pokerClass{
//    public var cards=[poker]()
//    public var classing=Int()
    public var cards: Array<poker>
    public var classing: Int
    public init(cards:Array<poker>,classing:Int) {
        self.cards=cards
        self.classing=classing
    }
    //同花順=7,四條=6,葫蘆=5,同花=4,順子=3,三條=2,一對=1,單張=0
}

extension poker {
  static func == (left: poker, right: poker) -> Bool {
    return left.num==right.num && left.suitnum==right.suitnum
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
    let pokernum=[12,11,10,9,8,7,2,1,0,2,7,8,9]//num: 0=3 1=4 2=5 ... 8=J 9=Q 10=K 11=A 12=2
    //let pokernum=[2,3,4,5,6,6,6,6,2,2,7,8,9]//num: 0=3 1=4 2=5 ... 8=J 9=Q 10=K 11=A 12=2
    let pokersuit=[0,0,0,0,0,0,0,0,0,2,3,3,3]//♣0♦1♥2♠3
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
public func ClassingPokers(origins:Array<poker>)->Array<pokerClass>?{
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