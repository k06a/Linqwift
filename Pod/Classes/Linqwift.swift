//
//  Linqwift.swift
//  Linqwift
//
//  Created by Anton Bukov on 03.03.16.
//

import Foundation

class AnyGeneratorWithLambda<Element> : AnyGenerator<Element>
{
    private var nextLambda: () -> Element?
    
    init(lambda: () -> Element?) {
        nextLambda = lambda
    }
    
    override func next() -> Element? {
        return nextLambda()
    }
}

//

public extension AnySequence
{
    func Where(predicate: (Element,Int)->Bool) -> AnySequence<Element>
    {
        return AnySequence<Element> { () -> AnyGenerator<Element> in
            let gen = self.generate()
            var index = 0
            return AnyGeneratorWithLambda<Element> {
                while let object = gen.next() {
                    if predicate(object,index++) {
                        return object
                    }
                }
                return nil
            }
        }
    }
    
    func Where(predicate: (Element)->Bool) -> AnySequence<Element>
    {
        return Where { o,i in predicate(o) }
    }
    
    func Select<U>(transform: (Element,Int)->U) -> AnySequence<U>
    {
        return AnySequence<U> { () -> AnyGenerator<U> in
            let gen = self.generate()
            var index = 0
            return AnyGeneratorWithLambda<U> {
                while let object = gen.next() {
                    return transform(object,index++)
                }
                return nil
            }
        }
    }
    
    func Select<U>(transform: (Element)->U) -> AnySequence<U>
    {
        return Select { o,i in transform(o) }
    }
    
    func Distinct<U where U: Hashable>(transform: (Element)->U) -> AnySequence<Element>
    {
        return AnySequence<Element> { () -> AnyGenerator<Element> in
            let gen = self.generate()
            var set: Dictionary<U,Bool> = [:]
            return AnyGeneratorWithLambda<Element> {
                while let object = gen.next() {
                    let result = transform(object)
                    if set.updateValue(true, forKey: result) == nil {
                        return object
                    }
                }
                return nil
            }
        }
    }
    
    func SkipWhile(predicate: (Element)->Bool) -> AnySequence<Element>
    {
        return AnySequence<Element> { () -> AnyGenerator<Element> in
            let gen = self.generate()
            var skipping = true
            return AnyGeneratorWithLambda<Element> {
                while let object = gen.next() {
                    if skipping {
                        skipping = predicate(object)
                    } else {
                        return object
                    }
                }
                return nil
            }
        }
    }
    
    func Skip(count: Int) -> AnySequence<Element>
    {
        var index = 0
        return SkipWhile { _ in ++index < count }
    }
    
    func TakeWhile(predicate: (Element)->Bool) -> AnySequence<Element>
    {
        return AnySequence<Element> { () -> AnyGenerator<Element> in
            let gen = self.generate()
            var taking = true
            return AnyGeneratorWithLambda<Element> {
                while let object = gen.next() {
                    if taking {
                        taking = predicate(object)
                        return object
                    } else {
                        return nil
                    }
                }
                return nil
            }
        }
    }
    
    func Take(count: Int) -> AnySequence<Element>
    {
        var index = 0
        return TakeWhile { _ in ++index < count }
    }
}

public extension AnySequence
{
    // Aggregate and Elect
    
    func Aggregate<U>(block: (U,Element)->U, startValue: U) -> U
    {
        var result = startValue
        for object in self {
            result = block(result, object)
        }
        return result
    }
    
    func Elect(electLeft: (Element,Element)->Bool) -> (value: Element?, index: Int?)
    {
        var electedIndex: Int? = nil
        var index = 0
        var result: Element? = nil
        for object in self {
            if result == nil || result != nil && !electLeft(result!, object) {
                result = object
                electedIndex = index
            }
            index++
        }
        return (result, electedIndex)
    }
    
    // First and Last
    
    func First(predicate: (Element)->Bool) -> (value: Element?, index: Int?)
    {
        var index = 0
        for object in self {
            if (predicate(object)) {
                return (object, index)
            }
            index++
        }
        return (nil, nil)
    }
    
    func Last(predicate: (Element)->Bool) -> (value: Element?, index: Int?)
    {
        return self.Elect { a,b in false }
    }
    
    // Min and Max
    
    func Min<U: Comparable>(transform: (Element)->U) -> (transformed: U?, value: Element?, index: Int?)
    {
        var minTrans: U? = nil
        var minValue: Element? = nil
        var minIndex: Int? = nil
        var index = 0
        for object in self {
            let trans = transform(object)
            if (minIndex == nil) || (trans < minTrans!) {
                minTrans = trans
                minValue = object
                minIndex = index
            }
            index++
        }
        return (minTrans, minValue, minIndex)
    }
    
    func Max<U: Comparable>(transform: (Element)->U) -> (transformed: U?, value: Element?, index: Int?)
    {
        var maxTrans: U? = nil
        var maxValue: Element? = nil
        var maxIndex: Int? = nil
        var index = 0
        for object in self {
            let trans = transform(object)
            if (maxIndex == nil) || (trans > maxTrans!) {
                maxTrans = trans
                maxValue = object
                maxIndex = index
            }
            index++
        }
        return (maxTrans, maxValue, maxIndex)
    }
}

public extension AnySequence
{
    // Export
    
    func ToArray() -> [Element] {
        var arr = [Element]()
        for a in self {
            arr.append(a)
        }
        return arr
    }
}

