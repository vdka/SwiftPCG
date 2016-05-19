
/// Generates 32 bit Psuedo Random numbers in a reproducible way using a (PCG)[http://www.pcg-random.org/] RNG
public struct PCGRand32 {
  public var state: UInt64
  public var increment: UInt64

  /// Create a new RNG with a given state
  public init(state: UInt64 = Constant.defaultSeed, increment: UInt64 = Constant.defaultIncrement) {
    self.state = state
    self.increment = increment
  }

  private enum Constant {
    static let multiplier: UInt64 = 6364136223846793005
    static let defaultSeed: UInt64 = 0x853c49e6748fea9b
    static let defaultIncrement: UInt64  = 0xda3e39cb94b95bdb
  }

  /// Returns the next Psuedo random number from this RNG
  public mutating func next() -> UInt32 {

    // get the old state
    let oldState = state

    /// Advance internal state
    state = nextState(state)

    // get a xorShift?
    let xorShifted = UInt32(truncatingBitPattern: ((oldState >> 18) ^ oldState) >> 27)

    // get a rot?
    let rot = UInt32(truncatingBitPattern: oldState >> 59)

    //// Calculate output function (XSH RR), uses old state for max ILP
    let transform = (xorShifted >> rot) | (xorShifted << ((~rot &+ 1) & 31))

    // return the transform
    return transform
  }

  /// :nodoc:
  private func nextState(_ input: UInt64) -> UInt64 {
    return state &* Constant.multiplier &+ increment
  }

}

