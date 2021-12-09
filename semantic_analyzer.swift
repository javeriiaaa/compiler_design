

import Foundation

struct DataEntries{
    var name: String
    var type: String
    var AM: String
    var TM: String
}
class ClassTable{
    var DTs: [DataEntries]?
    init() {
    }
    init(DTs: [DataEntries]){
        self.DTs=DTs
    }
//    init(DTs: [DataEntries]) {
//        self.DTs=DTs
//    }
    func Addvar(v: DataEntries, N: String)->Bool{
        var idk=false
        if ((DTs?.contains(where: {$0.name==N})) != nil){
        print("Redeclaration of \(N)")
        }
        else{
            DTs!.append(v)
            idk=true
        }
        return idk
    }
    func Addfunc(fn: DataEntries, N: String, T: String)->Bool{
        var idk=false
        let abc=DTs!.first(where: {$0.name==N})
        if abc?.type==T{
            print("redeclaration of \(N)")
        }
        else {
            DTs!.append(fn)
            idk=true
        }
        return idk
    }
    
  
    
}

//func getFuncPL(PL: String)->String{
//
//}
class MainTable{
    var name: String?
    var type: String?
    var AM: String?
    var CAT: String?
    var Par: String?
    var link: ClassTable?
    
//    init() {
//    }
    
    init(N:String, T:String, AM:String, CAT:String, Par:String, Ref:ClassTable=ClassTable()){
        self.name=N
        self.type=T
        self.AM=AM
        self.CAT=CAT
        self.Par=Par
        self.link=Ref
    }
}



struct funcTable{
    static var sc=0
    var name: String
    var type: String
    var scope: Int
}

struct Symbol{
    let symName:String
    let symType:String
    let scope: Int
}
struct GlobalTable{
    let symbol:String
    let T:String
    let scope: Int
}
var GlobalSyms:[GlobalTable]=[]
func insertGlobal(N: String, T: String, Sc: Int)-> Bool{
    var idk=false
    if(!GlobalSyms.contains(where: {$0.symbol==N})){
        let newsymb=GlobalTable(symbol: N, T: T, scope: Sc)
        GlobalSyms.append(newsymb)
        idk=true
    }
    return idk
    
}
struct Stack {
   var myArray: [Int] = []
    
    mutating func push(_ element: Int) {
        myArray.append(element)
    }
    
    mutating func pop() -> Int? {
        return myArray.popLast()
    }
    
    func peek() -> Int {
        guard let topElement = myArray.last else {return 0}
        return topElement
    }
}
var stack=Stack()
public var sc=0
func CreateScope(){
    sc+=1
    stack.push(sc)
}
func destroyScope(){
    stack.pop()
    sc=sc-1
}



var BTs=[ClassTable]()
var MTs=[MainTable]()
var func_symbols: [funcTable] = []
var syms:[Symbol]=[]

//func createCT(N: String, T: String, AM: String, TM: String) -> Bool{
//    var idk=false
//    if (!MTs.contains(where: {$0.name == N} )){
//        idk=true
//    }
//    return idk
//}


func insert_MT(N: String, T: String, AM: String, Cat: String, Par: String, link: ClassTable) -> Bool{
    var idk=false
    if(!MTs.contains(where: {$0.name == N})){
        let m1=MainTable(N: N, T: T, AM: AM, CAT: Cat, Par: Par, Ref: link)
        m1.link=link
        MTs.append(m1)
        idk=true
    }
    else{
        print("Redeclaration of \(N)")
    }
    return idk
}



func insert_FT(N: String, T:String, SC: Int) -> Bool {
    var idk=false
    if(!func_symbols.contains(where: {$0.name==N && $0.scope==SC})){
        let sym=funcTable(name: N, type: T, scope: SC)
        func_symbols.append(sym)
        idk=true
    }
    else{
        print("redeclaration of \(N)")
    }
    return idk
}
//var obj=ClassTable()
//insert_MT(N: "dUMMY", T: "-", AM: "-", Cat: "-", Par: "-", link: obj)
//BTs.append(obj)
//MTs
//BTs
func insertDT_v(N: String, T: String, AM: String, TM: String, link: ClassTable)->Bool{
    var idk=false
    if ((link.DTs?.first(where: {$0.name==N})) != nil){
        print("invalid redeclaration of \(N)")
    }
    else {
        let v=DataEntries(name: N, type: T, AM: AM, TM: TM)
        link.DTs?.append(v)
        idk=true
    }

    return idk
}
//print("hi")
//var funcs=[DataEntries]()
//let fn=DataEntries(name: "Myfunc", type: "Int", AM: "Def", TM: "None")
//funcs.append(fn)
//bc.Addfunc(fn: fn, N: "fn", T: "Int")
//let bc=ClassTable(DTs: funcs)
//insertDT_v(N: "v1", T: "Int", AM: "idk", TM: "-", link: bc)
//insertDT_v(N: "v1", T: "Int", AM: "idk", TM: "-", link: bc)
//insert_MT(N: "Class", T: "", AM: "", Cat: "", Par: "", link: bc)
//bc.DTs
func insertDT_f(N: String, T: String, AM: String, TM: String, link: ClassTable)->Bool{
    var idk=false
    let abc=link.DTs?.first(where: {$0.name==N})
    if abc?.type==T{
        print("invalid redeclaration of \(N)")
    }
    else {
        let f=DataEntries(name: N, type: T, AM: AM, TM: TM)
        link.DTs?.append(f)
        idk=true
    }

    return idk
}
//insertDT_f(N: "heyy", T: "int", AM: "Def", TM: "None", link: bc)
//bc.DTs
//insertDT_f(N: "heyy", T: "int", AM: "Def", TM: "None", link: bc)
//BTs.append(bc)
//func Lookup_fn_dt(N: String, PL: String, link: ClassTable)->Bool{
//
////}


//func Lookup_MT(N: String)->(Cat: String, Type: String){
//    var idk=false
//    if MTs.contains(where: <#T##(MainTable) throws -> Bool#>)
//    return (Cat, Type)
//}
func typeLookupMT(N: String)->(cat: String, Par: String, Type: String, ref: ClassTable){
    var cat=""
    var Par=""
    var Type=""
    var ref = ClassTable()
//    var link = ClassTable()
    if MTs.contains(where: {$0.name==N}){
        let abc = MTs.first(where: {$0.name==N})
        cat.append((abc?.CAT)!)
        Par.append((abc?.Par)!)
        Type.append((abc?.type!)!)
        ref=(abc?.link)!
//        link=abc!.link ?? nil
    }
    else{
        print("no such class: \(N) found")
    }
    return (cat, Par, Type, ref)
}
//insert_MT(N: "Myclass", T: "Class", AM: "default", Cat: "final", Par: "None", link: bc)
//typeLookupMT(N: "Myclass")
//MTs


func TypeLookup_att_DT(N: String, ref: ClassTable)->(AM: String, TM: String, Type: String){
//    let abc=MTs.first(where: {$0.name==N})
    var TM:String=""
    var AM:String=""
    var Type:String=""
        let a=ref.DTs?.contains(where: {$0.name==N})
        if a==true{
            let ab=ref.DTs?.first(where: {$0.name==N})
            AM=ab!.AM
            TM=ab!.TM
            Type=ab!.type
            
        }
        else{
            print("\(N) is undefined")
        }
    
    
    return(AM, TM, Type)
}
//let idk=TypeLookup_att_DT(N: "idk", ref: bc)
//if idk.AM==""{
//    print("no such var in classtable")
//}
//BTs.append(bc)
//for bts in BTs{
//    print(bts.DTs)
//}

func getParams(T: String) -> String{
    var t=""
    if T.contains(">") && (T[T.startIndex] != "-"){
    guard let index=T.firstIndex(of: ">") else { return "" }
    let range = str.startIndex..<str.index(before: index)
    t=String(T[range])
    }
    else{
    }
//    }
    return t
}
func getFuncType(T: String) -> String{
    var t=""
    if T.contains(">"){
    guard let index=T.firstIndex(of: ">") else { return "" }
    let range = T.index(after: index)..<T.endIndex
    t=String(T[range])
    }
    else {
        t=T
    }
//    print(t)
//    }
    return t
}

//let T="->Int"
//getFuncType(T: T)
//getParams(T: T)

