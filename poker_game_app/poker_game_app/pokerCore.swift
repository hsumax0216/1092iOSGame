import Foundation

public struct player{
    public var cards: Array<poker>
    public var desk: pokerClass
    public var name: String
    public init(cards: Array<poker>,name: String){
        self.cards=cards
        self.desk=pokerClass()
        self.name=name
    }
    public init(desk:pokerClass,name: String){
        self.cards=[poker]()
        self.desk=desk
        self.name=name
    }
    public init(){
        self.cards=[poker]()
        self.desk=pokerClass()
        self.name="empty"
    }
}

public struct poker{
    public let suit: String
    public let suitnum: Int
    public let num: Int //num: 0=3 1=4 2=5 ... 8=J 9=Q 10=K 11=A 12=2
    public init(suit: String, suitnum: Int, num: Int){
        self.suit=suit
        self.num=num
        self.suitnum=suitnum
    }
    public init(){
        self.suitnum=0
        self.num=0
        self.suit="♣"
    }
}

public extension poker {
    static func == (left: poker, right: poker) -> Bool {
    return left.num==right.num && left.suitnum==right.suitnum
    }
    static func > (left: poker, right: poker) -> Bool {
        if(left.num==right.num){
            return left.suitnum>right.suitnum
        }
        return left.num>right.num
    }
    static func < (left: poker, right: poker) -> Bool {
        if(left.num==right.num){
            return left.suitnum<right.suitnum
        }
        return left.num<right.num
    }
}

public struct pokerClass{
    public var level: Int
    public var cards: Array<poker>
    public var classing: Int
    func isEmpty()->Bool{
        return (self.cards.isEmpty || self.classing == -1)
    }
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
    public init(){
        self.cards=[poker]()
        self.classing = -1
        self.level=0
    }
    //同花順=7,四條=6,葫蘆=5,同花=4,順子=3,三條=2,一對=1,單張=0
}

public extension pokerClass {
    static func == (left: pokerClass, right: pokerClass) -> Bool {
        return left.classing==right.classing && left.level==right.level
    }
    static func > (left: pokerClass, right: pokerClass) -> Bool{
        if(left.classing==right.classing){
            return left.level>right.level
        }
        return left.classing>right.classing
    }
    static func < (left: pokerClass, right: pokerClass) -> Bool{
        if(left.classing==right.classing){
            return left.level<right.level
        }
        return left.classing<right.classing
    }
}

func GeneratePokers()->Array<poker>{
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
    return arra.shuffled()
}

func fakeGeneratePokers()->Array<poker>{
    let cards=13
    var i=0
    let suits=["♣","♦","♥","♠"]
    let pokernum=[12,11,10,9,8,7,6,2,1,0,7,8,9]//num: 0=3 1=4 2=5 ... 8=J 9=Q 10=K 11=A 12=2
    let pokersuit=[0,0,1,1,1,1,1,0,0,0,3,3,3]//♣0♦1♥2♠3
//    let pokernum=[2,3,4,5,6,6,6,6,2,2,7,8,9]
//    let pokersuit=[0,0,0,0,0,1,2,3,1,2,3,3,3]
//    let  pokernum = [12,11,10, 9, 8, 7, 6, 5, 5, 5, 5, 4, 4]
//    let pokersuit = [ 3, 3, 3, 2, 1, 0, 3, 3, 2, 1, 0, 3, 2]
//    let  pokernum = [10, 8, 6, 4, 2, 1,12, 2, 1, 8, 2, 8, 2]
//    let pokersuit = [ 0, 0, 0, 0, 0, 0, 1, 1, 1, 2, 2, 3, 3]
    var arra=[poker]()
    while(i<cards){
        arra.append(poker(suit:suits[pokersuit[i]],suitnum: pokersuit[i],num:pokernum[i]))
        i+=1
    }
    _ = PrintCards(cards: arra)
    
    return arra
}

func fakeGeneratePokers(pokernum:Array<Int>,pokersuit:Array<Int>)->Array<poker>{
    let cards=pokernum.count
    var i=0
    let suits=["♣","♦","♥","♠"]
    var arra=[poker]()
    while(i<cards){
        arra.append(poker(suit:suits[pokersuit[i]],suitnum: pokersuit[i],num:pokernum[i]))
        i+=1
    }
    return arra
}

func ShufflePoker(arra:Array<poker>)->Array<poker>{
    let a=arra.shuffled()
    return a
}
let pokerSuitsSample=["clubs","diamonds","hearts","spades"]
let pokerSample=["3","4","5","6","7","8","9","10","jack","queen","king","ace","2"]
let sample=["3","4","5","6","7","8","9","10","J","Q","K","A","2"]
func PrintPoker(card:poker){
    let temp = sample[card.num]
    print("\(card.suit)\(temp) ",terminator: "")
}

