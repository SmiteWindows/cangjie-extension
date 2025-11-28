/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
   @Name:        02_01_07_01_a01_01

  @Level:         1
   @Assertion:   2.1.7.1(1) The Tuple literal has the format (expr1, expr2, ..., exprN), 
                 in which multiple expressions are separated by commas and each expression 
                 can have a different types. The syntax of Tuple literal is defined as:
                 tupleLiteral
                    : '(' expression (',' expression)+ ')'

   @Description: Check the '(expression, expression)' variant.
   @Mode:        run
   @Negative:    no
   @Structure:   single
 */

import utils.assert.Assert

func my() {
    "Hi"
}

struct R1 {
    let smth = 123
}

enum HandGame {
    ROCK | PAPER | SCISSORS
}

open class C1 {
    var some = 321
}

func getInt64() {
  123
}

func getInt16() {
  12_i16
}

func getFloat64() {
  123.123e-1
}

func getFloat16() {
  13.31e1_f16
}

main() {
    var r1 = R1()
    var c1 = C1()

    Assert.isTrue((1+1, getFloat64()) is (Int64, Float64))
    Assert.isTrue((1 ^ 2, 2.2 ** 3) is (Int64, Float64))
    Assert.isTrue((getInt64(), 2.0 + 2.0) is (Int64, Float64))
    Assert.isTrue((false || true, "2.0" + "2.0") is (Bool, String))
    Assert.isTrue((getFloat16(), getFloat16) is (Float16, ()->Float16))
    Assert.isTrue((getInt64(), getInt16(), getFloat16(), getFloat64()) is (Int64, Int16, Float16, Float64))
    Assert.isTrue((my(), r'f') is (String, Rune))
    Assert.isTrue(([3,2,1], r1) is (Array<Int64>, R1))
    Assert.isTrue((c1, 6..66:2) is (C1, Range<Int64>))
    Assert.isTrue((HandGame.ROCK, HandGame.PAPER) is (HandGame, HandGame))

    Assert.isTrue(((HandGame.ROCK, HandGame.PAPER), (c1, 6..66:2)) is ((HandGame, HandGame), (C1, Range<Int64>)))
    return 0
}