func TypeLookup_fn_DT(N: String, T: String, ref: ClassTable)->(T: String, AM: String, TM: String){
    var tm:String=""
    var am:String=""
    var t:String=""
    let a=ref.DTs?.first(where: {$0.name==N})
    if a?.type==T{
        am=a!.AM
        tm=a!.TM
        t=a!.type
    }
    else{
        print("There is no such \(N) function in this class")
    }
//    for dts in dataentries{
//
//    }
return(t, am, tm)
}
func comp_check(leftType: String, rightType: String)-> Bool{
    var idk=false
    var finalType=""
    if leftType==rightType{
        idk=true
    }
    else{
        print("type mismatch error")
    }
    return idk
}
//insertDT_f(N: "s", T: "String", AM: "Priv", TM: "static", link: bc)
//bc.DTs
//TypeLookup_fn_DT(N: "s", T: "String", ref: bc)


func lookup_FT(N: String)->(Type: String, SC: Int){
//    var n:String=""
    var type:String=""
    var sc:Int=0
    var i=1
    let a = func_symbols.contains(where: {$0.name==N})
    if a == true{
        let b = func_symbols.last(where: {$0.name==N})
        if stack.myArray.contains(b!.scope){
            type=b!.type
            sc=b!.scope
        }
    }
    else{
        print("undefined variable: \(N)")
    }
        
    return (type,sc)
}
func removeFromFT(scp: Int){
    func_symbols.removeAll(where: {$0.scope==scp})
}
//CreateScope()
//insert_FT(N: "my_var", T: "Int", SC: sc)
//stack.peek()
//destroyScope()
//lookup_FT(N: "my_var")
//stack.peek()
//sc
//func_symbols

//func resultTypeCompatibility()
//func printme(){
//    let name: String
//    name="my name is"
//    func printmyname(name: inout String){
//        name.append("jiya")
//    }
//}
//printme()
var i = 0;

func Prog()->Bool{
    var idk=false
    var gtdts=[DataEntries]()
    let gt=ClassTable(DTs: gtdts)
    BTs.append(gt)
    insert_MT(N: "GlobalTable", T: "Global", AM: "None", Cat: "Default", Par: "-", link: gt)
    CreateScope()
    if tokens[i].Class=="LET" || tokens[i].Class=="VAR" || tokens[i].Class=="ID" || tokens[i].Class=="AF" || tokens[i].Class=="AM" || tokens[i].Class=="CLASS" || tokens[i].Class=="FUNC" || tokens[i].Class=="DO" || tokens[i].Class=="WHILE" || tokens[i].Class=="IF" || tokens[i].Class=="FOR" || tokens[i].Class=="TRY" || tokens[i].Class=="SWITCH"{
        if(SST(ref: gt)){
            if(SSTs(ref: gt)){
                idk=true
            }
        }
    }
    return idk
}
func s3lf()->Bool{
    var idk=false
    if tokens[i].Class=="SELF"{
        i+=1
        if tokens[i].Class=="DotOp"{
            i+=1
            if tokens[i].Class=="ID"{
                i+=1
                if tokens[i].Class=="AS"{
                    i+=1
                    if tokens[i].Class=="ID"{
                        i+=1
                        if tokens[i].Class==";"{
                            i+=1
                            if s3lf(){
                                idk=true
                            }
                        }
                    }
                }
            }
        }
    }
    else if tokens[i].Class=="}"{
        idk=true
    }
    return idk
}
func init_construct()->Bool{
    var idk=false
    var T=""
    if tokens[i].Class=="INIT"{
        i+=1
        if tokens[i].Class=="("{
            i+=1
        if params(T: &T){
            if tokens[i].Class==")"{
                i+=1
                if tokens[i].Class=="{"{
                    i+=1
                    if s3lf(){
                        if tokens[i].Class=="}"{
                            i+=1
                            idk=true
                        }
                    }
                }
            }
        }
    }
    }
    return idk
}
func cond(T: inout String)->Bool{
    var idk=false
    if tokens[i].Class=="ID" || tokens[i].Class=="int_const" || tokens[i].Class=="string_const" || tokens[i].Class=="char_const" || tokens[i].Class=="bool_const" || tokens[i].Class=="float_const"{
        if ID_const(T: &T){
            if(cond2(T: &T)){
                if comp_check(leftType: T, rightType: T){
                    idk=true
                }
                
            }
        }
        
    }
    return idk
}
func cond2(T: inout String)->Bool{
    var idk=false
    if tokens[i].Class=="ROP"{
        i+=1
        if tokens[i].Class=="ID" || tokens[i].Class=="int_const" || tokens[i].Class=="string_const" || tokens[i].Class=="char_const" || tokens[i].Class=="bool_const" || tokens[i].Class=="float_const"{
            if ID_const(T: &T){
//                i+=1
                idk=true
            }
        }
    }
    else if tokens[i].Class==")"{
        idk=true
    }
    return idk
}
func MST(ref: ClassTable)->Bool{
    var idk=false
    if tokens[i].Class=="LET" || tokens[i].Class=="VAR" || tokens[i].Class=="ID" || tokens[i].Class=="AF" || tokens[i].Class=="AM" || tokens[i].Class=="CLASS" || tokens[i].Class=="FUNC" || tokens[i].Class=="DO" || tokens[i].Class=="WHILE" || tokens[i].Class=="IF" || tokens[i].Class=="FOR" || tokens[i].Class=="TRY" || tokens[i].Class=="SWITCH"{
        if(SST(ref: ref)){
            if(MST(ref: ref)){
                idk=true
            }
        }
    }
    else if tokens[i].Class=="}"{
        idk=true
    }
    else if tokens[i].Class=="RETURN"{
        idk=true
    }
    return idk
}

func if_else_body(ref: ClassTable)->Bool{
    var idk=false
    if tokens[i].Class=="LET" || tokens[i].Class=="VAR" || tokens[i].Class=="ID" || tokens[i].Class=="AF" || tokens[i].Class=="AM" || tokens[i].Class=="CLASS" || tokens[i].Class=="FUNC" || tokens[i].Class=="DO" || tokens[i].Class=="WHILE" || tokens[i].Class=="IF" || tokens[i].Class=="FOR" || tokens[i].Class=="TRY" || tokens[i].Class=="SWITCH"{
        if(MST(ref: ref)){
                idk=true
            }
        
    }
    else if tokens[i].Class=="}"{
        idk=true
    }
    return idk
}
func o_else(ref: ClassTable)->Bool{
    var idk=false
    if tokens[i].Class=="ELSE"{
        i+=1
        if tokens[i].Class=="{"{
            i+=1
            if(MST(ref: ref)){
                if tokens[i].Class=="}"{
                    i+=1
                    idk=true
                }
            }
        }
    }
    else if tokens[i].Class=="$" || tokens[i].Class=="LET" || tokens[i].Class=="VAR" || tokens[i].Class=="ID" || tokens[i].Class=="AF" || tokens[i].Class=="AM" || tokens[i].Class=="CLASS" || tokens[i].Class=="FUNC" || tokens[i].Class=="DO" || tokens[i].Class=="WHILE" || tokens[i].Class=="IF" || tokens[i].Class=="FOR" || tokens[i].Class=="TRY" || tokens[i].Class=="SWITCH" {
        idk=true
        
    }
    return idk
}
func body(ref: ClassTable)->Bool{
    var idk=false
    if tokens[i].Class==";"{
        idk=true
    }
    else if tokens[i].Class=="LET" || tokens[i].Class=="VAR" || tokens[i].Class=="ID" || tokens[i].Class=="AF" || tokens[i].Class=="AM" || tokens[i].Class=="CLASS" || tokens[i].Class=="FUNC" || tokens[i].Class=="DO" || tokens[i].Class=="WHILE" || tokens[i].Class=="IF" || tokens[i].Class=="FOR" || tokens[i].Class=="TRY" || tokens[i].Class=="SWITCH"{
        if(SST(ref: ref)){
            idk=true
        }
    }
    else if tokens[i].Class=="{"{
        CreateScope()
        i+=1
        if(MST(ref: ref)){
            i+=1
            if tokens[i].Class=="}"{
                destroyScope()
                i+=1
                idk=true
            }
           
        }
    }
    return idk
}
  

