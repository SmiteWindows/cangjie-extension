/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Description: aux file
  
  @Structure: complex-aux

  @Module: M1

  @Dependencies:  p1/m1_p1.cj p2/m1_p2_0.cj p2/m1_p2_1.cj ../M2/p2/m2_p2.cj
*/

package m1

import p1.m1_p1
import p2.m1_p2_0
import p2.m1_p2_1
import M2.p2.m2_p2

public func m1_top() {
  println("m1")
  m1_p1()
  m1_p2_0()
  m1_p2_1()
  m2_p2()
}