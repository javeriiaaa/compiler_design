

import Foundation

let id_rege="^([A-Za-z_]([A-Za-z_0-9])*[A-Za-z0-9])$|^([A-Za-z])$"
let idd="a54b"
let result1 = idd.range(of: id_rege, options: .regularExpression) == nil
//
let ch_reg2=#"^('\\['"\\rnt0]')|'[!@#$%^&*(),.?:{}\]\[|<>]'|'[\d\w\s]'$"#
let char = "\'a\'"
let result = char.range(of: ch_reg2, options: .regularExpression) == nil

////////////////////////////////////////////////////////////LEXICAL ANALYZER STARTS HERE///////////////////////////////////////////////////////////////////////

struct keyword {
    let Class: String
    let value: String
}
struct punc {
    let Class: String
    let value: String
}
struct op{
    let Class: String
    let value: String
}

var keywords: [keyword]=[]
var puncs:[punc]=[]
var ops:[op]=[]
func addkw(cls: String, value: String){
    let kw=keyword(Class: cls, value: value)
    keywords.append(kw)
}
addkw(cls: "LET", value: "let")
addkw(cls: "VAR", value: "var")
addkw(cls: "IF", value: "if")
addkw(cls: "ELSE", value: "else")
addkw(cls: "FOR", value: "for")
addkw(cls: "WHILE", value: "while")
addkw(cls: "DO", value: "do")

addkw(cls: "CLASS", value: "class")
addkw(cls: "STRUCT", value: "struct")
addkw(cls: "FUNC", value: "func")
addkw(cls: "RETURN", value: "return")
addkw(cls: "VOID", value: "void")
addkw(cls: "MAIN", value: "Main")
addkw(cls: "OVERRIDE", value: "override")
addkw(cls: "VIRTUAL", value: "virtual")
addkw(cls: "SUPER", value: "super")
addkw(cls: "AM", value: "public")
addkw(cls: "TM", value: "static")
addkw(cls: "AM", value: "private")
addkw(cls: "AF", value: "abstract")
addkw(cls: "AF", value: "final")
addkw(cls: "TRY", value: "try")
addkw(cls: "CATCH", value: "catch")
addkw(cls: "FINALLY", value: "finally")
//addkw(cls: "String", value: "String")
addkw(cls: "DT", value: "Int")
addkw(cls: "DT", value: "Char")
addkw(cls: "DT", value: "Bool")
addkw(cls: "DT", value: "Float")
addkw(cls: "DT", value: "String")
addkw(cls: "this", value: "this")
addkw(cls: "INT", value: "int") //for FOR loop
addkw(cls: "SWITCH", value: "switch")
addkw(cls: "CASE", value: "case")
addkw(cls: "DEFAULT", value: "default")
addkw(cls: "INIT", value: "init")
addkw(cls: "SELF", value: "self")
func addpc(cls: String, value: String){
    let pc=punc(Class: cls, value: value)
    puncs.append(pc)
}
addpc(cls: ";", value: ";")
addpc(cls: ":", value: ":")
addpc(cls: "(", value: "(")
addpc(cls: ")", value: ")")
addpc(cls: "[", value: "[")
addpc(cls: "]", value: "]")
addpc(cls: "{", value: "{")
addpc(cls: "}", value: "}")
addpc(cls: ",", value: ",")
//addpc(cls: "DOT", value: ".")
//addpc(cls: "arrow", value: "->")

func addop(cls: String, value: String){
    let ope=op(Class: cls, value: value)
    ops.append(ope)
}
addop(cls: "PM", value: "+")
addop(cls: "PM", value: "-")
addop(cls: "MDM", value: "/")
addop(cls: "MDM", value: "*")
addop(cls: "AND", value: "&&")
addop(cls: "OR", value: "||")
addop(cls: "ROP", value: "<")
addop(cls: "ROP", value: ">")
addop(cls: "ROP", value: "<=")
addop(cls: "ROP", value: ">=")
addop(cls: "ROP", value: "==")
addop(cls: "ROP", value: "!=")
addop(cls: "NOT", value: "!")
addop(cls: "ASE", value: "+=")
addop(cls: "ASE", value: "*=")
addop(cls: "ASE", value: "-=")
addop(cls: "AS", value: "=")
addop(cls: "DotOp", value: ".")