func IC()->Bool{
    var idk=false
    if tokens[i].Class=="ID"{
        let N=tokens[i].value
        let a=lookup_FT(N: N)
        if a.Type=="Int"{
        i+=1
        idk=true
    }
    }
    else if tokens[i].Class=="int_const"{
        i+=1
        idk=true
    }
    return idk
}
func two_d()->Bool{
    var idk=false
    if tokens[i].Class=="["{
        i+=1
        if IC(){
            if tokens[i].Class=="]"{
                i+=1
                idk=true
            }
            }
        }
    else if tokens[i].Class=="DotOp" || tokens[i].Class=="AS" || tokens[i].Class=="ASE"{
        idk=true
    }
    return idk
}
func Arr()->Bool{
    var idk=false
    if tokens[i].Class=="["{
        i+=1
        if IC(){
            if tokens[i].Class=="]"{
                i+=1
                if two_d(){
                    idk=true
                }
                
            }
        }
    }
    return idk
}
func Fol2()->Bool{
    var idk=false
    if tokens[i].Class=="["{
        if Arr(){
            idk=true
        }
    }
    else if tokens[i].Class=="DotOp" || tokens[i].Class=="AS" || tokens[i].Class=="ASE"{
        idk=true
    }
    return idk
}
func DOP2()->Bool{
    var idk=false
    if tokens[i].Class=="DotOp" {
        i+=1
        if Fol1(){
            idk=true
        }
    }
    else if tokens[i].Class=="AS" || tokens[i].Class=="ASE"{
        idk=true
    }
    return idk
}
//func Par2(T: inout String)->Bool{
//            var idk=false
//            var N=""
//            var Ty=""
//            if tokens[i].Class==","{
//                i+=1
//                if tokens[i].Class=="ID"{
//                    N.append(tokens[i].value)
//                    i+=1
//                    if tokens[i].Class==":"{
//                        i+=1
//                        if tokens[i].Class=="DT"{
//                            Ty.append(tokens[i].value)
//                            T.append(tokens[i].value)
//                            let sym2=Symbol(symName: N, symType: Ty, scope: sc)
//                            syms.append(sym2)
//                            i+=1
//                            if(Par2(T: &T)){
//                                idk=true
//                            }
//                        }
//                    }
//                }
//            }
//            else if tokens[i].Class==")"{
//                T="None"
//                idk=true
//            }
//
//
//
//            return idk
//        }
//
//        func Par(syms: inout [Symbol], T: inout String)->Bool{
//            var idk=false
//            if tokens[i].Class=="ID"{
//                CreateScope()
//                let N=tokens[i].value
//                var Ty=""
//                i+=1
//                if(tokens[i].Class==":"){
//                    i+=1
//                    if tokens[i].Class=="DT"{
//                        T.append(tokens[i].value)
//                        Ty.append(tokens[i].value)
//                        let sym1=Symbol(symName: N, symType: Ty, scope: sc)
//                        syms.append(sym1)
//                        i+=1
//                        if(Par2(T: &T)){
//                            if let ck=BTs.enumerated().first(where: {$0.element.name=="N"}){
//                                if ck.element.type==T{
//                                    idk=true
//                                }
//                            }
//                            else{
//                                print("function redeclaration")
//                                idk=false
//                            }
//
//                        }
//                    }
//
//                }
//                ///Scope
//            }
//            else if tokens[i].Class==")"{
//                idk=true
//            }
//            return idk
//

func Par2(T: inout String)->Bool{
    var idk=false
    if tokens[i].Class==","{
        var N=""
        var Type=""
//        T.append(tokens[i].value)
        i+=1
        if tokens[i].Class=="ID"{
            N.append(tokens[i].value)
            i+=1
            if tokens[i].Class==":"{
                i+=1
                if tokens[i].Class=="DT"{
                    Type.append(tokens[i].value)
                    T.append(",")
                    T.append(tokens[i].value)
                    i+=1
                    if insert_FT(N: N, T: Type, SC: sc){
                        if Par2(T:&T){
                        idk=true
                    }
                }
                }
            }
        }
    }
    if tokens[i].Class==")"{
        idk=true
    }
    return idk
}
func Par(T: inout String)->Bool{
    var idk=false
    if tokens[i].Class=="ID"{
        var N=""
        var Type=""
        N.append(tokens[i].value)
        i+=1
        if tokens[i].Class==":"{
            i+=1
            if tokens[i].Class=="DT"{
                T.append(tokens[i].value)
                Type.append(tokens[i].value)
                if insert_FT(N: N, T: Type, SC: sc) {

                i+=1
                    if Par2(T: &T){
                    idk=true
                }
            }
            }
        }
        
    }
    else if tokens[i].Class==")"{
        idk=true
    }
    return idk
}
func DOP3()->Bool{
    var idk=false
    if tokens[i].Class=="DotOp"{
        i+=1
        if tokens[i].Class=="ID"{
            i+=1
            if Fol2(){
                if DOP3(){
                    idk=true
                }
            }
        }
    }
    else if tokens[i].Class=="ASE" || tokens[i].Class=="AS"{
        idk=true
    }
    return idk
}
func func_id()->Bool{
    var idk=false
    if tokens[i].Class=="DotOp" || tokens[i].Class=="AS" || tokens[i].Class=="ASE" || tokens[i].Class=="["{
        if Fol2(){
            if DOP2(){
                idk=true
            }
        }
    }
    else if tokens[i].Class=="("{
        i+=1;
        var Ty=""
        if Par(T: &Ty){ ///Functions
            if tokens[i].Class==")"{
                i+=1
                if Fol2(){
                    if DOP3(){
                        idk=true
                    }
                }
            }
        }
        
    }
    return idk
}
func Fol1()->Bool{
    var idk=false
    if tokens[i].Class=="ID"{
        i+=1
        if func_id(){
            idk=true
        }
    }
    return idk
}
func DOP()->Bool{
    var idk=false
    if tokens[i].Class=="DotOp"{
        i+=1
        if Fol1(){
            idk=true
        }
    
    }
    return idk
}
func X()->Bool{
    var idk=false
    if tokens[i].Class=="DotOp"{
        if DOP(){
            idk=true
        }
    }
    else if tokens[i].Class=="["{
        if Arr(){
            idk=true
        }
    }
    else if tokens[i].Class=="ASE" || tokens[i].Class=="AS"{
        idk=true
    }
    else if tokens[i].Class=="MDM" || tokens[i].Class=="ROP" || tokens[i].Class=="AND" || tokens[i].Class=="OR" || tokens[i].Class==")" || tokens[i].Class=="PM" || tokens[i].Class==";"{
        idk=true
    }
    return idk
}


