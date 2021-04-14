//
//  PlayPage.swift
//  gesture-alphabetGame
//
//  Created by 徐浩恩 on 2021/4/9.
//

import SwiftUI


class alphabet:ObservableObject{
    @Published var pos = [CGRect]()
    @Published var correct = [Bool]()
}

struct GamePage:View {
    @Binding var currentPage:Pages
    let color: [Color] = [.gray,.red,.orange,.yellow,.green,.purple,.pink]
    let timeMax:CGFloat = 600
    @State private var showScorePage:Bool = false
    //@State private var scorePageSelect:Int = 0
    @State         var username = String()
    @State private var vocabularyOrder = [Int]()
    @State private var fgColor: Color = .gray
    @State private var offset = [CGSize]()
    @State private var newPosition = [CGSize]()
    @State var ans = alphabet()//[CGRect]()
    @State var ques = alphabet()//[CGRect]()
    @State private var ansTextSize:CGFloat = 50
    @State private var quesTextSize:CGFloat = 60
    @State private var ansChars = [String]()
    @State private var quesChars = [String]()
    @State private var currentVoca = Vocabulary()
    @State private var roundChanging:Bool = false
    @State private var roundCount = Int()
    @State private var timer: Timer?
    @State         var timeClock = CGFloat()
//    var dragGesture: some Gesture {
//            DragGesture(coordinateSpace: .global)
//                .onChanged({ value in
//                   print(value.location)
//                   offset.width = newPosition.width + value.translation.width
//                   offset.height = newPosition.height + value.translation.height
//              })
//                .onEnded({ value in
//                    newPosition = offset
//                })
//        }
    func initialGame(){
        vocabularyOrder.removeAll()
        for i in 0...vocabularyDataSet.count-1{
            vocabularyOrder.append(i)
        }
        vocabularyOrder.shuffle()
        timeClock = timeMax
        roundCount = 0
        gamePlay()
        print("initialGame end")
    }
    
    func initialRound(){
        username = ""
        currentVoca = vocabularyDataSet[vocabularyOrder.removeLast()]
        vocabularyInit(voca:currentVoca.German)
    }
    
    func gamePlay(){
        if(vocabularyOrder.count<=0){
            //if()
//            print("game was finished. reseting...")
//            //this part will delete
//            initialGame()
            showScorePage = true
            return
        }
        nextRoundDelay()
        initialRound()
    }
    
