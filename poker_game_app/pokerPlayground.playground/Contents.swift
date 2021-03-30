var tmp = GeneratePokers().shuffled()
var j=0
while(j<4){
    var i=0
    while(i<13){
        print("\(tmp[i+j*13].num), ",terminator: "")
        i+=1
    }
    print("")
    i=0
    while(i<13){
        print("\(tmp[i+j*13].suitnum), ",terminator: "")
        i+=1
    }
    print("\n")
    j+=1
}



