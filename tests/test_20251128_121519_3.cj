/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
   @Name:        02_01_07_a05_04

  @Level:         1
   @Assertion:   2.1.7(5) If each TypeK in (Type1, Type2, ..., TypeN) supports equality (inequality)
                 comparison == (!=) , the tuple type (Type1, Type2, ..., TypeN) supports == (!=);
                 otherwise, it does not support == (!=), and a compilation error will be reported
                 when == (!=) is used.
   @Description: Check that tuple can be compared if internal type can not be compared.
   @Mode:        compileOnly
   @Negative:    yes
   @Structure:   single
 */

enum HandGame {
    ROCK | PAPER | SCISSORS
}

main() {
    var t1: (Rune, HandGame) = ('a', HandGame.SCISSORS)
    ('b', HandGame.SCISSORS) != t1

    return 0
}