////////////////////////////////////////////// REGEX FUNCTIONS TO RECOGNIZE WORDS /////////////////////////////////////////////////////////////////////////////////////////////////////
var line_no=1
struct token {
    let Class: String
    let value: String
    let lineNo: Int
}
var tokens: [token] = []
let int_reg="^[+-]?[0-9]+$"
func isInt(int: String) -> (bool: Bool, value: String, Class:String) {
    var Class="int_const"
    var bool = false
    if  int.range(of: int_reg, options: .regularExpression) != nil {
    bool=true
    }
    else {
        Class="invalid lexeme"
    }
    return (bool,int, Class)
}
let ch_reg=#"^('\\['"\\rnt0]')|'[!@#$%^&*(),.?:{}\]\[|<>]'|'[\d\w\s]'$"#
func isChar(ch: String) -> (bool: Bool, value: String, Class:String) {
    var Class="char_const"
    var bool = false
    if ch.range(of: ch_reg, options: .regularExpression) != nil {
    bool=true
    }
    else {
        Class="invalid lexeme"
    }
    return (bool,ch, Class)
}
let str_reg="""
""\"(.|\n)*""\"|"([^\n"]*)"
"""
func isString(str: String) -> (bool: Bool, value: String, Class:String) {
    var Class="string_const"
    var bool = false
    if str.range(of: str_reg, options: .regularExpression) != nil {
    bool=true
    }
    else {
        Class="invalid lexeme"
    }
    return (bool,str, Class)
}
let flt_reg="[+-]?\\d*?[.]\\d*([E][+-]?\\d+)?"
func isFloat(fl: String) -> (bool: Bool, value: String, Class:String) {
    var Class="float_const"
    var bool = false
    if fl.range(of:flt_reg, options: .regularExpression) != nil {
    bool=true
    }
    else {
        Class="invalid lexeme"
    }
    return (bool,fl, Class)
}

let id_reg="^([A-Za-z_]([A-Za-z_0-9])*[A-Za-z0-9])$|^([A-Za-z])$"
func isID(id: String) -> (bool: Bool, value: String, Class:String) {
    var Class="ID"
    var bool = false
    if id.range(of:id_reg, options: .regularExpression) != nil {
    bool=true
    }
    else {
        Class="invalid lexeme"
    }
    return (bool,id, Class)
}
//#"(([A-Za-z_]([^.\n\t\r\s"]*)[A-Za-z0-9])|[A-Za-z]){1}"#
//([A-Za-z_]([^.]*)[A-Za-z0-9])|[A-Za-z]{1}
func isPunc(pc: String) -> (bool: Bool, value: String, Class:String) {
    var Class="Punctuator"
    var bool = false
    for punc in puncs{
        if punc.value == pc {
            bool = true
            Class = punc.Class
        }
    }
    
//    else {
//        Class="invalid lexeme"
//    }
    return (bool,pc, Class)
}
func isOp(op: String) -> (bool: Bool, value: String, Class:String) {
    var Class="Operator"
    var bool = false
    for ope in ops{
        if ope.value == op {
            bool = true
            Class = ope.Class
        }
    }
    
//    else {
//        Class="invalid lexeme"
//    }
    return (bool,op,Class)
}



////////////////////////////////////////////// APPENDING TOKENS IF WORDS GET RECOGNIZED BY REGEXES /////////////////////////////////////////////////////////////////////////////////////////////////////
for word in token_words{
    isID(id: word).bool==true
}

for word in token_words{
    
    if isID(id: word).bool == true{
        var iskw: Bool=false
        for kws in keywords{
            if kws.value == word{
                iskw=true
                let lexeme_token=token(Class: kws.Class, value: kws.value, lineNo: line_no)
                tokens.append(lexeme_token)
//                continue
                
            }
        }
        if iskw==false{
        
            let lexeme=isID(id: word)
            let lexeme_token=token(Class: lexeme.Class, value: lexeme.value, lineNo: line_no)
            tokens.append(lexeme_token)
//        continue
        }
//        continue
}
    else if isPunc(pc: word).bool==true{
        let lexeme=isPunc(pc: word)
        let lexeme_token=token(Class: lexeme.Class, value: lexeme.value, lineNo: line_no)
        tokens.append(lexeme_token)
//        continue
    }
    else if isOp(op: word).bool==true{
        let lexeme=isOp(op: word)
        let lexeme_token=token(Class: lexeme.Class, value: lexeme.value, lineNo: line_no)
        tokens.append(lexeme_token)
//        continue
    }
    else if isInt(int: word).bool == true{
        let lexeme=isInt(int: word)
        let lexeme_token=token(Class: lexeme.Class, value: lexeme.value, lineNo: line_no)
        tokens.append(lexeme_token)
//        continue

}

    else if isFloat(fl: word).bool == true{
        let lexeme=isFloat(fl: word)
        let lexeme_token=token(Class: lexeme.Class, value: lexeme.value, lineNo: line_no)
        tokens.append(lexeme_token)
//        continue

}
    
    else if isChar(ch: word).bool==true{
        let lexeme=isChar(ch: word)
        let lexeme_token=token(Class: lexeme.Class, value: lexeme.value, lineNo: line_no)
        tokens.append(lexeme_token)
//        continue
    }
    else if isString(str: word).bool==true{
        let lexeme=isString(str: word)
        let lexeme_token=token(Class: lexeme.Class, value: lexeme.value, lineNo: line_no)
        tokens.append(lexeme_token)
//        continue
    }
    else if word==String(linechar){
        line_no+=1
    }

    else{
        let lexeme_token=token(Class: "INCORRECT LEXEME", value: word, lineNo: line_no)
        tokens.append(lexeme_token)
    }
    
    
}


let lexeme_token=token(Class: "$", value: "$", lineNo: line_no)
tokens.append(lexeme_token)
for token in tokens{
    print(token)
}