func OP()->Bool{
    var idk=false
    if tokens[i].Class=="ASE" || tokens[i].Class=="AS"{
        i+=1
        idk=true
    }
    return idk
}
func T1(T: inout String)->Bool{
    var idk=false
    if tokens[i].Class=="MDM"{
        var t2=""
        i+=1
        if F(T: &t2){
            if T1(T: &t2){
                if comp_check(leftType: T, rightType: t2){
                    idk=true
                }
                
            }
        }
    }
    else if tokens[i].Class==")" || tokens[i].Class=="OR" || tokens[i].Class=="AND" || tokens[i].Class=="ROP" || tokens[i].Class=="PM" || tokens[i].Class==";"{ ///FOLLOW SET AFTER C3
        idk=true
    }
    return idk
}
func E1(t: inout String)->Bool{
    var idk=false
    if tokens[i].Class=="PM"{
        var t2=""
        i+=1
        if T(T: &t2){
            if E1(t: &t2){
                if comp_check(leftType: t, rightType: t2){
                    idk=true
                }
                
            }
            
        }
    }
    else if tokens[i].Class==")" || tokens[i].Class=="OR" || tokens[i].Class=="AND" || tokens[i].Class=="ROP" || tokens[i].Class==";"{ idk=true
        
    }
    return idk
}
func RE1(T: inout String)->Bool{
    var idk=false
    if tokens[i].Class=="ROP"{
        var t2=""
        i+=1
        if E(t: &t2){
            if RE1(T: &t2){
                if comp_check(leftType: T, rightType: t2){
                    idk=true
                }
                
            }
        }
    }
    else if tokens[i].Class==")" || tokens[i].Class=="OR" || tokens[i].Class=="AND" || tokens[i].Class==";"{ ///FOLLOW SET AFTER C3
        idk=true
    }
    return idk
}
func AE1(T: inout String)->Bool{
    var idk=false
    if tokens[i].Class=="AND"{
        var t2=""
        i+=1
        if RE(T: &t2){
            if AE1(T: &t2){
                if comp_check(leftType: T, rightType: t2){
                    idk=true
                }
            }
        }
    }
    else if tokens[i].Class==")" || tokens[i].Class=="OR" || tokens[i].Class==";"{ ///FOLLOW SET AFTER C3
        idk=true
    }
    return idk
}
func OE1(T: inout String)->Bool{
    var idk=false
    if tokens[i].Class=="OR"{
        var t2=""
        i+=1
        if AE(T: &t2){
            if OE1(T: &t2){
                if comp_check(leftType: T, rightType: t2){
                    idk=true
                }
            }
        }
    }
    else if tokens[i].Class==")" || tokens[i].Class==";"{ ///FOLLOW SET AFTER C3
        idk=true
    }
    return idk
}
func THIS(T: inout String)->Bool{
    var idk=false
    if tokens[i].Class=="this"{
        i+=1
        idk=true
    }
    else if tokens[i].Class=="ID"{
        idk=true
    }
    return idk
}
func const(T: inout String)->Bool{
    var idk=false
    if tokens[i].Class=="int_const"{
        T.append("Int")
        i+=1
        idk=true
    }
    else if tokens[i].Class=="bool_const"{
        T.append("Bool")
        i+=1
        idk=true
    }
    else if tokens[i].Class=="float_const"{
        T.append("Float")
        i+=1
        idk=true
    }
    else if tokens[i].Class=="string_const"{
        T.append("String")
        i+=1
        idk=true
    }
    else if tokens[i].Class=="char_const"{
        T.append("Char")
        i+=1
        idk=true
    }
    return idk
}
func F(T: inout String)->Bool{
    var idk=false
    var N=""
    if tokens[i].Class=="this" || tokens[i].Class=="ID"{
        if THIS(T: &T){
            if tokens[i].Class=="ID"{
                N.append(tokens[i].value)
                let b=lookup_FT(N: N)
                if b.Type != ""{
                    T=b.Type
                i+=1
                if X(){
                    idk=true
                }
            
            }
        }
    }
    }
    else if tokens[i].Class=="int_const" || tokens[i].Class=="string_const" || tokens[i].Class=="char_const" || tokens[i].Class=="bool_const" || tokens[i].Class=="float_const"{
        if const(T: &T){
            idk=true
        }
    }
    else if tokens[i].Class=="("{
        i+=1
        if E(t: &T){
            if tokens[i].Class==")"{
                i+=1
                idk=true
            }
        }
    }
    return idk
}
func T(T: inout String)->Bool{
    var idk=false
    if tokens[i].Class=="this" || tokens[i].Class=="int_const" || tokens[i].Class=="string_const" || tokens[i].Class=="char_const" || tokens[i].Class=="bool_const" || tokens[i].Class=="float_const" || tokens[i].Class=="(" || tokens[i].Class=="ID"{
        if F(T: &T){
            if T1(T: &T){
                idk=true
            }
        }
    }
    return idk
}
func E(t: inout String)->Bool{
    var idk=false
    if tokens[i].Class=="this" || tokens[i].Class=="int_const" || tokens[i].Class=="string_const" || tokens[i].Class=="char_const" || tokens[i].Class=="bool_const" || tokens[i].Class=="float_const" || tokens[i].Class=="(" || tokens[i].Class=="ID"{
        if T(T: &t){
            if E1(t: &t){
                idk=true
            }
        }
    }
    return idk
}
func RE(T: inout String)->Bool{
    var idk=false
    if tokens[i].Class=="this" || tokens[i].Class=="int_const" || tokens[i].Class=="string_const" || tokens[i].Class=="char_const" || tokens[i].Class=="bool_const" || tokens[i].Class=="float_const" || tokens[i].Class=="(" || tokens[i].Class=="ID"{
        if E(t: &T){
            if RE1(T: &T){
                idk=true
            }
        }
    }
    return idk
}
func AE(T: inout String)->Bool{
    var idk=false
    if tokens[i].Class=="this" || tokens[i].Class=="int_const" || tokens[i].Class=="string_const" || tokens[i].Class=="char_const" || tokens[i].Class=="bool_const" || tokens[i].Class=="float_const" || tokens[i].Class=="(" || tokens[i].Class=="ID"{
        if RE(T: &T){
            if AE1(T: &T){
              idk=true
            }
        }
    }
    return idk
}
func OE(T: inout String)->Bool{
    var idk=false
    if tokens[i].Class=="this" || tokens[i].Class=="int_const" || tokens[i].Class=="string_const" || tokens[i].Class=="char_const" || tokens[i].Class=="bool_const" || tokens[i].Class=="float_const" || tokens[i].Class=="(" || tokens[i].Class=="ID"{
        if AE(T: &T){
            if OE1(T: &T){
                idk=true
            }
        }
    }
    return idk
}
    
func assign_st()->Bool{
    var idk=false
    var N=""
    var T1=""
    var T2=""
    if tokens[i].Class=="ID"{
        N.append(tokens[i].value)
        i+=1
        if X(){
            let b = lookup_FT(N: N)
            if b.Type != ""{
                T1=b.Type
            if OP(){
                if OE(T: &T2){
                    if comp_check(leftType: T1, rightType: T2){
                        idk=true
                    }
                    
                }
            }
        }
        }
    }
    return idk
}
func in1(T: inout String)->Bool{
    var idk=false
    if tokens[i].Class=="INT"{
        i+=1
        idk=true
    }
    else if tokens[i].Class=="ID"{
        let N=tokens[i].value
        let b = lookup_FT(N: N)
        if b.Type != ""{
            idk=true
        }
    
    }
    return idk
}
func c1()->Bool{
    var idk=false
        if tokens[i].Class=="ID" || tokens[i].Class=="INT"{
            var T=""
            var T2=""
            if in1(T: &T){
                if tokens[i].Class=="ID"{
                    i+=1
                    if tokens[i].Class=="AS"{
                        i+=1
                        if tokens[i].Class=="int_const"{
                            T2.append("Int")
                            if comp_check(leftType: T, rightType: T2){
                            i+=1
                            if tokens[i].Class==";"{
                                i+=1
                                idk=true
                            }
                        }
                        }
                        
                    }
                }
            }
        }
    else if tokens[i].Class==";"{
        i+=1
        idk=true
    }
    return idk
}
func c2()->Bool{
    var idk=false
    if tokens[i].Class=="ID" || tokens[i].Class=="char_const" || tokens[i].Class=="bool_const" || tokens[i].Class=="float_const" || tokens[i].Class=="int_const" || tokens[i].Class=="string_const" {
        var T1=""
        var T2=""
        if ID_const(T: &T1){
            if tokens[i].Class=="ROP"{
                i+=1
                if ID_const(T: &T2){
                    if comp_check(leftType: T1, rightType: T2){
                        idk=true
                    }
                    
                }
            }
        }

    }
    else if tokens[i].Class==";"{
        idk=true
    }
    return idk
}

func c3()->Bool{
    var idk=false
    if tokens[i].Class=="ID"{
        if assign_st(){
            idk=true
        }
    }
    else if tokens[i].Class==")"{
        idk=true
    }
    return idk
}
func OPT2(ref: ClassTable)->Bool{
    var idk=false
    if tokens[i].Class=="CATCH"{
        i+=1
        if tokens[i].Class=="{"{
            i+=1
            if MST(ref: ref){
                if tokens[i].Class=="}"{
                    i+=1
                    if OPT2(ref: ref){
                        idk=true
                    }
                }
            }
        }
    }
    else if tokens[i].Class=="FINAL"{
        i+=1
        if tokens[i].Class=="{"{
            i+=1
            if MST(ref: ref){
                if tokens[i].Class=="}"{
                    i+=1
                    idk=true
                }
            }
        }
    }
    else if tokens[i].Class=="LET" || tokens[i].Class=="VAR" || tokens[i].Class=="ID" || tokens[i].Class=="AF" || tokens[i].Class=="AM" || tokens[i].Class=="CLASS" || tokens[i].Class=="FUNC" || tokens[i].Class=="DO" || tokens[i].Class=="WHILE" || tokens[i].Class=="IF" || tokens[i].Class=="FOR" || tokens[i].Class=="TRY" || tokens[i].Class=="SWITCH" || tokens[i].Class=="$"{
        idk=true
    }
    return idk
}
func ID_const(T: inout String)->Bool{
    var idk=false
    if tokens[i].Class=="ID"{
        let N=tokens[i].value
        let b = lookup_FT(N: N)
        if b.Type != "" && b.Type == "Int"{
            i+=1
            T=b.Type
            idk=true
        }
        else {
            print("Incorrect type")
        }
    }
    else if tokens[i].Class=="int_const" || tokens[i].Class=="string_const" || tokens[i].Class=="char_const" || tokens[i].Class=="bool_const" || tokens[i].Class=="float_const"{
        if const(T: &T){
            idk=true
        }
}
    return idk
}
func OPT(ref: ClassTable)->Bool{
    var idk=false
    if tokens[i].Class=="CATCH"{
        i+=1
        if tokens[i].Class=="{"{
            i+=1
            if MST(ref: ref){
                if tokens[i].Class=="}"{
                    i+=1
                    if OPT2(ref: ref){
                        idk=true
                    }
                }
            }
        }
    }
        
    return idk
}

