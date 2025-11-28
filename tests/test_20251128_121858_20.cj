/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
/*
  @Name:            02_01_11_05_a09_01

  @Level:         1

  @Assertion:       2.1.11.5(9) As the Option type is a kind of enum type, 
  the enum pattern introduced in the pattern matching expression 
  (see Enum Patterns for details) can be used to unwrap option type values.
 
  @Description:     Checks enum pattern matching 

  @Mode:            run
  @Negative:        no
  @Structure:       single

  @Comment:

*/
import utils.assert.Assert
func f(v:Option<Unit>) {
    return match(v) {
        case None => 0
        case Some(()) => 1
    }
}

main() {
    Assert.equals(0, f(None<Unit>))
}
