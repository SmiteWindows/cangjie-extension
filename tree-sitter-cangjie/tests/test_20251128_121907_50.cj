/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:        01_03_06_a05_004

  @Level:         1

  @Assertion:   1.3.6(5) A multi-line string literal consists of zero or more valid characters 
                (except alone character \ and non-escaped characters """) enclosed by a pair 
                of three double quote characters ("""), 
                which begins after the line terminator of beginning double quotations 
                and ends before the first matched non-escaped ending double quotations.

  @Description:  Checks that multi-line string literal cannot be represented with 
                 non-escape character """;

  @Mode:         compileonly

  @Negative:     yes

  @Structure:    single

  @Comment:  

*/

main(){
    let stringValue:String = """
"""
""";
    return 0;
}

