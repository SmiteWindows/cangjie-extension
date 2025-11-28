/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         01_02_a02_09

  @Level:         1

  @Assertion:    1.2(2) Among them, the meaning of ; is fixed and indicates the end of an expression
                        or declaration regardless of where it appears, and multiple expressions
                        or declarations separated by ; can be written on the same line.

  @Description:  Check that several literals on the same line can be separated by ';'.

  @Mode:         compileonly

  @Negative:     no

  @CompileWarning: Ignore

  @Structure:    single

*/

main(): Int64 {
    10u8;10i16;1024u32;1024;1024.512_f32;1024.512;'a';b'a';true;"Cangjie";[1, 2, 3];(1, 2, 3)
    return 0
}
