/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
/*
  @Name:            bug_0006113
  @Assertion:       ArrayIndexOutOfBoundsException or IndexOutOfBoundsException?

  @Description:     This is an example from the spec that doesn't work.

  @Mode:            run
  @Negative:        no
  @Structure:       single
  @CompileWarning:  ignore

  @Comment:         SpecBug v0.22.14. Verified for the Compiler v0.38.2
*/

// Caught by catchE().
func catchE() {
    let listTest = [0, 1, 2]
    try {
        throwE() // caught by catchE()
    } catch (e: ArrayIndexOutOfBoundsException) {
        print("an ArrayIndexOutOfBoundsException happened: " + e.toString())
    }
}

// Terminate function is executed.
func notCatchE() {
    let listTest = [0, 1, 2]
    throwE()
}

func throwE() {
    throw IndexOutOfBoundsException()
}

main() {
    catchE()
    notCatchE()
    0
}
