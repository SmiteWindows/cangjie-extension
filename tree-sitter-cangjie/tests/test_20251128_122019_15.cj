/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         01_04_a26_03_coal_neg_unar

  @Level:         1

  @Assertion:    1.4(26) ?? coalescing

  @Description:  Compiler emits error if ?? used as unar

  @Mode:         compileonly

  @Negative:     yes

  @Structure:    single

  @Comment: 

*/




struct Rect {
    var wid: Int32 = 10
    var len: Int32 = 20
}


main() {
    var sv:Option<Rect>;
    var re  :Rect = Rect();
    var r2 : Rect = Rect();
    r2.wid = 0; r2.len = 0;
    let nn = Option<Rect>.None
    sv = nn
    re = ?? r2;
    return 0;

}
