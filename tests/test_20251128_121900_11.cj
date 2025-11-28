/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:        02_01_09_a05_05

  @Level:         1

  @Assertion:   2.1.9(5)
                 () -> Int32 // A function type has an empty parameter type list, 
                                and its return value type is 'Int32'.
                 () -> Unit // A function type has an empty parameter type list, 
                               and its return value type is 'Unit'.
                 (Float32) -> Int32 // A function type has one parameter whose type is 'Float32', 
                                       and its return value type is 'Int32'
                 (Int32, Int32, Float32) -> Int32 // A function type has three parameters, 
                                                     and its return value type is 'Int32'
                 (Int32, Int32, Float32) -> (Int32, Int32) // A function type has three parameters, 
                                                              and its return value type is '(Int32, Int32)'
                 (Int32, Int32, Float32) -> Unit // A function type has three parameters, 
                                                    and its return value type is 'Unit'.

  @Description: Checks that variable of type Int32 cannot be assigned by
                by value returned by function of '() -> Unit' type;

  @Mode:        compileonly
  @Negative:    yes
  @Structure:   single

*/

type funcType = () -> Unit;

func testFunc(): Unit {
}

main() {
    let funcVar: funcType = testFunc;
    var int32Var: Int32 = testFunc();
    return 0;
}

