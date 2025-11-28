/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         02_01_06_02_a03_01

  @Level:         1

  @Assertion:    2.1.6.2(3) Each interpolation expression in the string literal is wrapped in a pair of {}, and prefixed by $.

  @Description:  Check different variants of interpolated strings

  @Mode:         run

  @Negative:     no

  @Structure:    single

  @Comment:      Need more variants

*/
import utils.assert.Assert

public let myPublicTopLet0: String = "asdg${ 2 + 2 }adsg"
public let myPublicTopLet: String = """
    aqwf4sdg
    ${ 'F' }a
    dsg
"""
public var myPublicTopVar: String = "SDRH==R${6*5}"

let myTopLet: String = "${'g'}"
var myTopVar: String = """
${0x1.1p0} """

class myClass{
  static public let letStaticPublic: String = "ds${2*9} ${12.6 / 3.0} fk"
  static public var varStaticPublic: String = """
  
          ${letStaticPublic}  
  we$tdcxsd ${letStaticPublic}  
  
  """

  protected var varProtected = ""

  public let letPublic: String = "90${ 8 - 3 }wefkl"
  public var varPublic: String = """
  34dsd ${letPublic} fvd@f
  """
  myClass(inVal: Int64){
    this.varProtected = "m${inVal}a*s ${letPublic}  we"
  }
  func checkValues(){
    Assert.isTrue(this.letPublic == "905wefkl")
    Assert.isTrue(this.varPublic == """
  34dsd 905wefkl fvd@f
  """)
    Assert.isTrue(this.varProtected == "m2a*s 905wefkl  we")
  }
}
struct myStruct {
  public var myPublicVarString: String
  private var myPrivateVarString: String
  public let myPublicLetString: String
  private let myPrivateLetString: String
  var myVarString: String
  let myLetString: String
  myStruct(inVal: Int64){
    this.myPublicVarString= "${inVal}"
    this.myPrivateVarString = """
      23)fdsv
      ${inVal}
    
    """
    this.myPublicLetString = "${this.myPublicVarString}"
    this.myPrivateLetString = "${inVal}"
    this.myVarString = """
    ${inVal}  ${4 - 6} ${this.myPublicVarString}"""
    this.myLetString = "${inVal}"
  }
  func checkValues(){
    Assert.isTrue(this.myPublicVarString == "12")
    Assert.isTrue(this.myPrivateVarString == """
      23)fdsv
      12
    
    """)
    Assert.isTrue(this.myPublicLetString == "12")
    Assert.isTrue(this.myPrivateLetString == "12")
    Assert.isTrue(this.myVarString == """
    12  -2 12""")
    Assert.isTrue(this.myLetString == "12")

  }
}
func myStringFunc(inVal: String) {
  "myFunc retVal is ${inVal}"
}
func myMultyStringFunc(inVal: String) {
  """
  myFunc retVal is:
  !!!!!!!!!!!!!!!!${inVal}!!!!!!!!!!!!!!!!!!!!!!!!!!!
  """
}
main() {
  Assert.isTrue(myPublicTopLet0 == "asdg4adsg")
  Assert.isTrue(myPublicTopLet == """
    aqwf4sdg
    Fa
    dsg
""")
  Assert.isTrue(myPublicTopVar == "SDRH==R30")
  Assert.isTrue(myTopLet == "g")
  Assert.isTrue(myTopVar == """
1.062500 """)

  let myFloatLet = 12.55
  let myAnotherFloatLet = 0.55
  let myLet: String = "12dds ${myFloatLet} != ${myAnotherFloatLet} v"
  Assert.isTrue(myLet == "12dds 12.550000 != 0.550000 v")
  var myVar: String = "${myAnotherFloatLet}"
  Assert.isTrue(myVar == "0.550000")

  var myTupleVar = ("sdgd", 'Y', true, 18, 22.0)
  var myTuplePresentation = """
  1: ${myTupleVar[0]}
  2: ${myTupleVar[1]}
  3: ${myTupleVar[2]}
  4: ${myTupleVar[3]}
  5: ${myTupleVar[4]}
  """
  Assert.isTrue(myTuplePresentation == """
  1: sdgd
  2: Y
  3: true
  4: 18
  5: 22.000000
  """)

  myVar = myStringFunc(myLet)
  Assert.isTrue(myVar == "myFunc retVal is 12dds 12.550000 != 0.550000 v")
  myVar = myMultyStringFunc(myLet)
  Assert.isTrue(myVar == """
  myFunc retVal is:
  !!!!!!!!!!!!!!!!12dds 12.550000 != 0.550000 v!!!!!!!!!!!!!!!!!!!!!!!!!!!
  """)

  var myCharVar = "C"
  myCharVar = "${myCharVar}"
  Assert.isTrue(myCharVar == "C")

  let myArr: Array<Rune> = [r'r',r'T', r'\u{00A7}']
  var myFromArrayVar = ""
  for(charItem in myArr) {
    myFromArrayVar = myFromArrayVar + "${charItem}"
  }
  Assert.isTrue(myFromArrayVar == "rT§")

  Assert.isTrue(myClass.letStaticPublic == "ds18 4.200000 fk")
  Assert.isTrue(myClass.varStaticPublic == """
  
          ds18 4.200000 fk  
  we$tdcxsd ds18 4.200000 fk  
  
  """)

  var myStructImpl = myStruct(12)
  myStructImpl.checkValues();
  var myClassImpl = myClass(2)
  myClassImpl.checkValues();
}