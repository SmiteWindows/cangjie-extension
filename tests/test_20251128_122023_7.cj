/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         02_01_06_01_a01_01

  @Level:         1

  @Assertion:    2.1.6.1(1) The String literals in the Cangjie programming language can be divided into three 
                 categories: single-line string literals, multi-line string literals and multi-line raw string 
                 literals. See section String Literals for the syntax of String literals.

  @Description:  Check that variable declaration using right syntax will not produce error on compilation.

  @Mode:         run

  @Negative:     no

  @Structure:    single

  @Comment:      

*/
import utils.assert.Assert

public let myPublicTopLetSingleLine: String = ""
public var myPublicTopVarSingleLine: String = "!dsfghf\u{1102}wq eg"
public let myPublicTopLetMultyLine: String = """
\raw\t
"""
public var myPublicTopVarMultyLine: String = """
serpog9$%%%
\f
"""
public let myPublicTopLetRawMultyLine: String = #####""#####
public var myPublicTopVarRawMultyLine: String = #"
\u{1102})&#uh\u{1117}
"#

let myTopLetSingleLine: String = "^5^-03-4kmv \""
var myTopVarSingleLine: String = " 09u \u{1111}"
let myTopLetMultyLine: String = """
wqeftwe \\
"""
var myTopVarMultyLine: String = """
"""
let myTopLetRawMultyLine: String = ##""##
var myTopVarRawMultyLine: String = #"
seryfgt57665e34zz
"#

class myClass{
    static let myStaticLetSingleLine: String = "awfda"
    static var myStaticVarSingleLine: String = "abc\u{1112}"
    static let myStaticLetMultyLine: String = """
  (&^$im)
  """
    static var myStaticVarMultyLine: String = """
  QQQQ(&^$im)buwej'0
  """
    static let myStaticLetRawMultyLine: String = #"
  "#
    static var myStaticVarRawMultyLine: String = ###"
  wqaefwe
  "###

    public let myPublicLetSingleLine: String = "\" sdgsdg \""
    public var myPublicVarSingleLine: String = ""
    public let myPublicLetMultyLine: String = """
  """
    public var myPublicVarMultyLine: String = ""
    public let myPublicLetRawMultyLine: String = ###"
  waegre67ky7gyh
  \b \n \'
  "###
    public var myPublicVarRawMultyLine: String = ""
    protected let myProtectedLetSingleLine: String = ""
    protected var myProtectedVarSingleLine: String = ""
    protected let myProtectedLetMultyLine: String = """
  #"""
    protected var myProtectedVarMultyLine: String = ""
    protected let myProtectedLetRawMultyLine: String = #####"
  wqedvdfdf
  !)!)!)! 35454gbfx dgfdgfdf
  we
  "#####
    protected var myProtectedVarRawMultyLine: String = ""
    private let myPrivateLetSingleLine: String = "dsgdrsh"
    private var myPrivateVarSingleLine: String = ""
    private let myPrivateLetMultyLine: String = """
  """
    private var myPrivateVarMultyLine: String = ""
    private let myPrivateLetRawMultyLine: String = ###"
  wqaefwe$$$$

  wefwer
  )($) 
  \u{175}
  "###
    private var myPrivateVarRawMultyLine: String = ""
    let myLetSingleLine: String = "\""
    var myVarSingleLine: String = ""
    let myLetMultyLine: String = """
    q34df
    asddf
    !!!
    erhgers
  """
    var myVarMultyLine: String = ""
    let myLetRawMultyLine: String = #"

      wa4*09734k1!!!

  "#
    var myVarRawMultyLine: String = ##""##
    myClass(inVal1: String, inVal2: String, inVal3: String){
        this.myPublicVarSingleLine = inVal1
        this.myPublicVarMultyLine = inVal2
        this.myPublicVarRawMultyLine = inVal3
        this.myProtectedVarSingleLine = inVal1
        this.myProtectedVarMultyLine = inVal2
        this.myProtectedVarRawMultyLine = inVal3
        this.myPrivateVarSingleLine = inVal1
        this.myPrivateVarMultyLine = inVal2
        this.myPrivateVarRawMultyLine = inVal3
        this.myVarSingleLine = inVal1
        this.myVarMultyLine = inVal2
        this.myVarRawMultyLine = inVal3
    }
    func checkVal() {
        Assert.equals(this.myPublicLetSingleLine,"\" sdgsdg \"")
        Assert.equals(this.myPublicVarSingleLine,myPublicTopVarSingleLine)
        Assert.equals(this.myPublicLetMultyLine,"""
  """)
        Assert.equals(this.myPublicVarMultyLine,myPublicTopVarMultyLine)
        Assert.equals(this.myPublicLetRawMultyLine,###"
  waegre67ky7gyh
  \b \n \'
  "###)
        Assert.equals(this.myPublicVarRawMultyLine,myPublicTopVarRawMultyLine)
        Assert.equals("", this.myProtectedLetSingleLine)
        Assert.equals(this.myProtectedVarSingleLine,myPublicTopVarSingleLine)
        Assert.equals(this.myProtectedLetMultyLine,"""
  #""")
        Assert.equals(this.myProtectedVarMultyLine,myPublicTopVarMultyLine)
        Assert.equals(this.myProtectedLetRawMultyLine, #####"
  wqedvdfdf
  !)!)!)! 35454gbfx dgfdgfdf
  we
  "#####)
        Assert.equals(this.myProtectedVarRawMultyLine,myPublicTopVarRawMultyLine)
        Assert.equals("dsgdrsh", this.myPrivateLetSingleLine)
        Assert.equals(this.myPrivateVarSingleLine,myPublicTopVarSingleLine)
        Assert.equals(this.myPrivateLetMultyLine,"""
  """)
        Assert.equals(this.myPrivateVarMultyLine,myPublicTopVarMultyLine)
        Assert.equals(this.myPrivateLetRawMultyLine,###"
  wqaefwe$$$$

  wefwer
  )($) 
  \u{175}
  "###)
        Assert.equals(this.myPrivateVarRawMultyLine,myPublicTopVarRawMultyLine)
        Assert.equals(this.myLetSingleLine,"\"")
        Assert.equals(this.myVarSingleLine,myPublicTopVarSingleLine)
        Assert.equals(this.myLetMultyLine,"""
    q34df
    asddf
    !!!
    erhgers
  """)
        Assert.equals(this.myVarMultyLine,myPublicTopVarMultyLine)
        Assert.equals(this.myLetRawMultyLine,#"

      wa4*09734k1!!!

  "#)
        Assert.equals(this.myVarRawMultyLine,myPublicTopVarRawMultyLine)
    }
}

