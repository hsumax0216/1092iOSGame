//
//  ContentView.swift
//  Yuanxiao_cai_dengmi
//
//  Created by 徐浩恩 on 2021/3/3.
//

import SwiftUI
var dengmis=[
    question(Ques:"長的少，短的多，腳去踩，手去摸(提示:日常用品)",Ans:"梯子"),
    question(Ques:"看看沒有，摸摸倒有，似冰不化，似水不流(提示:日常用品)",Ans:"鏡子"),
    question(Ques:"兩姐妹，一樣長，酸甜苦辣她先嚐(提示:日常用品)",Ans:"筷子"),
    question(Ques:"在家臉上白，出門臉上花，遠近都能到，一去不回家(提示:日常用品)",Ans:"信"),
    question(Ques:"身小力不小，團結又勤勞。有時搬糧食，有時挖地道。(提示:動物)",Ans:"螞蟻"),
    question(Ques:"說馬不像馬，路上沒有它。若用它做藥，要到海中抓。(提示:動物)",Ans:"海馬"),
    question(Ques:"黑臉包丞相，坐在大堂上。扯起八卦旗，專拿飛天將。(提示:動物)",Ans:"蜘蛛"),
    question(Ques:"吃進的是草，擠出的是寶。捨己為人類，功勞可不小(提示:動物)",Ans:"奶牛"),
    question(Ques:"百姐妹，千姐妹，同床睡，各蓋被(提示:水果)",Ans:"石榴"),
    question(Ques:"左手五個，左手五個。拿去十個，還剩十個(提示:日常用品)",Ans:"手套"),
    question(Ques:"一物生得巧，地位比人高。戴上御風寒，脫下有禮貌(提示:日常用品)",Ans:"帽子"),
    question(Ques:"屋裡一座亭，亭中有個人，天天盪鞦韆，不盪就有病(提示:日常用品)",Ans:"鐘擺"),
    question(Ques:"頭上亮光光，出門就成雙。背上縛繩子，馱人走四方(提示:日常用品)",Ans:"皮鞋"),
    question(Ques:"不是點心不是糖,軟軟涼涼肚裡藏,不能吃來不能喝,每天也要嘗一嘗(提示:日常用品)",Ans:"牙膏"),
    question(Ques:"樓台接樓台，一層一層接起來，上面冒白氣，下面水開花(提示:日常用品)",Ans:"蒸籠"),
    question(Ques:"一間小藥房，藥品裡面藏。房子塗白色，十字畫中央(提示:日常用品)",Ans:"醫藥箱"),
    question(Ques:"薄薄一張口，能啃硬骨頭。吃肉不喝湯，吃瓜不嚼豆(提示:日常用品)",Ans:"菜刀"),
    question(Ques:"有硬有軟，有長有寬。白天空閒，夜晚上班(提示:日常用品)",Ans:"床"),
    question(Ques:"遠看兩個零，近看兩個零。有人用了行不得，有人不用不得行(提示:日常用品)",Ans:"眼鏡"),
    question(Ques:"前面來只船，舵手在上邊，來時下小雨，走後路已乾(提示:日常用品)",Ans:"熨斗")
]
let constAns="隱藏答案"
let blankText=""
let playText="Play"
let displayText="Display Answer"
let nextText="Next"
let playAnginText="Play Angin"
struct ContentView: View {
    @State var QuesStr=blankText
    @State var AnsStr=blankText
    @State var Counts=blankText
    @State var buttonState=0
    @State var buttonLabel=playText
    @State var quesCount=0
    var body: some View {
        ZStack{
            Image("vector")
                .resizable()
                .scaledToFill()
                .frame(minWidth: 0,maxWidth: .infinity)
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            VStack (spacing:30){
                Text("\(Counts)")
                Text("\(QuesStr)")
                    .foregroundColor(Color.red)
                Text("\(AnsStr)")
                Button( action:{
                    if(buttonState==0){
                        QuesStr=dengmis[quesCount].Ques
                        AnsStr=constAns
                        buttonLabel=displayText
                        buttonState=1
                        quesCount+=1
                        Counts=String(quesCount)
                    }
                    else if(buttonState==1){
                        AnsStr=dengmis[quesCount].Ans
                        if(quesCount>=10){
                            buttonLabel=playAnginText
                            Counts=blankText
                            dengmis.shuffle()
                            quesCount=0
                        }
                        else{
                            buttonLabel=nextText
                            Counts=String(quesCount)
                        }
                        buttonState=0
                    }
                },label:{
                    Text("\(buttonLabel)")
                })
            }
            .onAppear(perform: {
                dengmis.shuffle()
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
