# SwiftPCG
A pure Swift implementation of the [PCG](http://www.pcg-random.org) psuedo random number generator

```swift
var rng = PCGRand32(state: 123)

print(rng.next()) // 355248013
```

PCG is a high quality number generator that allows you to generate high quality random numbers reproducibly based off of a seed.

