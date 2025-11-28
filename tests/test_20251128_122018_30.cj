/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         01_04_a03_15_member_access_neg_1

  @Level:         1

  @Assertion:    1.4(3) . Member access [] Index access () Function call

  @Description:  Emit error if selected unexisted member

  @Mode:         compileonly

  @Negative:     yes

  @Structure:    single

  @Comment:      On moment need to write implicit init struct var 
                 var sv : Rect = Rect(), otherwise compile error
                 error: variable 'sv' is used before initialization

*/


struct Rect {
    var wid: Int32 = 10
    var len: Int32 = 20
}

main(ina :Array<String>) {
    var sv : Rect = Rect();
    sv.wid1 = sv.wid
    sv.len = sv.len1+ 1
    return 0;
}
