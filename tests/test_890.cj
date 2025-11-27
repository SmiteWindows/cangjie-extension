/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         03_02_04_a08_03

  @Level:         1
  @Assertion:    3.2.4(8) If no overload occurs and cannot be overridded, an error is reported.
                 For details, see [Overriding].
                 an error is reported.
  @Mode:         compileonly
  @Negative:     yes

*/

package test

open class Base {
    func f(): Int64 { 0 } // missing 'open' modifier
}

class C <: Base {
    func f(): Int64 { 1 }
}

main() {
}
