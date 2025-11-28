/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         03_03_01_a20_05

  @Level:         1

  @Assertion:    3.3.1(20) In addition to the preceding syntax definitions, local variables may be introduced 
                 in the following scenarios: Pattern between for and in in the for-in loop expression. 
                 For details, see The for-in Expression.

  @Description:  Check that local variable introduced in for-in expression is not visible before the for-in 
                 expression inside method "main"

  @Mode:         compileonly

  @Negative:     yes

  @Structure:    single

*/

type MyArrItemType = (Int64, Rune)

main() {
    let myArr: Array<MyArrItemType> = [
        (28, 'H'),
        (64, 'P'),
        (-5, 'Q'),
        (22, 'v'),
        (1793, 'T'),
        (0, 'm')
    ]

    print("${x}")
    for( (x:Int64, _) in myArr) {
        print("${x}")
    }
}
