//
//  lexical1.swift
//
//
//  Created by Javeria on 12/27/20.
//

import Foundation

let Punctuators: [Character] = ["(", ")", "{", "}", "-", ">", ":", "[", "]", ";", "\"", "\'"]
let Operators: [Character] = ["+", "-", "*", "-", "=", "<", ">"]
let whitespace: Character = " "
let linechar: Character = "\n"
var charNo=0
//Sample Code For Practice
var str:String=""
let filePath = "/Users/javeria/Desktop/compiler/sample.txt"
 let fullPath = NSString(string: filePath).expandingTildeInPath
 do
 {
     let fileContent = try NSString(contentsOfFile: fullPath, encoding: String.Encoding.utf8.rawValue)
    str.append(fileContent as String)
 }
 catch
 {
     print(error)
 }
str.append("`")
///////////////////////////////////////////////////////WORD BREAKER STARTS HERE///////////////////////////////////////////////////////////////////////
var words=[String]()
var charArray = [Character]()
for char in str {
    func appendWord(){
        if charArray.isEmpty == false{
            words.append(String(charArray))
        }
        charArray=[]
        charArray.append(char)
        words.append(String(charArray))
        charArray=[]
        charNo+=1
    }
    func ignoreWhitespace(){
        if charArray.isEmpty == false{
            words.append(String(charArray))
        }
        charArray=[]
        charNo+=1
    }
  
   
    switch char{
    case "*":
        let next_char = str[str.index(str.startIndex, offsetBy: charNo+1)]
        let prev_char = str[str.index(str.startIndex, offsetBy: charNo-1)]
        if(next_char=="/"){
            
                if charArray.isEmpty == false{
                    words.append(String(charArray))
                }
                charArray=[]
                charArray.append(char)
                charArray.append(next_char)
                words.append(String(charArray))
                charArray=[]
                charNo+=1
        }
            else if prev_char == "/"{
                charNo=charNo+1
            }
            else {
                _ = str[str.index(str.startIndex, offsetBy: charNo)]
                let next_char = str[str.index(str.startIndex, offsetBy: charNo+1)]

                switch next_char{
                case "=":

                    if charArray.isEmpty == false{

                        words.append(String(charArray))
                        charArray=[]
                    }
                    charArray.append(char)
                    charArray.append(next_char)
                    words.append(String(charArray))
                    charArray=[]
                    charNo+=1

                default:
                    appendWord()
                }

            }
        
    case "/":
        _ = str[str.index(str.startIndex, offsetBy: charNo)]
        let next_char = str[str.index(str.startIndex, offsetBy: charNo+1)]
//        print(next_char)
        let prev_char = str[str.index(str.startIndex, offsetBy: charNo-1)]
        if next_char == "/" || next_char=="t" || next_char=="r" || next_char=="n" || next_char=="0"
        {
            if charArray.isEmpty == false{
                words.append(String(charArray))
            }
            charArray=[]
            charArray.append(char)
            charArray.append(next_char)
            words.append(String(charArray))
            charArray=[]
            charNo+=1
        }
        else if next_char == "*"
        {
            if charArray.isEmpty == false{
                words.append(String(charArray))
            }
            charArray=[]
            charArray.append(char)
            charArray.append(next_char)
            words.append(String(charArray))
            charArray=[]
            charNo+=1
        }
        
        else if prev_char == "/" || prev_char == "*"{
            charNo+=1
        }
        else{
          appendWord()
        }
        
//    case "\'":
//        let next_char = str[str.index(str.startIndex, offsetBy: charNo+1)]
//        let next_next_char = str[str.index(str.startIndex, offsetBy: charNo+1)]
////        print(next_char)
//
//        let prev_char = str[str.index(str.startIndex, offsetBy: charNo-1)]
//        if(next_next_char)
//
//
//    case "\"":
//        _ = str[str.index(str.startIndex, offsetBy: charNo)]
//        let next_char = str[str.index(str.startIndex, offsetBy: charNo+1)]
//        print(next_char)
//        let prev_char = str[str.index(str.startIndex, offsetBy: charNo-1)]
//        let prev_prev = str[str.index(str.startIndex, offsetBy: charNo-2)]
//        let next_next_char = str[str.index(str.startIndex, offsetBy: charNo+2)]
//
//        if prev_char == "\"" && prev_prev == "\""{
//            ignoreWhitespace()
//        }
//        else if next_char == "\"" && next_next_char == "\""{
//
//
//            if charArray.isEmpty == false{
//                words.append(String(charArray))
//            }
//            charArray=[]
//            charArray.append(char)
//            charArray.append(next_char)
//            charArray.append(next_next_char)
//            words.append(String(charArray))
//            charArray=[]
//            charNo+=2
//
//        }
//        else {
//            appendWord()
//        }

//    case "#":
//    let next_char = str[str.index(str.startIndex, offsetBy: charNo+1)]
//    let prev_char = str[str.index(str.startIndex, offsetBy: charNo-1)]
//        print(next_char)
//    if next_char == "#"
//    {
//        if charArray.isEmpty == false{
//            words.append(String(charArray))
//        }
//        charArray=[]
//        charArray.append(char)
//        charArray.append(next_char)
//        words.append(String(charArray))
//        charArray=[]
//        charNo+=1
//    }
//    else if prev_char == "#"{
//        break
//    }
//    else{
//      appendWord()
//    }


    case  "+", "-", "<", ">", "!":
        _ = str[str.index(str.startIndex, offsetBy: charNo)]
        let next_char = str[str.index(str.startIndex, offsetBy: charNo+1)]

        switch next_char{
        case "=":

            if charArray.isEmpty == false{

                words.append(String(charArray))
                charArray=[]
            }
            charArray.append(char)
            charArray.append(next_char)
            words.append(String(charArray))
            charArray=[]
            charNo+=1

        default:
            appendWord()
        }
    case "\\":
        let next_char = str[str.index(str.startIndex, offsetBy: charNo+1)]
        if next_char=="r" || next_char=="b" || next_char=="0" || next_char=="n"{
            if charArray.isEmpty == false{

                words.append(String(charArray))
                charArray=[]
            }
            charArray.append(char)
            charArray.append(next_char)
            words.append(String(charArray))
            charArray=[]
            charNo+=1

        }
    case "t", "r", "n", "0":
        let prev_char = str[str.index(str.startIndex, offsetBy: charNo-1)]
        if prev_char=="\\"{
            charNo+=1
        }
        else{
            charArray.append(char)
            charNo+=1
        }
    

    case "=":
        _ = str[str.index(str.startIndex, offsetBy: charNo)]
        let prev_char = str[str.index(str.startIndex, offsetBy: charNo-1)]
        let next_char = str[str.index(str.startIndex, offsetBy: charNo+1)]
        let prev_prev_char=str[str.index(str.startIndex, offsetBy: charNo-2)]
//        print(prev_char)
        if prev_char == "+" || prev_char == "*" || prev_char == "-" || prev_char == "<" ||
            prev_char == ">" || prev_char == "!" {
            charArray=[]
            charNo+=1
        }
        else if next_char == "=" && (prev_char != ">" || prev_char != "<" || prev_char != "+" || prev_char != "-" || prev_char != "!" || prev_char != "!"){
            if charArray.isEmpty == false{

                words.append(String(charArray))
                charArray=[]
            }
            charArray.append(char)
            charArray.append(next_char)
            words.append(String(charArray))
            charArray=[]
            charNo+=1
        }
        else if prev_char == "="{
//            print(prev_prev_char)
                    if prev_prev_char=="!" || prev_prev_char=="*" || prev_prev_char=="+" || prev_prev_char=="-" || prev_prev_char=="<"
                        || prev_prev_char==">"{
                        appendWord()
                    }
                    else{
                        charArray=[]
                        charNo+=1
                    }
                }

        else {
            appendWord()
        }
    case ".":
        let prev_char = str[str.index(str.startIndex, offsetBy: charNo-1)]
        if prev_char == "0" || prev_char == "1" || prev_char == "2" || prev_char == "3" || prev_char == "4" || prev_char == "4" || prev_char == "5" || prev_char == "6" || prev_char == "7" || prev_char == "8" || prev_char == "9"{
            charArray.append(char)
            charNo+=1
        }
        else {
            appendWord()
        }

       


//    case "/":
//        let next_char = str[str.index(str.startIndex, offsetBy: charNo+1)]
//        if next_char == "/"{
//
//        }
//
//    case "`":
//        appendWord()

    
    case _ where Punctuators.contains(char)==true:
        appendWord()

    case whitespace:
        ignoreWhitespace()

    case linechar:
        appendWord()

    default:
        charArray.append(char)
        charNo+=1
    }
}

