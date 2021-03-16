import Foundation

public struct player{
    var cards: Array<poker>? = nil
    var name: String = "empty"
}

public struct poker{
    let suit: String
    let suitnum: Int
    let num: Int //num: 0=3 1=4 2=5 ... 8=J 9=Q 10=K 11=A 12=2
}

struct pokerClass{
    var cards=[poker]()
    var classing=Int()
    //同花順=7,四條=6,葫蘆=5,同花=4,順子=3,三條=2,一對=1,單張=0
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
    let pokernum=[2,3,4,5,6,6,6,6,2,2,7,8,9]//num: 0=3 1=4 2=5 ... 8=J 9=Q 10=K 11=A 12=2
    let pokersuit=[0,0,0,0,0,1,2,3,1,2,3,3,3]//♣0♦1♥2♠3
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
    print("suit:"+card.suit,", suitNum:"+String(card.suitnum),", number:"+temp)
}

public func PrintCards(cards:Array<poker>){
    for card in cards{
        PrintPoker(card: card)
    }
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

func ClassingPokers(origins:Array<poker>)->Array<pokerClass>?{
    var tmp=origins.sorted(by:PokerSuitCompare)
    var suitsCount = 0
    for ele in 1...tmp.count{
        if(tmp[ele-1].suitnum==tmp[ele].suitnum){
            suitsCount+=1
        }
        else{
            suitsCount=0
        }
        if(suitsCount>=4){
            
        }
    }
//    for element in stride(from: tmp.count-1, through: 0,by:-1){
//
//    }
    return nil
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
    case 1://contiune(norimal) play
        print("normail")
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
