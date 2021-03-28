//
//  testground.swift
//  poker_game_app
//
//  Created by 徐浩恩 on 2021/3/23.
//

import Foundation

public func testfunc(){
    print("testing")
    /*ClassingPokers test begin*/
    //var samp=fakeGeneratePokers()
    //samp.sort(by:PokerSuitCompare)
    //print("After Suit Sort:")
    //PrintCards(cards:samp)
    //samp.sort(by:PokerNumCompare)
    //print("After Num Sort:")
    //PrintCards(cards:samp)
    //
    //
    //let tmp=ClassingPokers(origins:samp)
    //PrintPokerClass(clas:tmp)
    /*ClassingPokers test end*/


    /*ComputerPoker test begin*/

    var simp=fakeGeneratePokers(pokernum:[6,5,6,5,12,11,5,4,10,9,8,7,6],pokersuit:[3,3,2,2,1,1,1,1,0,0,0,0,0])
    print("simp After Suit Sort:")
    PrintCards(cards:simp)
    simp.sort(by:PokerNumCompare)
    print("simp After Num Sort:")
    PrintCards(cards:simp)
    let simpClass=ClassingPokers(origins: simp).sorted(by: <)
    print("\n\nsimpClass passed\n")


    var samp=fakeGeneratePokers()
    samp.sort(by:PokerSuitCompare)
    print("samp After Suit Sort:")
    PrintCards(cards:samp)
    samp.sort(by:PokerNumCompare)
    print("samp After Num Sort:")
    PrintCards(cards:samp)


    let testD=pokerClass()


    let cards=samp
    let desk:pokerClass?=simpClass.last!
    print("\ndesk:")
    PrintPokerClass(clas: [desk!])
    print("")
    let action=2


    var rtn=pokerClass()
    var last=cards
    let tmp=ClassingPokers(origins: cards).sorted(by: <)

    /*print*/
    PrintPokerClass(clas:tmp)
    print("")
    /*print*/

    switch action {
    case 0://start play with ♣3//cards must be have ♣3
        print("first start:")
    //        let tmp=ClassingPokers(origins: cards).sorted(by: <)
        var i=0
        while(i<tmp.count){
            var j=0
            var pass=false
            while(j<tmp[i].cards.count){
                if(tmp[i].cards[j].num==0 && tmp[i].cards[j].suitnum==0){
                    pass=true
                    break
                }
                j+=1
            }
            if(pass){ break }
            i+=1
        }
        rtn=tmp[i]
    //        i=0
    //        while(i<rtn.cards.count){
    //            var j=0
    //            var pass=false
    //            while(j<last.count){
    //                if(last[j]==rtn.cards[i]){
    //                    last.remove(at: j)
    //                    pass=true
    //                    break
    //                }
    //                if(pass){break}
    //                j+=1
    //            }
    //            i+=1
    //        }
        
    case 1://start without ♣3
        print("start play")
    //        let tmp=ClassingPokers(origins: cards).sorted(by: <)
        rtn=tmp.last!
    case 2://contiune(normial) play
        print("normial")
    //        let tmp=ClassingPokers(origins: cards).sorted(by: <)
        var i=0
        var paied=false
        while(i<tmp.count){
            let tmpI=tmp[i].cards.sorted(by: <)
            let deskJ=desk!.cards.sorted(by: <)
            if(desk!.classing>2){
                //TODO 順子 同花 葫蘆 四條 同花順
                if(tmp[i].classing>desk!.classing){
                    //TODO
                    paied=true
                }
                else if(tmp[i].classing==desk!.classing){
                    //TODO
                    switch desk!.classing {
                    case 7,3://順子 同花順
                        if(tmp[i].level>desk!.level){
                            paied=true
                        }
                        else if(tmp[i].level==desk!.level){
                            if(tmpI[0].suitnum > deskJ[0].suitnum){
                                paied=true
                            }
                        }
                    case 6://四條
                        if(tmpI.last! > deskJ.last!){
                            paied=true
                        }
                    case 5://葫蘆
                        var j=0,coun=0
                        var tmpD=poker(),tmpT=poker()
                        while(j<4){
                            j+=1
                            if(deskJ[j].num==deskJ[j-1].num){
                                coun+=1
                            }
                            if(coun<j && j==3){
                                tmpD=deskJ[2]
                                break
                            }
                            else{
                                tmpD=deskJ[3]
                                break
                            }
                        }
                        j=1
                        coun=0
                        while(j<4){
                            j+=1
                            if(tmpI[j].num==tmpI[j-1].num){
                                coun+=1
                            }
                            if(coun<j && j==3){
                                tmpT=tmpI[2]
                                break
                            }
                            else{
                                tmpT=tmpI[3]
                                break
                            }
                        }
                        if(tmpT>tmpD){
                            paied=true
                        }
                        print("")
                    case 4://同花
                        var j=0
                        while(j<deskJ.count){
                            if(tmpI[j].num==deskJ[j].num){
                                j+=1
                                continue
                            }
                            break
                        }
                        if(j==deskJ.count){
                            if(tmpI[j].suitnum>deskJ[j].suitnum){
                                paied=true
                            }
                        }
                        else{
                            if(tmpI[j].num>deskJ[j].num){
                                paied=true
                            }
                        }
                        print("")
                    default:
                        print("default")
                    }
                }
            }
            else{
                if(tmp[i].classing==desk!.classing){
                    //TODO 單張 一對 三條
                    if(tmpI.last! > deskJ.last!){
                        paied=true
                    }
                }
            }
            if(paied){ break }
            i+=1
        }
        if(paied){
            rtn=tmp[i]
            
        }
        
    default:
        print("ComputerPoker occur error!")
    }

    /*於last(cards)中刪除含rtn之元素 begin*/
    var i=0
    while(i<rtn.cards.count){
        var j=0
        var pass=false
        while(j<last.count){
            if(last[j]==rtn.cards[i]){
                last.remove(at: j)
                pass=true
                break
            }
            if(pass){break}
            j+=1
        }
        i+=1
    }
    /*於last(cards)中刪除含rtn之元素end*/

    print("rtn : ")
    PrintPokerClass(clas:[rtn])
    print("last : ",terminator: "")
    PrintCards(cards: last)


    PrintPokerClass(clas:[rtn])
    PrintCards(cards:last)

    /*ComputerPoker test end*/

    print("testing")


}