func c_body(ref: ClassTable)->Bool{
        var idk=false
    if tokens[i].Class=="LET" || tokens[i].Class=="VAR" || tokens[i].Class=="ID" || tokens[i].Class=="AF" || tokens[i].Class=="AM" || tokens[i].Class=="CLASS" || tokens[i].Class=="FUNC" || tokens[i].Class=="DO" || tokens[i].Class=="WHILE" || tokens[i].Class=="IF" || tokens[i].Class=="FOR" || tokens[i].Class=="TRY" || tokens[i].Class=="SWITCH"{
        if SST(ref: ref){
            idk=true
        }
    }
    else if tokens[i].Class=="{"{
        i+=1
        if SST(ref: ref){
            if MST(ref: ref){
                if tokens[i].Class=="}"{
                    i+=1
                    idk=true
                }
            }
    }
        else{
            print("case must have at least one statement")
        }
    }
    
        return idk
    
}

func cas3_st(T: inout String, ref: ClassTable)->Bool{
    var idk=false
    if tokens[i].Class=="CASE"{
        var T2=""
        i+=1
        if tokens[i].Class==":"{
            i+=1
            if ID_const(T: &T2){
                if comp_check(leftType: T, rightType: T2){
                    if c_body(ref: ref){
                    idk=true
                }
            }
            }
        }
    }
    return idk
}
func cas3s(T: inout String, ref: ClassTable)->Bool{
    var idk=false
    if tokens[i].Class=="CASE"{
        if cas3_st(T: &T, ref: ref){
            idk=true
        }
    }
    else if tokens[i].Class=="DEFAULT"{
        idk=true
    }
    return idk
}
func cas3(T: inout String, ref: ClassTable)->Bool{
    var idk=false
    if tokens[i].Class=="CASE" || tokens[i].Class=="DEFAULT"{
        if cas3s(T: &T, ref: ref){
            idk=true
        }
    }
    return idk
}
func def(ref: ClassTable)->Bool{
    var idk=false
    if tokens[i].Class=="DEFAULT"{
        i+=1
        if tokens[i].Class==":"{
            i+=1
            if c_body(ref: ref){
                idk=true
            }
        }
    }
    return idk
}
func TM(TM: inout String)->Bool{
    var idk=false
    if tokens[i].Class=="TM"{
        TM.append(tokens[i].value)
        i+=1
        idk=true
    }
    else if tokens[i].Class=="AM"{
        TM.append("None")
        idk=true
    }
    else if tokens[i].Class=="FUNC" || tokens[i].Class=="VAR" || tokens[i].Class=="LET" {
        TM.append("None")
        idk=true
    }
    return idk
}
func AM(AM: inout String)->Bool{
    var idk=false
    if tokens[i].Class=="AM"{
//        AM.append(tokens[i].value)
        i+=1
        idk=true
    }
    else if tokens[i].Class=="CLASS" || tokens[i].Class=="FUNC" || tokens[i].Class=="VAR" || tokens[i].Class=="LET" || tokens[i].Class=="AF" || tokens[i].Class=="TM" {
        AM.append("Default")
        idk=true
    }
    return idk
}
//func TM(Cat: inout String)->Bool{
//    var idk=false
//    if tokens[i].Class=="TM"{
//        i+=1
//    }
//    else if tokens[i].Class=="CLASS"{
//        idk=true
//    }
//    return idk
//}
func AF(Cat: inout String)->Bool{
    var idk=false
    if tokens[i].Class=="AF" || tokens[i].Class=="TM"{
        Cat.append(tokens[i].value)
        i+=1
        idk=true
    }
    else if tokens[i].Class=="CLASS"{
        Cat.append("None")
        idk=true
    }
    return idk
}
func cl(Par: inout String)->Bool{
    var idk=false
    var N=""
    if tokens[i].Class==":"{
        i+=1
        if tokens[i].Class=="ID"{
            N.append(tokens[i].value)
            let T=typeLookupMT(N: N)
            if T.cat=="final"{
                print("\(N) is a final class. Cannot be inherited")
            }
            else if T.Type=="struct"{
                print("class cannot inherit from struct")
            }
            else if T.Type==""{
                print("no such class exits")
            }
            else{
                Par.append(tokens[i].value)
                i+=1
                idk=true
            }
            
        }
    }
    else if tokens[i].Class=="{"{
        Par.append("None")
        idk=true
    }
    return idk
}

