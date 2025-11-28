/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:      02_01_05_a03_03

  @Level:         1

  @Assertion: 2.1.5(3)
              If a function call takes an argument of type Nothing, other arguments following that argument will not
              be evaluated and the function call itself will not be executed;

  @Description: Check that if function call takes an argument of type Nothing, other arguments following that argument
                will not be evaluated and the function call itself will not be executed. Check return.

  @Mode: run

  @Negative: no

  @CompileWarning: Ignore  

  @Comment: The only expressions which have Nothing type are: break, continue, return and throw.

*/

import utils.assert.Assert

var evalOrderCounter = 0
var evalOrderA = 0
var evalOrderB = 0
var evalOrderF = 0

class A {}

class B {}

func makeA() {
    evalOrderCounter++
    evalOrderA = evalOrderCounter

    return A()
}

func makeB() {
    evalOrderCounter++
    evalOrderB = evalOrderCounter

    return B()
}

func foo(a: A, x: Nothing, b: B) {
    evalOrderCounter++
    evalOrderF = evalOrderCounter
}

func test() {
    foo(makeA(), return, makeB())
}

main() {
    test()

    // Argument before Nothing is evaluated.
    Assert.equals(1, evalOrderA)

    // Argument after Nothing is not evaluated.
    Assert.equals(0, evalOrderB)

    // foo is not executed.
    Assert.equals(0, evalOrderF)
}

