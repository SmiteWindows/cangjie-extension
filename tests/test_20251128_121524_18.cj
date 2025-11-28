/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
/*
  @Name:            02_01_08_a02_01

  @Level:         1
  @Assertion:       2.1.8(2) In above, the Comparable constrains instances of type T to be
                    comparable using the relational operator, and the AddInt64 constrains
                    instances of type T can be added with values of type Int64.

  @Description:     Checks that T can be a type which implement Countable Comparable & Equatable interfaces.

  @Mode:            run
  @Negative:        no
  @Structure:       single
  @Issue:           0006079

*/

public class TestA0201 <: Countable<TestA0201> & Comparable<TestA0201> & Equatable<TestA0201> {
  public var value: Int64
  public init(val: Int64) {
    value = val
  }
  // Comparable interface
  public operator func <(rhs: TestA0201): Bool {
    value < rhs.value
  }
  public operator func >(rhs: TestA0201): Bool {
    value > rhs.value
  }
  public operator func <=(rhs: TestA0201): Bool {
    value <= rhs.value
  }
  public operator func >=(rhs: TestA0201): Bool {
    value >= rhs.value
  }
  public func compare(that: TestA0201): Ordering {
    value.compare(that.value)
  }

  // Equatable interface
  public operator func ==(that: TestA0201): Bool {
    value == that.value
  }
  public operator func !=(that: TestA0201): Bool {
    value != that.value
  }

  // Countable interface
  public func next(right: Int64): TestA0201 {
    TestA0201(value + right)
  }
  public func position(): Int64 {
    value.position()
  }
}

func range<T>(a: T, b: T, c: Int64): Range<T> where T <: Countable<T> & Comparable<T> {
  a..b
}

main() {
  let x = TestA0201(2)
  let y = TestA0201(10)
  let r1 = range(x, y, 3)
  return 0
}
