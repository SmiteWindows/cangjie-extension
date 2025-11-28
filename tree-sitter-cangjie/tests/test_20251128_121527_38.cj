/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         01_04_a27_03_pipeline_neg_2

  @Level:         1

  @Assertion:    1.4(27) |> Pipeline
 
  @Description:  Checks that compiler emits error for the bad pipeline sign

  @Mode:         compileonly

  @Negative:     yes

  @Structure:    single

  @Comment:

*/




func f2(x: Int32): Int32 { x + x }

main () {
    let a: Int32 = 1
    var res = a >| f2
}

