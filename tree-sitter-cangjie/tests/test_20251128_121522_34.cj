/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

macro package utils.macros

import std.ast.*

// For enums and tuples only.
// Only these use cases are allowed:
//     case: enum E { A | B | C(Int64) }
//
//     1. @notMatchOrThrow[A](B)
//     2. @notMatchOrThrow[C(42)](B)
//     3. @notMatchOrThrow[C(_)](B)
//     4. let enumVar = B
//        @notMatchOrThrow[A](enumVar)
//     5. @notMatchOrThrow[(0, 0)]((0, 1))
//     6. @notMatchOrThrow[(_, 0)]((0, 1))
//     7. let tupleVar = (1, 1)
//        @notMatchOrThrow[(0, 0)](tupleVar)
// Square brackets should not contain variables, function calls, or other expressions.
// Forbidden:
//     1. let enumVar = B
//        @notMatchOrThrow[enumVar](A)  // unreachable pattern warning, variable in []
//     2. @notMatchOrThrow[_](A)        // unreachable pattern warning, meaningless
//     3. @notMatchOrThrow[C(x)](A)     // meaningless, use wildcard "_" instead of "x"
//     4. let tupleVar = (1, 1)
//        @notMatchOrThrow[tupleVar]((0, 0))  // unreachable pattern warning, variable in []
//     5. @notMatchOrThrow[(_, _)]((0, 0))    // unreachable pattern warning, meaningless
//     6. @notMatchOrThrow[(x, 0)]((1, 1))    // use wildcard "_" instead of "x"
//     7. @notMatchOrThrow[0](1)  // use Assert.notEquals(0, 1)
public macro notMatchOrThrow(unexpected: Tokens, actual: Tokens) {
    let errorMsg = "Macro 'notMatchOrThrow' failed: unexpected='${unexpected}', actual='${actual}'"
    quote(match ($(actual)) {
              case $(unexpected) => throw Exception($errorMsg)
              case _ => ()
          })
}

// For enums and tuples only.
// Only these use cases are allowed:
//     case: enum E { A | C(Int64) }
//
//     1. @matchOrThrow[A](A)
//     2. @matchOrThrow[C(0)](C(0))
//     3. @matchOrThrow[C(_)](C(0))
//     4. let enumVar = A
//        @matchOrThrow[A](enumVar)
//     5. @matchOrThrow[(0, 0)]((0, 0))
//     6. @matchOrThrow[(_, 0)]((0, 0))
//     7. let tupleVar = (0, 0)
//        @matchOrThrow[(0, 0)](tupleVar)
// Square brackets should not contain variables, function calls, or other expressions.
// Forbidden
//     1. let enumVar = A
//        @matchOrThrow[enumVar](A)  // unreachable pattern warning, variable in []
//     2. @matchOrThrow[_](A)        // unreachable pattern warning, meaningless
//     3. @matchOrThrow[C(x)](C(0))  // meaningless, use wildcard "_" instead of "x"
//     4. let tupleVar = (0, 0)
//        @notMatchOrThrow[tupleVar]((0, 0))  // unreachable pattern warning, variable in []
//     5. @notMatchOrThrow[(_, _)]((0, 0))    // unreachable pattern warning, meaningless
//     6. @notMatchOrThrow[(x, 0)]((0, 0))    // use wildcard "_" instead of "x"
//     7. @matchOrThrow[0](0)  // use Assert.equals(0, 0)
public macro matchOrThrow(expected: Tokens, actual: Tokens) {
    let errorMsg = "Macro 'matchOrThrow' failed: expected='${expected}', actual='${actual}'"
    quote(match ($(actual)) {
              case $(expected) => ()
              case _ => throw Exception($errorMsg)
          })
}