func retMultiLine(inVal: String){
    inVal
}

main() {
    let myLocalLetSingleLine: String = ""
    var myLocalVarSingleLine: String = "<" + myLocalLetSingleLine
    let myLocalLetMultyLine: String = """
  AAAA
  """
    var myLocalVarMultyLine: String = """
  AAAA  
  \u{1125}""" + "###"
    let myLocalLetRawMultyLine: String = ##"
  1^%3487gwef
  "##
    var myLocalVarRawMultyLine: String = #"
  234g1^%3487gwef
  "#

    Assert.equals("", myLocalLetSingleLine)
    Assert.equals("<", myLocalVarSingleLine)
    Assert.equals(myLocalLetMultyLine,"""
  AAAA
  """)
    Assert.equals(myLocalVarMultyLine,"""
  AAAA  
  \u{1125}""" + "###")
    Assert.equals(myLocalLetRawMultyLine,##"
  1^%3487gwef
  "##)
    Assert.equals(myLocalVarRawMultyLine,##"
  234g1^%3487gwef
  "##)

    Assert.equals(myTopLetSingleLine,"^5^-03-4kmv \"")
    Assert.equals(myTopVarSingleLine," 09u \u{1111}")
    Assert.equals(myTopLetMultyLine,"""
wqeftwe \\
""")
    Assert.equals(myTopVarMultyLine,"""
""")
    Assert.equals(myTopLetRawMultyLine,##""##)
    Assert.equals(myTopVarRawMultyLine,#"
seryfgt57665e34zz
"#)

    var myTmpVar = retMultiLine(myLocalLetMultyLine)
    Assert.equals(myTmpVar,myLocalLetMultyLine)

    Assert.equals("awfda", myClass.myStaticLetSingleLine)
    Assert.equals(myClass.myStaticVarSingleLine,"abc\u{1112}")
    Assert.equals(myClass.myStaticLetMultyLine,"""
  (&^$im)
  """)
    Assert.equals(myClass.myStaticVarMultyLine,"""
  QQQQ(&^$im)buwej'0
  """)
    Assert.equals(myClass.myStaticLetRawMultyLine,#"
  "#)
    Assert.equals(myClass.myStaticVarRawMultyLine,###"
  wqaefwe
  "###)

    myLocalVarSingleLine = myClass.myStaticLetSingleLine
    Assert.equals(myLocalVarSingleLine,myClass.myStaticLetSingleLine)

    let myClassImpl = myClass(myPublicTopVarSingleLine,myPublicTopVarMultyLine,myPublicTopVarRawMultyLine)
    myClassImpl.checkVal()
    var myArr: Array<Rune> = [r'd',r'g', r'E']
    var myStringFromArr: String = ""
    for(arrItem in myArr) {
        myStringFromArr = myStringFromArr + "${arrItem}"
    }
    myStringFromArr = """
  ${myStringFromArr}
  """
    Assert.equals(myStringFromArr,"""
  dgE
  """)
}
