/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         01_03_07_a01_4_neg

  @Level:         1

  @Assertion:    1.3.7(1) A byte array literal can be used to denote the values of Array conveniently.
                 It consists of a leading character b, a pair of double quotes and
                 a quoted sequence of ASCII chatacters

  @Description:  Emit error for incorrect unicode chars

  @Mode:         compileonly

  @Negative:     yes

  @Structure:    single

  @Comment:

*/

main() {
    let Uni: Array<UInt8> =  b"\u{00}\u5d"
    return 0
}

