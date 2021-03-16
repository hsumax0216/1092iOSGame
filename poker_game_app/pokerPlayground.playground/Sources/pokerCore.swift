import Foundation

public struct player{
    var cards: Array<poker>?
    let name: String
}

public struct poker{
    let suit: String
    let suitnum: Int
    let num: Int //num: 0=3 1=4 2=5 ... 8=J 9=Q 10=K 11=A 12=2
}

public func GeneratePokers()->Array<poker>{
    //♥♦♣♠
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

func ShufflePoker(arra:Array<poker>)->Array<poker>{
    let a=arra.shuffled()
    return a
}

let sample=["3","4","5","6","7","8","9","10","J","Q","K","A","2"]
func PrintPoker(card:poker){
    let temp = sample[card.num]
    print("suit:"+card.suit,", suitNum:"+String(card.suitnum),", number:"+temp)
}

func PrintCards(cards:Array<poker>){
    for card in cards{
        PrintPoker(card: card)
    }
}

func PokerCompare(this:poker,that:poker)->Bool{
    guard !(this.num==that.num) else {
        return this.suitnum < that.suitnum
    }
    return this.num < that.num
}

func ComputerPoker(cards:Array<poker>,desk:Array<poker>?,action:Int)->(Array<poker>,Array<poker>?){
    var rtn=[poker]()
    var last=[poker]()
    switch action {
    case 0://start play
        print("first start")
        var cardsCount=0
        for card in cards{
            
        }
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
    
    //var desk:player?
    while(false){
        let (_,last)=ComputerPoker(cards: simulatArray[currentPlay].cards!, desk: nil, action: 0)
        if(last==nil){
            winnerRank.append(simulatArray.remove(at:currentPlay).name)
        }
        simulatArray[currentPlay].cards=last!
        
        
        
        
        
        
        
        
        currentPlay=(currentPlay+1)%simulatArray.count
    }
    
    
}
