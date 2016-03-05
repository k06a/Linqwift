# Linqwift

[![CI Status](http://img.shields.io/travis/k06a/Linqwift.svg?style=flat)](https://travis-ci.org/k06a/Linqwift)
[![Version](https://img.shields.io/cocoapods/v/Linqwift.svg?style=flat)](http://cocoapods.org/pods/Linqwift)
[![License](https://img.shields.io/cocoapods/l/Linqwift.svg?style=flat)](http://cocoapods.org/pods/Linqwift)
[![Platform](https://img.shields.io/cocoapods/p/Linqwift.svg?style=flat)](http://cocoapods.org/pods/Linqwift)

Just imagine the power of LINQ on iOS and OS X platforms.

Main objective is to implement all of these methods:
http://msdn.microsoft.com/en-us/library/system.linq.enumerable_methods.aspx

##Implemented Features

####Main Methods
```
func Where(predicate: (T)->Bool) -> AnySequence<T>
func Where(predicate: (T,Int)->Bool) -> AnySequence<T>
func Select<U>(transform: (T)->U) -> AnySequence<U>
func Select<U>(transform: (T,Int)->U) -> AnySequence<U>
func Distinct<U where U: Hashable>(transform: (T)->U) -> AnySequence<T>
func Skip(count: Int) -> AnySequence<T>
func SkipWhile(predicate: (T)->Bool) -> AnySequence<T>
func Take(count: Int) -> AnySequence<T>
func TakeWhile(predicate: (T)->Bool) -> AnySequence<T>
```

####Aggregators
```
func Aggregate<U>(block: (U,T)->U, startValue: U) -> U
func Elect(electLeft: (T,T)->Bool) -> (value: T?, index: Int?)
func First(predicate: (T)->Bool) -> (value: T?, index: Int?)
func Last(predicate: (T)->Bool) -> (value: T?, index: Int?)
func Min<U: Comparable>(transform: (T)->U) -> (transformed: U?, value: T?, index: Int?)
func Max<U: Comparable>(transform: (T)->U) -> (transformed: U?, value: T?, index: Int?)
```

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Installation

Linqwift is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'Linqwift'
```

## Author

Anton Bukov, k06aaa@gmail.com

## License

Linqwift is available under the [MIT License](LICENSE).
