/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         01_02_a02_05

  @Level:         1

  @Assertion:    1.2(2) Among them, the meaning of ; is fixed and indicates the end of an expression 
                        or declaration regardless of where it appears,and multiple expressions
                        or declarations separated by ; can be written on the same line.

  @Description:  Check that several nested conditional expressions on the same line can be separated by ';'.

  @Mode:         compileonly

  @Negative:     no

  @Structure:    single

*/
func myFunc(x: Int64, y: Int64) {
    if (x > 0) {print("x is larger than 0")}else 
    if (x < 0){print("x is lesser than 0")} else{print("x equals to 0")} ; if (y > 0) {print("y is larger than 0")}
    else if (y < 0){print("y is lesser than 0")} else{print("y equals to 0")}
}
main() {
    let x = 100
    let y = 100
    myFunc(x, y)
}