func PrintCards(cards:Array<poker>)->Int{
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

func PrintPokerClass(clas:Array<pokerClass>){
    print("此人持有牌組：")
    var count=0
    var pokerC=0
    for set in clas{
        if(set.isEmpty()){
            print("空牌組\n")
            continue
        }
        print("\(pokerRank[set.classing]) : ",terminator: "")
        pokerC+=PrintCards(cards: set.cards)
        count+=1
    }
    print("共 \(count) 組牌組")
    print("共 \(pokerC) 張牌")
}
func PokerNumCompare(this:poker,that:poker)->Bool{
    guard !(this.num==that.num) else {
        return this.suitnum > that.suitnum
    }
    return this.num > that.num
}

func PokerSuitCompare(this:poker,that:poker)->Bool{
    guard !(this.suitnum==that.suitnum) else {
        return this.num > that.num
    }
    return this.suitnum > that.suitnum
}
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
let SHUNZISP=[[12,3,2,1,0],//2,6,5,4,3  //2,3,4,5,6
              [12,11,2,1,0]]//2,A,5,4,3 //A,2,3,4,5
func ClassingPokers(origins:Array<poker>)->Array<pokerClass>{
    var tmpSuit=origins.sorted(by:PokerSuitCompare)
    var pokersArray=[pokerClass]()
    var hulu=[pokerClass]()
    var suntiao=[pokerClass]()
    var yidui=[pokerClass]()
    var suitsCount = 0
    var ele = 1

    ele=0
    while(ele<tmpSuit.count && tmpSuit.count>4){
        if(ele<0){ ele=0 }
        var coun=ele
        let suitS=ele
        var suitE=suitS
        let suitreg=tmpSuit[suitS].suitnum
        while(coun<tmpSuit.count){
            if(!(tmpSuit[coun].suitnum==suitreg)){
                break
            }
            coun+=1
        }
        ele=coun
        suitE=coun-1
        if(suitE-suitS > 3){
            coun=suitS
            var cmp=0
            var breakloop=false
            while(coun<suitE-3){
                if(tmpSuit[coun].num==SHUNZI[cmp][0]){
                    var times=1
                    var loc=[Int]()
                    loc.append(coun)
                    var count = coun
                    while(count<=suitE && times<5){
                        if(tmpSuit[count].num==SHUNZI[cmp][times]){
                            times+=1
                            loc.append(count)
                        }
                        count+=1
                    }
                    if(times==5){//有同花順
                        let level=SHUNZI.count-cmp
                        loc.sort(by: >)
                        let ttmp=[tmpSuit[loc[0]],tmpSuit[loc[1]],tmpSuit[loc[2]],tmpSuit[loc[3]],tmpSuit[loc[4]]].sorted(by: PokerNumCompare)
                        pokersArray.append(pokerClass(cards: ttmp, classing: 7,level: level))
                        for _ in 0...4{ tmpSuit.remove(at: loc.removeFirst()) }
                        
                        ele-=5
                        cmp = 0
                        breakloop=true
                    }
                }
                if(breakloop){//已加同花順 需跳出迴圈 找下一個同花順
                    breakloop=false
                    break
                }
                if(cmp==SHUNZI.count-1){
                    coun += 1
                    cmp = -1
                }
                cmp+=1
            }
        }
    }
//    print("同花順篩選:")
//    _ = PrintCards(cards:tmpSuit)

    var tmpNum=tmpSuit.sorted(by:PokerNumCompare)
    ele = 1
    var numCount = 0
    while(ele<=tmpNum.count){
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
        }
        else if(numCount>=1){//一對ele-2...ele-1
            let ttmp=[tmpNum[ele-2],tmpNum[ele-1]]
            yidui.append(pokerClass(cards: ttmp, classing: 1))
            for _ in 0...1{ tmpNum.remove(at: ele-2) }//在剩下牌堆中刪除一對組合
            numCount=0
            ele-=2
        }
        
        if(numCount>=3){//四條ele-3...ele
            let ttmp=[tmpNum[ele-3],tmpNum[ele-2],tmpNum[ele-1],tmpNum[ele]]
            pokersArray.append(pokerClass(cards: ttmp, classing: 6))
            for _ in 0...3{ tmpNum.remove(at: ele-3) }//在剩下牌堆中刪除四條組合
            numCount=0
            ele-=4
        }
        ele+=1
    }
//    print("四條三條一對篩選:")
//    _ = PrintCards(cards:tmpNum)

    let sun_duiCount = suntiao.count < yidui.count ? suntiao.count : yidui.count
    var coun = 0
    while(coun<sun_duiCount){//三條一對 轉 葫蘆
        let ttmp = (suntiao[0].cards+yidui[0].cards).sorted(by: PokerNumCompare)
        hulu.append(pokerClass(cards: ttmp, classing: 5))
        suntiao.removeFirst()
        yidui.removeFirst()
        coun+=1
    }
    if(hulu.count > 0){ pokersArray+=hulu }
//    print("\n葫蘆篩選:")
//    _ = PrintCards(cards:tmpNum)


    tmpNum.sort(by:PokerSuitCompare)
    ele=1
    suitsCount=0
    while(ele<tmpNum.count && tmpNum.count>4){
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
        }
        ele+=1
    }
    tmpNum.sort(by:PokerNumCompare)