//print(words)

var ind=0
var tokenn_words: [String] = []
while ind < words.count{
    var str=""
    if words[ind] == "\"" && words[ind+1]=="\"" && words[ind+2]=="\""{
        str.append(words[ind])
        str.append(words[ind+1])
        str.append(words[ind+2])
        tokenn_words.append(str)
        ind=ind+3
    }
    else
    {
        str.append(words[ind])
        tokenn_words.append(str)
        ind+=1
    }
    
}
//print(tokenn_words)
/////////////////////////////////////////////HANDLING SINGLE LINE STRINGS AND COMMENTS///////////////////////////////////////////////////////////////////////
//let string = "first word"
//    var string2="hi"
//string2.append(string)
//let words:[String]=["\"", "Javeria","\"", "a"]
var token_words: [String] = []
var index=0
let qt="\'"
var double_q = "\""
var multi_$="\"\"\""
var cmt = "//"
var multi_cmt_st = "/*"
var multi_cmt_end = "*/"
var next_char=0;
var EOF="~"
let br: [String]=["t", "r", "n", "0"]
while index < tokenn_words.count{
    var str=""
    next_char=index+1
    //single line string
    //multi line string
    if tokenn_words[index] == multi_${
        str.append(tokenn_words[index])
        while tokenn_words[next_char] != multi_$ && next_char < tokenn_words.count-1 && words[next_char] != EOF  {
            str.append(tokenn_words[next_char])
            next_char+=1
        }
        str.append(tokenn_words[next_char])
//        str.append(words[next_char])
        token_words.append(str)
        index=next_char+1
    }
    else if tokenn_words[index] == double_q{
        str.append(tokenn_words[index])
        while tokenn_words[next_char] != double_q && tokenn_words[next_char] != "\n" && tokenn_words[next_char] != EOF {
            str.append(tokenn_words[next_char])
            next_char+=1
        }
        str.append(tokenn_words[next_char])
        token_words.append(str)
        index=next_char+1
            
        }
    else if index<tokenn_words.count-2 && tokenn_words[index] == qt && tokenn_words[index+1] != EOF && tokenn_words[index+2]==qt{
            str.append(tokenn_words[index])
            str.append(tokenn_words[index+1])
            str.append(tokenn_words[index+2])
            token_words.append(str)
            index=next_char+2
    }
    else if tokenn_words[index] == multi_cmt_st{
        str.append(tokenn_words[index])
        while tokenn_words[next_char] != multi_cmt_end && next_char < tokenn_words.count-1 && words[next_char] != EOF  {
            str.append(tokenn_words[next_char])
            next_char+=1
        }
        str.append(tokenn_words[next_char])
//        str.append(words[next_char])
        token_words.append(str)
        index=next_char+1
    }
    else if tokenn_words[index] == cmt
    {
            str.append(tokenn_words[index])
            while tokenn_words[next_char] != "\n" && tokenn_words[next_char] != EOF && next_char < tokenn_words.count-1{
                str.append(tokenn_words[next_char])
                next_char+=1
            }
//        str.append(words[next_char])
//        token_words.append(str)
        index=next_char+1
    }
    

    else
    {
        str.append(tokenn_words[index])
        token_words.append(str)
        index+=1
    }
}

//print(token_words)

//var tokenWords = token_words
//
//tokenWords = tokenWords.filter { $0 != "`" }
//
//tokenWords
//
//
//regex practice IGNORE !!!!!!!!!!!
//
//let phoneNumber = "123-idk-abc"
//let result = phoneNumber.range(of: "^\\d{3}-\\d{3}-\\d{3}$", options: .regularExpression) == nil
//print(result)
//
//let char: String = "\"I am a \"superstar\" \""
//let result = char.range(of: #""([^"]*)""#, options: .regularExpression) == nil

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