func func_var(N: inout String, T:inout String, AM: inout String, tm: inout String, ref: ClassTable, cat: inout String, Parent: inout String)->Bool{
    var idk=false
            if tokens[i].Class=="CLASS"{
                T.append(tokens[i].value)
                i+=1
                if tokens[i].Class=="ID"{
                    N.append(tokens[i].value)
                    i+=1
                    if cl(Par: &Parent){
                        let nested=ClassTable()
                        if insert_MT(N: N, T: T, AM: AM, Cat: cat, Par: Parent, link: nested){
                        if tokens[i].Class=="{"{
                            CreateScope()
                            i+=1
                            if CB(c_n: &N, ref: nested){
                                if tokens[i].Class=="}"{
                                    destroyScope()
//                                    print(sc)
                                    i+=1
                                    idk=true
                                }
                            }
                        }
                    }
                    }
                }
            }
        
    else if tokens[i].Class=="FUNC"{
        i+=1
        if tokens[i].Class=="ID"{
            N.append(tokens[i].value)
            i+=1
            if tokens[i].Class=="("{
                CreateScope()
                i+=1
                if Par(T: &T){
                    if tokens[i].Class==")"{
                        i+=1
                        if func_body(N: &N, T: &T, AM: &AM, TM: &tm, ref: ref){
                            idk=true
                        }
                    }
                }
            }
        }
    }
    if tokens[i].Class=="VAR"{
        var vars:[String]=[]
//        var dts:[DataEntries]=[]
        i+=1
        if tokens[i].Class=="ID"{
            vars.append(tokens[i].value)
            i+=1
            if SST3(N: &vars, T: &T){
                for vs in vars{
                    if insertDT_v(N: vs, T: T, AM: AM, TM: tm, link: ref){
                        idk=true
                    }
                }
            }
//            if oth(){
//                if tokens[i].Class==":"{
//                    i+=1
//                    if tokens[i].Class=="DT"{
//                        T.append(tokens[i].value)
//                        i+=1
//                        if insertDT_v(N: N, T: T, AM: AM, TM: tm, link: ref){
//                        if AS(T: &T){
//                            if tokens[i].Class==";"{
//                                i+=1
//                                idk=true
//                            }
//
//                        }
//                    }
//                }
//                }
//            }
        }
    }
    if tokens[i].Class=="LET"{
        i+=1
        if tokens[i].Class=="ID"{
            var consts: [String]=[]
            consts.append(tokens[i].value)
            i+=1
//            let v1=DataEntries(name: N, type: T, AM: am, TM: tm)
            if SST3(N: &consts, T: &T){
                for cs in consts{
                    if insertDT_v(N: cs, T: T, AM: AM, TM: tm, link: ref){
                        idk=true
                    }
                }
           
            }
        
        }
    }
//    if tokens[i].Class=="CLASS"{
//        i+=1
//        if tokens[i].Class=="ID"{
//            i+=1
//            if cl(){
//                if tokens[i].Class=="{"{
//                    i+=1
//                    if CBC(){
//                        if tokens[i].Class=="}"{
//                            i+=1
//                            idk=true
//                        }
//                    }
//                }
//            }
//        }
//    }
//
    return idk
}
func fcdc(N: inout String, T:inout String, AM: inout String, tm: inout String, Cat: inout String, P: inout String, c_n: inout String, ref: ClassTable )->Bool{
    var idk=false
//    }                nested classes do not work
    if tokens[i].Class=="TM" || tokens[i].Class=="FUNC" || tokens[i].Class=="VAR" || tokens[i].Class=="LET"{
        
        if TM(TM: &tm){
            if func_var(N: &N, T: &T, AM: &AM, tm: &tm, ref: ref, cat: &Cat, Parent: &P){
                idk=true
            }
        }
        
    }
    
    else if tokens[i].Class=="ID"{
        if SST1(ref: ref){ //typechecking
            if CB(c_n: &N, ref: ref){
                idk=true
            }
        }
    }
    return idk
}
func CB(c_n: inout String, ref: ClassTable)->Bool{
    var idk=false
    var am=""
    var T=""
    var N=""
    var TM=""
    var Cat=""
    var P=""
    if tokens[i].Class=="FUNC" || tokens[i].Class=="CLASS" || tokens[i].Class=="AF" || tokens[i].Class=="AM" || tokens[i].Class=="LET" || tokens[i].Class=="VAR" || tokens[i].Class=="TM"{
        if AM(AM: &am){
            if fcdc(N: &N, T: &T, AM: &am, tm: &TM, Cat: &Cat, P: &P, c_n: &c_n, ref: ref) {
                if CB(c_n: &c_n, ref: ref){
                    idk=true
                }
            }
        }
    }
    else if tokens[i].Class=="ID"{
        if fcdc(N: &N, T: &T, AM: &am, tm: &TM, Cat: &Cat, P: &P, c_n: &c_n, ref: ref) {
            if CB(c_n: &c_n, ref: ref){
                idk=true
            }
        }
    }
    else if tokens[i].Class=="}"{
        idk=true
    }
    else if tokens[i].Class=="VIRTUAL"{
        am.append("None")
        TM.append(tokens[i].value)
        i+=1
        if tokens[i].Class=="FUNC"{
            i+=1
            if tokens[i].Class=="ID"{
                N.append(tokens[i].value)
                i+=1
                if tokens[i].Class=="("{
                    CreateScope()
                    i+=1
                    if Par(T: &T){
                        if tokens[i].Class==")"{
                            i+=1
                            if func_body(N: &N, T: &T, AM: &am, TM: &TM, ref: ref){
                                if CB(c_n: &c_n, ref: ref){
                                idk=true
                            }


                        }
                    }
                }
            }
        }
//
        

    }
    }
    
    else if tokens[i].Class=="OVERRIDE"{
        let a = typeLookupMT(N: c_n)
        let parent=a.Par
        let b = typeLookupMT(N: parent)
        let par_link=b.ref
//        var fn_id=""
//        var fn_sign=""
        am.append("None")
        TM.append(tokens[i].value)
        i+=1
        if tokens[i].Class=="FUNC"{ // check parent of this class wether it inherits or  not if yes is signature the same?
            i+=1
            if tokens[i].Class=="ID"{
//                fn_id.append(tokens[i].value)
                N.append(tokens[i].value)
                i+=1
                if tokens[i].Class=="("{
                    CreateScope()
                    i+=1
                    if Par(T: &T){
                        if tokens[i].Class==")"{
                            i+=1
                            if func_body(N: &N, T: &T, AM: &am, TM: &TM, ref: ref){
                                let c=TypeLookup_fn_DT(N: N, T: T, ref: par_link)
                                if c.T==T && c.TM=="virtual"{
                                    idk=true
                                }
                                else{
                                    print("Method does not override any method from its superclass")
                                }
                            }
                        
                        }
                    }
                }
            }
        }

    }
    else if tokens[i].Class=="INIT"{
        if init_construct(){
            idk=true
        }
    }
    
    return idk
}
func return_st(T: inout String)->Bool{
    var idk=false
    let T1=getFuncType(T: T)
    var T2=""
    if tokens[i].Class=="RETURN"{
        i+=1
        if OE(T: &T2){
            if comp_check(leftType: T1, rightType: T2){// separate function Type string and compare
            if tokens[i].Class==";"{
                i+=1
                idk=true
            }
            }
        }
    }
    return idk
}
func DIR()->Bool{
    var idk=false
    if tokens[i].Class=="DT"{
        i+=1
        idk=true
    }
    return idk
}
func RETURN(N: inout String, T: inout String, AM: inout String, TM: inout String, ref: ClassTable)->Bool{
    var idk=false
    if tokens[i].Class=="DT"{
        T.append("->")
        T.append(tokens[i].value)
        i+=1
        if insertDT_f(N: N, T: T, AM: AM, TM: TM, link: ref){
            if tokens[i].Class=="{"{
//                CreateScope()
                i+=1
                if MST(ref: ref){
                    if return_st(T: &T){
                        if tokens[i].Class=="}"{
                            removeFromFT(scp: sc)
                            destroyScope()
//                            print(sc)
                            i+=1
                            idk=true
                        }
                        
                    }
                }
            }
    }
    
    
    }
    else if tokens[i].Class=="VOID"{
        T.append("->")
        T.append(tokens[i].value)
        i+=1
//        let o1=DataEntries(name: N, type: T, AM: AM, TM: TM)
//        if ref.Addfunc(fn: o1, N: N, T: T){
        if insertDT_f(N: N, T: T, AM: AM, TM: TM, link: ref){
        if tokens[i].Class=="{"{
//            CreateScope()
            i+=1
            if MST(ref: ref){
                if tokens[i].Class=="}"{
                    removeFromFT(scp: sc)
                    destroyScope()
                    i+=1
                    idk=true
                }
            }
        }
    }
    }
    
    return idk
    }
    