    var body: some View{
        //let screenWidth:CGFloat = UIScreen.main.bounds.size.width
        ZStack{
            backGround()
            HStack{
                Button(action: {roundChanging = !roundChanging}, label: {
                    Text("Button")
                })
                Spacer()
                VStack(alignment:.trailing,spacing:10){
//                    ZStack{
//                        RoundedRectangle(cornerRadius: 100)
//                            .stroke(Color.red,lineWidth: 5)
//                            .frame(width: 50, height: 100)
//                            .overlay(Rectangle()
//                                        .fill(Color.yellow)
//                                        .frame(width: 50, height: 100*(timeClock/timeMax))
//                                        .cornerRadius(100))
//                    }
                    if(timeClock>0){
                        Rectangle()
                            .fill(Color.yellow)
                            .frame(width: 50, height: 100*(timeClock/timeMax))
                            .cornerRadius(10)
                            .clipped()
                            .padding(.top,100*(1 - timeClock/timeMax))
                            .overlay(rectOutsider)
                    }
                    else{
                        rectOutsider
                    }
                }
                .padding(.bottom,0)
            }
            if(roundChanging){
                Text("Round \(roundCount+0)")
                    .font(.system(size:100,design: .monospaced))
                    //.frame(height:200)
            }
            else{
                vocabularyImage
                VStack{
                    Button(action: {currentPage = Pages.HomePage}, label: {
                        Text("Button")
                    })
                    Spacer()
                    HStack(alignment: .center,spacing:15){
                        Group{
                            ForEach(quesChars.indices,id:\.self){
                                (index) in
                                Text("\(quesChars[index])"/*""*/)//alphabet background
                                    .font(.system(size:35,design: .monospaced))
                                    .foregroundColor(.blue)
                                    .frame(width: quesTextSize, height: quesTextSize)
                                    .background(Color.black)
                                    .cornerRadius(100)
                                    .overlay(RoundedRectangle(cornerRadius: 100)
                                                .stroke(Color.red,lineWidth: 5))
                                    .overlay(GeometryReader(content:{geometry in
                                        let _ = updatePos(geometry:geometry,ptr:&ques.pos[index])
                                        Color.clear
                                    }))
                                    .onTapGesture {
                                        print("quesPos[\(index)]:\(ques.pos[index])")
                                    }
                            }
                        }
                    }
                    .padding(.bottom)
                }
                VStack{
                    HStack(alignment: .center,spacing:15){
                        Group{
                            ForEach(ansChars.indices,id:\.self){
                                (index) in
                                Text("\(ansChars[index])")
                                    .font(.system(size:35,design: .monospaced))
                                    .foregroundColor(.blue)
                                    .frame(width: ansTextSize, height: ansTextSize)
                                    .background(fgColor)
                                    .cornerRadius(100)
                                    .overlay(RoundedRectangle(cornerRadius: 100)
                                                .stroke(Color.blue,lineWidth: 5))
                                    .overlay(GeometryReader(content:{geometry in
                                        let _ = updatePos(geometry:geometry,ptr:&ans.pos[index])
                                        Color.clear
                                    }))
                                    .onTapGesture {
                                        print("offset[\(index)]:\(offset[index])")
                                        print("newPosition[\(index)]:\(newPosition[index])")
                                        print("ansPos[\(index)]:\(ans.pos[index])")
                                        print("(\(ans.pos[index].origin.x-newPosition[index].width),\(ans.pos[index].origin.y-newPosition[index].height))")
                                        fgColor = color.randomElement()!
                                    }
                                    .offset(offset[index])
                                    .gesture(DragGesture()
                                                .onChanged({value in
                                                    if(ans.correct[index]){ return }
                                                    offset[index].width = value.translation.width + newPosition[index].width
                                                    offset[index].height = value.translation.height + newPosition[index].height
                                                    
                                                    //speakAlphabet(alpha: "")
                                                })
                                                .onEnded({ value in
                                                    if(ans.correct[index]){ return }
                                                    newPosition[index].width = offset[index].width
                                                    newPosition[index].height = offset[index].height
                                                    for i in 0...quesChars.count-1{
                                                        if(ansChars[index] == quesChars[i] && !ques.correct[i]){
                                                            if(cmpDistance(dic:(ansTextSize+quesTextSize)/2,A:ques.pos[i],Asize: quesTextSize,B:ans.pos[index],Bsize: ansTextSize)){
                                                                print("cmpDistance pass")
                                                                print("ques.pos[\(i)]:\(ques.pos[i].origin)")
                                                                print("ans.pos[\(index)]:\(ans.pos[index].origin)")
                                                                print("offset[\(index)]:\(offset[index])")
                                                                print("newPosition[\(index)]:\(newPosition[index])")
                                                                offset[index].width = ques.pos[i].origin.x - (ans.pos[index].origin.x-newPosition[index].width) + 5
                                                                offset[index].height = ques.pos[i].origin.y - (ans.pos[index].origin.y-newPosition[index].height) + 5
                                                                newPosition[index] = offset[index]
                                                                
                                                                ans.correct[index] = true
                                                                ques.correct[i] = true
                                                                break
                                                            }
                                                        }
                                                    }
                                                    if(!ans.correct[index]){
                                                        offset[index] = .zero
                                                        newPosition[index] = .zero
                                                    }
                                                    var pass = true
                                                    for i in ans.correct{
                                                        pass = pass && i
                                                        if(!pass){ break }
                                                    }
                                                    if(pass){
                                                        //TODO:next round
                                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                                                            gamePlay()
                                                        }
                                                    }
                                                    //TODO:判斷字母位置
                                                })
                                    )
                            }
                        }
                    }
                    .padding(.top,25)
                    Spacer()
                }
            }
        }
        .fullScreenCover(isPresented:$showScorePage,content:{
            if(scorePageSelect()){
                ScorePage
            }
            else{
                GameOverView
            }
        })
        .onAppear{
            initialGame()
        }
        .onDisappear{
            self.timer?.invalidate()
        }
//        .onAppear(perform:{initialGame()})
    }
}

