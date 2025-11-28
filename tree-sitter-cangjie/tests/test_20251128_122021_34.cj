/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:      bug_0005901

  @Assertion: Issue 0005901: Type name is not shadowed in match case

  Rejected by Huawei 2023.05.15: because the is expression is expr is type. 
  Type semantically only looks for type definitions (including built-in types 
  and top-level type declarations) so only struct T is found. The semantics of 
  expr is name reference search. Local variable T at case T is found first by 
  scope. Because case T has a high scope, the top-level declaration of struct 
  T with the same name is covered. Therefore, the semantic result of the is 
  expression is'case T'is'struct T', which complies with the semantic rules 
  and no error is reported.

  @Description: Checks that compile error is not thrown as the issue was rejected.

  @Mode:      Compileonly

  @Negative:  No
*/

struct T { }

main() {
    var x: T = T()
    match (x) {
        case T => println(T is T) // must be compile error: 'T' is not a type
    }
}
