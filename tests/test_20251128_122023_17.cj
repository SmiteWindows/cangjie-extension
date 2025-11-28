/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:        bug_0005934_02

  @Assertion:   Issue 0005934: Compiler emit-fake error about non-initialization 
                although it was twice

  @Negative:    no

  @Structure:   single

*/


var RTZero : Int32 = 0;
    struct Rect {
        var wid: Int32 = 10
        var len: Int32 = 20
    }

main(ina :Array<String>) {
    let z : Bool = ina[0] == ""
    if (z) {RTZero = 0;}

    var sv : Rect;
    sv.wid = 10+RTZero
    sv.len = 20+RTZero
    println(sv.wid)
    println(sv.len)
    return 0;
}