extension GamePage{
    func cmpDistance(dic:CGFloat,A:CGRect,Asize:CGFloat,B:CGRect,Bsize:CGFloat)->Bool{
        let Dis = pow(dic,2)
        let aX:CGFloat = A.origin.x + Asize/2
        let aY:CGFloat = A.origin.y + Asize/2
        let bX:CGFloat = B.origin.x + Bsize/2
        let bY:CGFloat = B.origin.y + Bsize/2
        let tmp = pow(aX-bX,2)+pow(aY-bY,2)
        print("|A-B| = \(sqrt(tmp))")
        if(Dis > tmp){
            return true
        }
        return false
    }
    func scorePageSelect()->Bool{
        self.timer?.invalidate()
        if(vocabularyOrder.count <= 0 && timeClock>0){
            return true//scarepage
        }
        else{
            return false//gameoverview
        }
    }
    func vocabularyInit(voca:String){
        ansChars.removeAll()
        quesChars.removeAll()
        offset.removeAll()
        newPosition.removeAll()
        ans.correct.removeAll()
        ques.correct.removeAll()
        ans.pos.removeAll()
        ques.pos.removeAll()
        let n = voca.count
//        ans.chars = [String](repeating: "", count: n)
//        ques.chars = [String](repeating: "", count: n)
        offset = [CGSize](repeating: .zero, count: n)
        newPosition = [CGSize](repeating: .zero, count: n)
        ans.correct = [Bool](repeating: false, count: n)
        ques.correct = [Bool](repeating: false, count: n)
        ans.pos = [CGRect](repeating: .zero, count: n)
        ques.pos = [CGRect](repeating: .zero, count: n)
        let chars = Array(voca)
        let charSh = chars.shuffled()
        for i in charSh{ ansChars.append(String(i)) }
        for i in chars{ quesChars.append(String(i)) }
    }
    func updatePos(geometry:GeometryProxy,ptr:UnsafeMutablePointer<CGRect>){
        let pos = geometry.frame(in: .global)
        ptr.pointee = pos
    }
    func timerController(){
        if(!roundChanging){
            if(timeClock <= 0){
                self.timer?.invalidate()
                timeClock = 0
                return
            }
            self.timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { (_) in
                if(self.timeClock <= 0){
                    self.timeClock = 0
                    showScorePage = true
                    print("timer remove.")
                    return
                }
                self.timeClock -= 0.5
                print("self.timeClock:\(self.timeClock)")
            }
        }
        else{
            self.timer?.invalidate()
        }
    }
    func nextRoundDelay(){
        roundCount += 1
        print("roundCount:\(roundCount)")
        roundChanging = true
        timerController()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8){
            roundChanging = false
            timerController()
        }
    }
    func speakAlphabet(alpha:String){
        print("speak alphabet!!")
    }
    func imageExist(inName: String) -> Bool {
        if let _ = UIImage(named: inName) {
            return true
        }
        else {
            return false
        }
    }
    var rectOutsider:some View{
        RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.red,lineWidth: 5)
                    .frame(width: 50, height: 100)
    }
    var vocabularyImage:some View{
        Image(currentVoca.fileName == "" ? "default" : currentVoca.fileName)
            .resizable()
            //.background(Color.white)
            .scaledToFit()
            .frame(width: 230, height: 200, alignment: .center)
            .background(Color.white)
            .clipped()
            .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/,width: 1)
    }
}

struct GamePage_Previews: PreviewProvider {
    static var previews: some View {
        Landscape{
            GamePage(currentPage: .constant(Pages.GamePage))
        }
    }
}