//    print("\n同花篩選:")
//    _ = PrintCards(cards:tmpNum)

    ele = 0
    var cmp=0
    while(ele<tmpNum.count && tmpNum.count > 4){
        if(tmpNum[ele].num==SHUNZI[cmp][0]){
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
                let ttmp=[tmpNum[loc[0]],tmpNum[loc[1]],tmpNum[loc[2]],tmpNum[loc[3]],tmpNum[loc[4]]].sorted(by: PokerNumCompare)
                pokersArray.append(pokerClass(cards: ttmp, classing: 3,level: level))
                for _ in 0...4{ tmpNum.remove(at: loc.removeFirst()) }
            }
        }
        else{
            cmp+=1
            if(cmp>=SHUNZI.count){
                cmp = 0
                ele += 1
            }
            continue
        }
        ele+=1
    }
//    print("\n順子篩選:")
//    _ = PrintCards(cards:tmpNum)

    if(suntiao.count>0){ pokersArray+=suntiao }

    if(yidui.count>0){ pokersArray+=yidui }

    //單張
    while(tmpNum.count>0){
        pokersArray.append(pokerClass(cards: [tmpNum.removeFirst()], classing: 0))
    }
//    print("\n單張篩選:")
//    _ = PrintCards(cards:tmpNum)
    return pokersArray
}

func ComputerPoker(cards:Array<poker>,desk:pokerClass,action:Int)->(pokerClass,Array<poker>){
    var rtn=pokerClass()
    var last=cards
    let tmp=ClassingPokers(origins: cards).sorted(by: <)
    switch action {
    case 0://start play with ♣3
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
            if(pass){
                rtn=tmp[i]
                break
            }
            i+=1
        }
        
    case 1://start without ♣3
        rtn=tmp.last!
    case 2://contiune(normial) play
        var i=0
        var paied=false
        while(i<tmp.count){
            let tmpI=tmp[i].cards.sorted(by: <)
            let deskJ=desk.cards.sorted(by: <)
            if(desk.classing>2){
                //TODO 順子 同花 葫蘆 四條 同花順
                if(tmp[i].classing>desk.classing){
                    paied=true
                }
                else if(tmp[i].classing==desk.classing){
                    switch desk.classing {
                    case 7,3://順子 同花順
                        if(tmp[i].level>desk.level){
                            paied=true
                        }
                        else if(tmp[i].level==desk.level){
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
                    default:
                        print("default")
                    }
                }
            }
            else{
                if(tmp[i].classing==desk.classing){
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
    return (rtn,last)
}

func assignPoker(DECK:Array<poker>)->(Array<player>,Int){
    let peoples=4
    var plr=[poker]()
    var comp=[Array<poker>]()
    var i=0,j=0,compCount=peoples-1
    let deck=DECK//.shuffled()
    let perCards=Int(52/peoples)
    var firstPrior = 0//Int.random(in: 0...peoples-1)
    
    while(j<perCards){
        plr.append(poker(suit: deck[j].suit, suitnum: deck[j].suitnum, num: deck[j].num))
        if(deck[j].suitnum==0 && deck[j].num==0){
            firstPrior = 0
        }
        j+=1
    }
    while(i<compCount){
        var temp=[poker]()
        var times=0
        while(times<perCards){
            temp.append(poker(suit: deck[j].suit, suitnum: deck[j].suitnum, num: deck[j].num))
            if(deck[j].suitnum==0 && deck[j].num==0){
                firstPrior = i+1
            }
            j+=1
            times+=1
        }
        comp.append(temp)
        i+=1
    }
    
    var simulatArray=[player]()
    simulatArray.append(player(cards: plr.sorted(by: >), name: "Human"))
    var ppp=0
    while(ppp<compCount){
        simulatArray.append(player(cards: comp[ppp].sorted(by: >), name: "Computer "+String(ppp+1)))
        ppp+=1
    }
    return (simulatArray,firstPrior)
}