func NORET(N: inout String, T: inout String, AM: inout String, TM: inout String, ref: ClassTable)->Bool{
    var idk=false
    if insertDT_f(N: N, T: T, AM: AM, TM: TM, link: ref){
    if tokens[i].Class=="{"{
//        CreateScope()
        i+=1
        if MST(ref: ref){
            if tokens[i].Class=="}"{
                removeFromFT(scp: sc)
                destroyScope()
//                print(sc)
                i+=1
                idk=true
            }
        }
    
    }
}
    return idk
}
func RET(N: inout String, T: inout String, AM: inout String, TM: inout String, ref: ClassTable)->Bool{
    var idk=false
    if tokens[i].Class==":"{
        i+=1
        if RETURN(N: &N, T: &T, AM: &AM, TM: &TM, ref: ref){
            idk=true
        }
        
    }
    return idk
}
func func_body(N: inout String, T: inout String, AM: inout String, TM: inout String, ref: ClassTable)->Bool{
    var idk=false
    if tokens[i].Class==":"{
        if RET(N: &N, T: &T, AM: &AM, TM: &TM, ref: ref){
            idk=true
        }
    }
    else if tokens[i].Class=="{"{
        if NORET(N: &N, T: &T, AM: &AM, TM: &TM, ref: ref){
            idk=true
        }
    }
    return idk
}
func oth(N: inout [String])->Bool{
    var idk=false
    if tokens[i].Class=="," {
        i+=1
        if tokens[i].Class=="ID"{
            N.append(tokens[i].value)
            i+=1
            if oth(N: &N){
                idk=true
            }
        }
    }
    else if tokens[i].Class==":"{
        idk=true
    }
    return idk
}
func AS1(T: inout String)->Bool{
    var idk=false
    if tokens[i].Class=="int_const" || tokens[i].Class=="string_const" || tokens[i].Class=="char_const" || tokens[i].Class=="bool_const" || tokens[i].Class=="float_const" || tokens[i].Class=="(" || tokens[i].Class=="ID"{
        if OE(T: &T){
            idk=true
        }
    }
    else if tokens[i].Class=="["{
        if Arr(){
            T.append("Int")
            idk=true
        }
    }
    return idk
}
func AS(T: inout String)->Bool{
    var idk=false
    var t2=""
    if tokens[i].Class=="ASE" || tokens[i].Class=="AS"{
        if OP(){
            if AS1(T: &t2){
                if comp_check(leftType: T, rightType: t2){
                if tokens[i].Class==";"{
                    i+=1
                    idk=true
                }
            }
            }
        }
    }
    else if tokens[i].Class==";"{
        i+=1
        idk=true
    }
    
    return idk
}
func SST3(N: inout [String], T:inout String)->Bool{
    var idk=false
    if tokens[i].Class=="," || tokens[i].Class==":"{
        if oth(N: &N){
            if tokens[i].Class==":"{
                i+=1
                if tokens[i].Class=="DT"{
                    T.append(tokens[i].value)
                    i+=1
                    if AS(T: &T){
                        idk=true
                    }
                }
            }
        }
    }
    else if tokens[i].Class=="AS"{
        i+=1
        if tokens[i].Class=="ID"{
            T.append(tokens[i].value)
            let c=typeLookupMT(N: T)
            if c.cat != ""{
            i+=1
            if tokens[i].Class=="("{
                i+=1
                if params(T: &T){
                    if tokens[i].Class==")"{
                       i+=1
                        if tokens[i].Class==";"{
                            i+=1
                            idk=true
                        }
                    }
                }
            }
        }
        }
    }
    return idk
}
//func st()->Bool{
//    var idk=false
//    if tokens[i].Class=="CLASS"{
//        i+=1
//        if tokens[i].Class=="ID"{
//            i+=1
//            if cl(){
//                if tokens[i].Class=="{"{
//                    i+=1
//                    if CB(){
//                        if tokens[i].Class=="}"{
//                            i+=1
//                            idk=true
//                        }
//                    }
//                }
//            }
//        }
//    }
//    else if tokens[i].Class=="FUNC"{
//        i+=1
//        if tokens[i].Class=="ID"{
//            i+=1
//            if tokens[i].Class=="("{
//                if Par(){
//                    if tokens[i].Class==")"{
//                        i+=1
//                        if func_body(){
//                            idk=true
//                        }
//                    }
//                }
//            }
//        }
//    }
//    else if tokens[i].Class=="LET"{
//        i+=1
//        if tokens[i].Class=="ID"{
//            i+=1
//            if SST3(){
//                idk=true
//            }
//        }
//    }
//    else if tokens[i].Class=="VAR"{
//        i+=1
//        if tokens[i].Class=="ID"{
//            i+=1
//            if oth(){
//                if tokens[i].Class==":"{
//                    i+=1
//                    if tokens[i].Class=="DT"{
//                        i+=1
//                        if AS(){
//                            if tokens[i].Class==";"{
//                                i+=1
//                                idk=true
//                            }
//
//                        }
//                    }
//                }
//            }
//        }
//    }
//    return idk
//}
func DOP5(T: inout String)->Bool{
    var idk=false
    if tokens[i].Class=="DotOp"{
        i+=1
        if tokens[i].Class=="ID"{
            i+=1
            if IDF(T: &T){
                idk=true
            }
        }
        
        
    }
    return idk
}
func Fo3(T: inout String)->Bool{
    var idk=false
    if tokens[i].Class==";" && tokens[i+1].Class=="$"{
        i+=1
        idk=true
    }
    if tokens[i].Class==";"{
        i+=1
        idk=true
    }
    else if tokens[i].Class=="DotOp"{
        if DOP5(T: &T){
            idk=true
        }
        }
    return idk
}
func Fo2()->Bool{
    var idk=false
    if tokens[i].Class=="["{
        if Arr(){
            idk=true
        }
    }
    else if tokens[i].Class=="DotOp" || tokens[i].Class=="ASE" || tokens[i].Class=="AS" || tokens[i].Class=="("{
        idk=true
    }
    return idk
}
func Fo(T: inout String)->Bool{
    var idk=false
    var T2=""
    if tokens[i].Class=="ID" && tokens[i+1].Class != "("{
        let N=tokens[i].value
        let b = typeLookupMT(N: T)
        let link=b.ref
        let a=TypeLookup_att_DT(N: N, ref: link)
        if a.AM != "private" && a.AM != ""{
            T2.append(a.Type)
        i+=1
        if Fo2(){
            if IDF(T: &T2){
                idk=true
            }
        }
    }
        else{
            print("No such field exists in \(T) class")
        }
    
}
    else if tokens[i].Class=="ID" && tokens[i+1].Class=="("{
        var T2=""
        let N=tokens[i].value
        let b = typeLookupMT(N: T)
        let link=b.ref
        i+=1
        if Fo2(){
            if IDF(T: &T2){
                let T3=getFuncType(T: T2)
                let a = TypeLookup_fn_DT(N: N, T: T3, ref: link)
                print(a.T)
                let T1=getParams(T: a.T)
                if T1==T2{
                    idk=true
                }
            }
            
        }
    }
    return idk
}
func IDF(T: inout String)->Bool{
    var idk=false
    var T2=""
    if tokens[i].Class=="("{
        i+=1
//        var Ty=""
        if Par(T: &T){ ///FUNCTION
            if tokens[i].Class==")"{
                i+=1
                if Fo3(T: &T){
                    idk=true
                }
            }
        }
    }
    else if tokens[i].Class=="DotOp"{
        if DOP5(T: &T){
       idk=true
        }

    }
    else if tokens[i].Class=="ASE" || tokens[i].Class=="AS"{
        if OP(){
            if OE(T: &T2){
                if comp_check(leftType: T, rightType: T2) {
                if tokens[i].Class==";"{
                    i+=1
                    idk=true
                }
            }
            }
        }
    }
    return idk
}
func DOP4(T: inout String)->Bool{
    var idk=false
    if tokens[i].Class=="DotOp"{
        i+=1
        if Fo(T: &T){
            idk=true
        }
        
    }
    return idk
}
func params(T: inout String)->Bool{
    var idk=false
    if tokens[i].Class=="ID"{
        i+=1
        if tokens[i].Class==":"{
            i+=1
            if tokens[i].Class=="DT"{
//                T.append(tokens[i].value)
                i+=1
                if tokens[i].Class==","{
//                    T.append(tokens[i].value)
                    i+=1
                    if params(T: &T){
                        idk=true
                    }
                }
                else if tokens[i].Class==")"{
                    idk=true
                }
            }
        }
    }
    else if tokens[i].Class==")"{
        idk=true
    }
    return idk
}
func XY(N: inout String, ref: ClassTable, T1: inout String)->Bool{
    var idk=false
    var T2=""
    if tokens[i].Class=="DotOp"{
        if DOP4(T: &T1){
            idk=true
        }
    }
    else if tokens[i].Class=="["{
        if Arr(){
            if IDF(T: &T1){
                idk=true
            }
        }
    }
    else if tokens[i].Class=="("{
        i+=1
        if params(T: &T1){
            if tokens[i].Class==")"{
                let b = typeLookupMT(N: "GlobalTable")
                let link=b.ref
                let c=TypeLookup_fn_DT(N: N, T: T1, ref: link)
                if c.AM=="Default" && c.T==T1{
                i+=1
                if Fo3(T: &T1){
                    idk=true
                        
                    
                }
    
            }
               
            }
        }
    }
    else if tokens[i].Class=="ASE" || tokens[i].Class=="AS"{
        if OP(){
            if OE(T: &T2){
                if comp_check(leftType: T1, rightType: T2){
                if tokens[i].Class==";"{
                    i+=1
                    idk=true
            
                }
            }
            }
        }
    }
    return idk
}

