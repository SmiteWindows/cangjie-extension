/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:        02_a01_213

  @Level:         1

  @Assertion:   2(1) The Cangjie Programming Language is a statically typed language, 
                i.e. type checking for ensuring safety is mostly performed at compile time.

  @Description:  Checks that attempt to assign a value of type Rune to a variable of type struct
                 results in a compilation error.

  @Mode:         compileonly

  @Negative:     yes

  @Structure:    single

  @Comment:  

*/

struct TestStruct {
    var field_01: Int64;
    var field_02: Int16;
    init(field_01: Int64, field_02: Int16) {
        this.field_01 = field_01
        this.field_02 = field_02
    };
}

main() {
    var sourceVar: Rune = 'Z';
    let targetVar: TestStruct = sourceVar;
    return 0;
}


