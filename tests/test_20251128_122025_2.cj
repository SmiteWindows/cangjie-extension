/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:        02_a01_165

  @Level:         1

  @Assertion:   2(1) The Cangjie Programming Language is a statically typed language, 
                i.e. type checking for ensuring safety is mostly performed at compile time.

  @Description:  Checks that attempt to assign a variable of type 'enum' to a variable of type Bool 
                 results in a compilation error.

  @Mode:         compileonly

  @Negative:     yes

  @Structure:    single

  @Comment:  

*/

enum TestEnum {
    value_1 | 
    value_2
}

main() {
    var sourceVar: TestEnum = TestEnum.value_2;
    let targetVar: Bool = sourceVar;
    return 0;
}


