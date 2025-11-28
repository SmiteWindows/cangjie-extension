/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
   @Name:         02_01_04_a02_40

  @Level:         1

   @Assertion:    2.1.4(2) Except the = operator (an expression with Unit type can be assigned 
                  to a variable with Unit type), the equal (==) operator and the not equal (!=) operator, 
                  there are no other operators defined for Unit. Therefore, any operation 
                  (other than the above three operations) that is performed on Unit type is invalid.

   @Description:  Check that operator += is not defined for Unit

   @Mode:         compileonly

   @Negative:     yes

   @Structure:    single

*/

func foo(): Unit {
  print("foo") 
}

main() {
  var u1: Unit
  u1 = foo()
  u1 += u2
  return 0
}
