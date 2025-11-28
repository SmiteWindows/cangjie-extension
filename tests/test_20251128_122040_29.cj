/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         02_01_06_02_a10_01

  @Level:         1

  @Assertion:    2.1.6.2(10) Interpolation expressions also support user-defined types, as long as the type implements the ToString interface.

  @Description:  Check that user-defined types with implemented ToString interface can be used in interpolation expressions.

  @Mode:         run

  @Negative:     no

  @Structure:    single

  @Comment:      

*/
import utils.assert.Assert

open class myClass <: ToString {
  var myVar = "AAA"
  myClass() {}
  public func toString(){
    this.myVar
  }
}

class myAnotherClass <:myClass {
  myAnotherClass() {}
}

struct myStruct <: ToString {
  private var mySructVar = "${ 3 - 2 }"
  public func toString(){
    this.mySructVar
  }
}

main() {
  var myClassImpl = myClass()
  let myExpr0 = "${myClassImpl}"
  Assert.equals("AAA", myExpr0)
  var myAnotherExpr = """
  ${myAnotherClass()}"""
  Assert.equals("""
  AAA""", myAnotherExpr)

  myAnotherExpr = "${myStruct()}"
  Assert.equals("1", myAnotherExpr)

}