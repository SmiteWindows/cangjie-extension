/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
/*
  @Name:            02_01_11_01_a10_01

  @Level:         1
  @Assertion:       2.1.11.1(10) Overloading of constructor is supported in the same enum, but only the number of
parameters is involved in the overloading, not the type of parameters, multiple constructors of
the same name are allowed to be defined in the same enum, but they are required to have
different number of parameters (despite the fact that the constructor without parameters is not of
a function type, it can still be overloaded with other constructors).

  @Description:     Checks that it is possible to define many enum constructors with the same name 
  but different number of parameters

  @Mode:            run
  @Negative:        no
  @Structure:       single

  @Comment:

*/

enum E {
    | F | F(Unit) | F(Rune, E) | F(() -> String, String, (String, String)) | F(Bool, Int8, Int16, Int32)
}

func S() { "foo" }

main() {
    let a = F
    let b = F(())
    let c = F(r'a', F)
    let d = F(S, "bar", ("boo", "biuz"))
    let e = F(true, 1, 2, 3)
}
