//
//  pokerCore.swift
//  poker_game_app
//
//  Created by 徐浩恩 on 2021/3/15.
//

import Foundation

//struct player{
//    var pokers: Array<poker>
//}

struct poker{
    let suit: String
    let suitnum: Int
    let num: Int //num: 0=3 1=4 2=5 ... 8=J 9=Q 10=K 11=A 12=2
}

func GeneratePokers()->Array<poker>{
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

func GamePlay(DECK:Array<poker>,peoples:Int){
    print("In GamePlay.")
    guard peoples>1 && peoples<13 && ((peoples%2) == 0) else{
        print("The numbers of player out of setting.")
        return
    }
    var plr=[poker]()
    var comp=[Array<poker>]()
    var i=0,j=0,compCount=peoples-1
    let deck=DECK.shuffled()
    let perCards=Int(52/peoples)
    print("perCards:"+String(perCards))
    while(j<perCards){
        plr.append(poker(suit: deck[j].suit, suitnum: deck[j].suitnum, num: deck[j].num))
        j+=1
    }
    plr.sort(by:PokerCompare)
    while(i<compCount){
        var temp=[poker]()
        var times=0
        while(times<perCards){
            temp.append(poker(suit: deck[j].suit, suitnum: deck[j].suitnum, num: deck[j].num))
            j+=1
            times+=1
        }
        comp.append(temp)
        i+=1
    }
//    print("Player:")
//    PrintCards(cards: plr)
//    i=0
//    while(i<compCount){
//        print("\nComputer "+String(i+1)+":")
//        PrintCards(cards: comp[i])
//        i+=1
//    }
    
    
    
}
