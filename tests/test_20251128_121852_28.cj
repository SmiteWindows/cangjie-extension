/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         02_01_06_01_a05_01

  @Level:         1

  @Assertion:    2.1.6.1(5) There must be a line terminator after the beginning double quotations,
                 otherwise a compiler error is reported.

  @Description:  Positive variants of multy-line string literals usage.

  @Mode:         run

  @Negative:     no

  @Structure:    single

  @Comment:      

*/
import utils.assert.Assert

public var testA0501: String = """
d;ojla"""

class myClass{
  public var myPublicClassMemberMultyStringLiteral = """
    qawtgas

   >

  \r\n\u{1112}"""
  private var myPrivateClassMemberMultyStringLiteral = ""

  myClass(inVal: String){
    this.myPrivateClassMemberMultyStringLiteral = inVal
  }
  func myClassFunc(){
    this.myPrivateClassMemberMultyStringLiteral
  }
}
func myFunc(){
  """
    akflkshg
  
  
  
  """
}
main() {
  var myLocalLevelMultyStringLiteral: String = """
    g \fdsv
\v
    wqef we
  """
  Assert.equals(myLocalLevelMultyStringLiteral, """
    g \fdsv
\v
    wqef we
  """)
  myLocalLevelMultyStringLiteral = myFunc()
  var myClassImpl = myClass(myLocalLevelMultyStringLiteral)
  let myLetVar = myClassImpl.myClassFunc()
  Assert.equals(myLocalLevelMultyStringLiteral, myLetVar)
}