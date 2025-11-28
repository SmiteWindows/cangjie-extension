/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         01_02_a02_01

  @Level:         1

  @Assertion:    1.2(2) Among them, the meaning of ; is fixed and indicates the end of an expression
                        or declaration regardless of where it appears, and multiple expressions
                        or declarations separated by ; can be written on the same line.

  @Description:  Check that several function declarations on the same line can be separated by ';'.

  @Mode:         compileonly

  @Negative:     no

  @Structure:    single

*/

main() {
    func F1() {} ; func F2() {} ; func F3() {} ;
    F1();F2();F3();
}