func SST1(ref: ClassTable)->Bool{
    var idk = false
    var N=""
    var T1=""
    if tokens[i].Class=="ID" && tokens[i+1].Class != "("{
        N.append(tokens[i].value)
        let y=lookup_FT(N: N)
        T1=y.Type
        if T1 != "" {
        i+=1
            if XY(N: &N, ref: ref, T1: &T1){
            idk=true
//            if comp_check(leftType: T1, rightType: T2){
//                idk=true
//            }
        }
    }
    }
    else if tokens[i].Class=="ID" && tokens[i+1].Class == "("{
        N.append(tokens[i].value)
        i+=1
        if XY(N: &N, ref: ref, T1: &T1){
            idk=true
        }
        
    }
    return idk
}
func CBC(N: inout String, ref: ClassTable)->Bool{
    var idk=false
    if tokens[i].Class=="AF" || tokens[i].Class=="AM" || tokens[i].Class=="TM" || tokens[i].Class=="FUNC" || tokens[i].Class=="VAR" || tokens[i].Class=="LET" || tokens[i].Class=="CLASS" || tokens[i].Class=="VIRTUAL" || tokens[i].Class=="OVERRIDE" || tokens[i].Class=="INIT"{
        if CB(c_n: &N, ref: ref){
//            print(1)
            if CBC(N: &N, ref: ref){
//                print(1) does not work for nested classes
                idk=true
            }
        }
    }
    else if tokens[i].Class=="}" {
        idk=true
    }
    return idk
}
let j=0
func fcdg(N: inout String, T: inout String, AM: inout String, TM: inout String, Cat: inout String, P: inout String, gref: ClassTable, cref:ClassTable)->Bool{
    var idk=false
    var c_n=""
    if tokens[i].Class=="AF" || tokens[i].Class=="CLASS"{
        if AF(Cat: &Cat){
            if tokens[i].Class=="CLASS"{
                T.append(tokens[i].value)
                i+=1
                if tokens[i].Class=="ID"{
                    N.append(tokens[i].value)
                    i+=1
                    if cl(Par: &P){
                        if insert_MT(N: N, T: T, AM: AM, Cat: Cat, Par: P, link: cref){
                            c_n.append(N)
                        if tokens[i].Class=="{"{
                            CreateScope()
                            i+=1
                            if CBC(N: &c_n, ref: cref){
                                if tokens[i].Class=="}"{
                                    destroyScope()
//                                    print(sc)
                                    i+=1
                                    idk=true
                                }
                            }
                        }
                        
                    }
                }
                }
                }
            }
        }
    else if tokens[i].Class=="FUNC"{
        i+=1
        if tokens[i].Class=="ID"{
            N.append(tokens[i].value)
//            N.append(tokens[i].value)
            i+=1
            if tokens[i].Class=="("{
                i+=1
                CreateScope()
                if Par(T: &T){
                    if tokens[i].Class==")"{
                        i+=1
                        if func_body(N: &N, T: &T, AM: &AM, TM: &TM, ref: gref){
                            idk=true
                        }
                    }
                }
            }
        }
    }
    else if tokens[i].Class=="LET"{
        i+=1
        if tokens[i].Class=="ID"{
            var consts:[String]=[]
            consts.append(tokens[i].value)
//
            TM.append("const")
//            AM.append("Def")
            i+=1
            if SST3(N: &consts, T: &T){
                for cs in consts{
                    if insertDT_f(N: cs, T: T, AM: AM, TM: TM, link: gref){
                        if  insert_FT(N: cs, T: T, SC: sc) {
    //                        print(sc)
                             idk=true
                        }
                }
                }
                
            }
            
            
        }
    }

    else if tokens[i].Class=="VAR"{
        i+=1
        if tokens[i].Class=="ID"{
            var vars:[String]=[]
            vars.append(tokens[i].value)
            TM.append("var")
//            AM.append("Def")
            i+=1
            if SST3(N: &vars, T: &T){
                for vs in vars{
                    if insertDT_f(N: vs, T: T, AM: AM, TM: TM, link: gref){
                        if  insert_FT(N: vs, T: T, SC: sc) {
//                            print(sc)
                             idk=true
                        }
                }
                }
            }
//            if oth(){
//                if tokens[i].Class==":"{
//                    i+=1
//                    if tokens[i].Class=="DT"{
//                        T.append(tokens[i].value)
//                        i+=1
//                        if insertDT_f(N: N, T: T, AM: AM, TM: TM, link: gref){
//                            print("4")
//                            if insert_FT(N: N, T: T, SC: sc){
//                                print("4")
//                                print(sc)
//                        if AS(T: &T){
//                                idk=true
//
//                        }
//                            }
//                    }
//
//                }
//
//                }
//            }
        }
    }
    
    return idk
}
func fn_cls_dec(ref: ClassTable)->Bool{
    var idk=false
    var N=""
    var T=""
    var am=""
    var tm=""
    var cat=""
    var Par=""
//    var gtdts=[DataEntries]()
    var ctds=[DataEntries]()
    //let fn=DataEntries(name: "Myfunc", type: "Int", AM: "Def", TM: "None")
    //funcs.append(fn)
    //bc.Addfunc(fn: fn, N: "fn", T: "Int")
//    let gt=ClassTable(DTs: gtdts)
    let ct=ClassTable(DTs: ctds)
    BTs.append(ct)
    if tokens[i].Class=="FUNC" || tokens[i].Class=="CLASS" || tokens[i].Class=="AF" || tokens[i].Class=="AM" || tokens[i].Class=="LET" || tokens[i].Class=="VAR"{
        if AM(AM: &am){
                if fcdg(N: &N, T: &T, AM: &am, TM: &tm, Cat: &cat, P: &Par, gref: ref, cref: ct){
                idk=true
            }
        
        }
    }
    return idk
}

func SST(ref: ClassTable)->Bool{
    var idk=false
//    var gtdts=[DataEntries]()
//    let gt=ClassTable(DTs: gtdts)
    var T=""
    if tokens[i].Class=="IF"{
        i+=1
        if tokens[i].Class=="("{
            i+=1
            if(cond(T: &T)){ //also add the dts and funcs of global variable to FT
                if tokens[i].Class==")"{
                    i+=1
                    if tokens[i].Class=="{"{
                        CreateScope()

                        i+=1
                        if(if_else_body(ref: ref)){
                            if tokens[i].Class=="}"{
                                destroyScope()
                                i+=1
                                if(o_else(ref: ref)){
                                    idk=true
                                }
                                
                            }
                        }
                        
                    }
                }
            }
        }
        
    }
    else if tokens[i].Class=="WHILE"{
        i+=1
        if tokens[i].Class=="("{
            i+=1
            if(cond(T: &T)){
                if tokens[i].Class==")"{
                    if (body(ref: ref)){
                        idk=true
                    }
                }
            }
        }
    }
    
    else if tokens[i].Class=="DO"{
        i+=1
        if tokens[i].Class=="{"{
            CreateScope()
            i+=1
            if(MST(ref: ref)){
                i+=1
                if tokens[i].Class=="}"{
                    destroyScope()
                    i+=1
                    if tokens[i].Class=="WHILE"{
                        i+=1
                        if tokens[i].Class=="("{
                            i+=1
                            if cond(T: &T){
                                if tokens[i].Class==")"{
                                    i+=1
                                    if tokens[i].Class==";"{
                                        idk=true
                                    }
                                    
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    else if tokens[i].Class=="FOR"{
        i+=1
        if tokens[i].Class=="("{
            i+=1
            if c1(){
                if c2(){
                    if tokens[i].Class==";"{
                        i+=1
                        if c3(){
                            if tokens[i].Class==")"{
                                i+=1
                                idk=true
                                if body(ref: ref){
                                    idk=true
                                }
                            }
                        }
                    }
                   
                }
            }
        }
    }
    
    else if tokens[i].Class=="TRY"{
        i+=1
        if tokens[i].Class=="{"{
            CreateScope()
            i+=1
            if MST(ref: ref){
                if tokens[i].Class=="}"{
                    destroyScope()
                    i+=1
                    if OPT(ref: ref){
                        idk=true
                    }
                }
            }
        }
    }
    else if tokens[i].Class=="SWITCH"{
        i+=1
        var T=""
        if ID_const(T: &T){
            if tokens[i].Class=="{"{
                CreateScope()
                i+=1
                if cas3(T: &T, ref: ref){
                    if def(ref: ref){
                        if tokens[i].Class=="}"{
                            destroyScope()
                            i+=1
                            idk=true
                        }
                    }
                }
            }
        }
        
    }
    else if tokens[i].Class=="FUNC" || tokens[i].Class=="CLASS" || tokens[i].Class=="AF" || tokens[i].Class=="AM" || tokens[i].Class=="LET" || tokens[i].Class=="VAR"{
        if fn_cls_dec(ref: ref){
            idk=true
        }
    }
    else if tokens[i].Class=="ID"{
        if SST1(ref: ref){
            idk=true
        }
    }
    
    
    return idk
}
func SSTs(ref: ClassTable)->Bool{
    var idk=false
    if tokens[i].Class=="LET" || tokens[i].Class=="VAR" || tokens[i].Class=="ID" || tokens[i].Class=="AF" || tokens[i].Class=="AM" || tokens[i].Class=="CLASS" || tokens[i].Class=="FUNC" || tokens[i].Class=="DO" || tokens[i].Class=="WHILE" || tokens[i].Class=="IF" || tokens[i].Class=="FOR" || tokens[i].Class=="TRY" || tokens[i].Class=="SWITCH"{
        if(SST(ref: ref)){
            if(SSTs(ref: ref)){
                idk=true
            }
        }
    }
    else if tokens[i].Class=="$"{
        idk=true
    }
    
    
    
    return idk
}
if Prog(){
    print("No errors found")
}
else {
    print("line: " , tokens[i].lineNo)
}

