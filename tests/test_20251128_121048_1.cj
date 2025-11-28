/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
/*
  @Description:     Contains a struct with only one public primary constructor.

  @Structure:       complex-aux
  @CompileWarning:  no
*/

package p3

public struct AuxTestA0303 {
    public AuxTestA0303(public let v: Int64) {}
}

public func test() {
    // A public primary constructor is visible inside its package.
    AuxTestA0303(1)
}
