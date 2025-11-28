/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         02_01_06_01_a02_09

  @Level:         1

  @Assertion:    2.1.6.1(2) A single-line string literal consists of zero or more characters (except non-escaped 
                 character " and alone character \) enclosed by a pair of double quote character (i.e., ").
                 Furthermore, a single-line string literal can only be written on the same line.

  @Description:  Mutable top-level variable with alone character \.

  @Mode:         compileonly

  @Negative:     yes

  @Structure:    single

  @Comment:      

*/
var myTopVarSingleLine: String = "\"

main() {
}