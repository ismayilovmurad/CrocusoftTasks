import Foundation
import XCTest

class BootcampTestCase: CollectionTestProtocol {
    // negagive numbers
    func insert(array: [Int], value: Int, position: Int) -> [Int] {
        // insert the `value` into `position` of `array` and return the result array
        var mutatedArray = array
        mutatedArray.insert(value, at: position)
        return mutatedArray
    }
    
    func reverse(array: [Int]) -> [Int] {
        // return the reversed array of integer array `array`
        return array.reversed()
    }
    
    func filterEvenNumbers(array: [Int]) -> [Int] {
        // return the filtered version of `array` only contains even numbers
        var mutableArray = array
        return mutableArray.filter{$0 % 2 == 0}
    }
    
    func filterNilValues(optionalNumbers: [Int?]) -> EquatableResult {
        // Given an array of optional integers ([5, nil, 8, 3, nil, 12]), remove nil values and calculate the sum of the remaining elements
        var mutableArray = optionalNumbers
        
        var nilSaveArray = mutableArray.compactMap{$0}
        
        let sum = nilSaveArray.reduce(0, +)
        
        return EquatableResult(array: nilSaveArray, sum: sum)
    }
    
    func replaceNilValues(array: [String?]) -> [String] {
        // Given an array of optional strings, create a new array where nil values are replaced with a default string "N/A"
        var mutableArray = [String]()
        
        array.forEach { i in
            if i == nil {
                mutableArray.append("N/A")
            } else {
                mutableArray.append(i!)
            }
        }
        
        return mutableArray
    }
    
    func commonElements(set1: Set<Int>, set2: Set<Int>) -> Set<Int> {
        // return the set of elements occurs in both of the set
        return set1.intersection(set2)
    }
    
    func subtract(original: Set<Int>, diff: Set<Int>) -> Set<Int> {
        // return the set of elements of `original` which are not present in `diff` set
        return original.subtracting(diff)
    }
    
    // TODO:
    // tried to do with set but it didn't work for some reason
    func getUniqueElements(array: [Int]) -> [Int] {
        // return only unique elements of array
        //var myArray = [Int]()
        
        var set = Set(array)
        
//        for i in array {
//            if !myArray.contains(i) {
//                myArray.append(i)
//            }
//        }
        
        return Array(set.sorted())
    }
    
    func addElementToDictionary(_ key: String, _ value: Int) -> Dictionary<String, Int> {
        // create empty dictionary, add item and return
        var dict: [String: Int] = [:]
        dict[key] = value
        
        return dict
    }
    
    func updateElementInDictionary(_ dictionary: inout Dictionary<String, Int>, _ item: (key: String, value: Int)) -> Dictionary<String, Int> {
        // update item in given dictionary and return
        dictionary[item.key] = item.value
        return dictionary
    }
    
    func removeElementFromDictionary(_ dictionary: inout Dictionary<String, Int>, _ key: String) -> Dictionary<String, Int> {
        // remove item from given dictionary and return
        dictionary[key] = nil
//        dictionary.removeValue(forKey: key)
        return dictionary
    }
    
    func getValuesIfContains(from dictionary: Dictionary<String, Int>, with keys: Set<String>) -> Dictionary<String, Int> {
        // return the dictionary with key and value pairs if key occurs in `keys` set
        return dictionary.filter { keys.contains($0.key) }
    }
    
    func filterStudents(from dictionary: Dictionary<String, Int>, score: Int) -> [String] {
        // Return names of students who's score is higher than `score`
        var result = [String]()
        
        dictionary.forEach { i in
            if i.value > score {
                result.append(i.key)
            }
        }
        
        return result
    }
    
    func generateUniqueEvenIntArray(size: Int) -> [Int] {
        // return an array of random, unique, even integer numbers with the size of `number`
        var set = Set<Int>()
        
        while set.count < size {
            set.insert(Int.random(in: 1...Int.max / 2) * 2)
        }
        
        return Array(set)
    }
    
    // Bonus questions
    func longNumberText(number: Int) -> String {
        // return the integer number sequence until `number` with appended into a string
        // example: input `number` = 5, output should be "012345"
        var result = ""
        
        for i in 0...number {
            result += "\(i)"
        }
        
        return result
    }
    
    func isNumberEven(number: Int, callback: (Bool) -> Void) {
        // compare the `number` is even, then return the result with callback
        let isEven = number % 2 == 0
        callback(isEven)
    }
}

struct EquatableResult: Equatable {
    let array: [Int]
    let sum: Int
}

// MARK: - DO NOT UPDATE THE CODE BELOW
protocol CollectionTestProtocol {
    func insert(array: [Int], value: Int, position: Int) -> [Int]
    func reverse(array: [Int]) -> [Int]
    func filterEvenNumbers(array: [Int]) -> [Int]
    func filterNilValues(optionalNumbers: [Int?]) -> EquatableResult
    func replaceNilValues(array: [String?]) -> [String]
    func commonElements(set1: Set<Int>, set2: Set<Int>) -> Set<Int>
    func subtract(original: Set<Int>, diff: Set<Int>) -> Set<Int>
    func getUniqueElements(array: [Int]) -> [Int]
    func addElementToDictionary(_ key: String,_ value: Int) -> Dictionary<String, Int>
    func updateElementInDictionary(_ dictionary: inout Dictionary<String, Int>, _ item: (key: String, value: Int)) -> Dictionary<String, Int>
    func removeElementFromDictionary(_ dictionary: inout Dictionary<String, Int>, _ key: String) -> Dictionary<String, Int>
    func getValuesIfContains(from dictionary: Dictionary<String, Int>, with keys: Set<String>) -> Dictionary<String, Int>
    func filterStudents(from dictionary: Dictionary<String, Int>, score: Int) -> [String]
    func generateUniqueEvenIntArray(size: Int) -> [Int]
    func longNumberText(number: Int) -> String
    func isNumberEven(number: Int, callback: (Bool) -> Void)
}

class BootcampTest: XCTestCase {
    
    var instance: CollectionTestProtocol!
    
    override func setUp() {
        super.setUp()
        
        self.instance = BootcampTestCase()
    }
    
    func testFilterEvenNumbers() {
        let array = [
            901,722,917,804,117,610,170,734,543,370,11,221,32,794,832,635,315,230,957,559,706,904,31,94,919,20,117,937,136,593,263,195,387,41,765,291,967,533,582,391,920,36,676,959,569,436,319,184,826,799,590,239,530,802,639,884,38,314,552,743,748,7,384,612,189,789,975,763,644,144,344,800,366,687,569,604,354,393,73,649,620,879,534,306,573,718,74,50,920,262,561,677,905,387,300,728,455,768,571,172,382]
        let filteredArray = self.instance.filterEvenNumbers(array: array)
        
        let expectedFilteredArray = [
            722,804,610,170,734,370,32,794,832,230,706,904,94,20,136,582,920,36,676,436,184,826,590,530,802,884,38,314,552,748,384,612,644,144,344,800,366,604,354,620,534,306,718,74,50,920,262,300,728,768,172,382,
        ]
        
        XCTAssertEqual(filteredArray, expectedFilteredArray, "The array should return only even numbers")
    }
    
    func testReverse() {
        let array = [901,722,917,804,117,610,170,734,543,370,11,221,32,794,832,635,315,230,957,559,706,904,31,94,919,20,117]
        let reversedArray = self.instance.reverse(array: array)
        let expectedValue = [117, 20, 919, 94, 31, 904, 706, 559, 957, 230, 315, 635, 832, 794, 32, 221, 11, 370, 543, 734, 170, 610, 117, 804, 917, 722, 901]
        XCTAssertEqual(reversedArray, expectedValue, "Array should be reversed")
    }
    
    func testInsertArray() {
        let array = [901,722,917,804,117]
        let value = 10
        let position = 2
        let insertedArray = self.instance.insert(array: array, value: value, position: position)
        let expectedValue = [901, 722, 10, 917, 804, 117]
        
        XCTAssertEqual(insertedArray, expectedValue, "Value should be inserted in a correct position")
    }
    
    func testFilterNilValues() {
        let optionalNumbers = [5, nil, 8, 3, nil, 12]
        
        let result = self.instance.filterNilValues(optionalNumbers: optionalNumbers)
        
        let expectedValue = EquatableResult(array: [5, 8, 3, 12], sum: 28)
        
        XCTAssertEqual(result, expectedValue, "Array must be of type [Int] and give a sum of its values")
    }
    
    func testReplaceNilValues() {
        let optionalStrings = ["John", nil, "Alice", "Bob", nil, "Charlie"]
        
        let expectedValue = ["John", "N/A", "Alice", "Bob", "N/A", "Charlie"]
        
        let result = instance.replaceNilValues(array: optionalStrings)
        
        XCTAssertEqual(result, expectedValue, "Array must be of type [String] and nil values be replaces with \"N/A\".")
    }
    
    func testCommonElements() {
        let set1: Set = [4, 2, 8, 0, 9, 3, 5]
        let set2: Set = [1, 4, 9, 3, 7]
        let expectedValue: Set = [9, 3, 4]
        
        let result = self.instance.commonElements(set1: set1, set2: set2)
        
        XCTAssertEqual(result, expectedValue, "Set should contain only common elements")
    }
    
    func testSubtract() {
        let set: Set = [4, 2, 8, 0, 9, 3, 5]
        let diff: Set = [1, 4, 9, 3, 7]
        let expectedValue: Set = [2, 8, 0, 5]
        
        let result = self.instance.subtract(original: set, diff: diff)
        
        XCTAssertEqual(result, expectedValue, "Set should contain only different values of `diff` set")
    }
    
    func testGetUniqueElements() {
        let arr: [Int] = [1, 12, 14, 16, 1, 20, 12, 14]
        let expectedValue = [1, 12, 14, 16, 20]
        
        let result = self.instance.getUniqueElements(array: arr)
        
        XCTAssertEqual(result, expectedValue, "Array should contain only unique values")
    }
    
    func testAddDictionaryOperation() {
        let key = "apple"
        let value = 24
        
        let expectedValue: Dictionary<String, Int> = [
            "apple": 24
        ]
        
        let result = instance.addElementToDictionary(key, value)
        
        XCTAssertEqual(result, expectedValue, "Dictionary should contain final values after operations")
    }
    
    func testUpdateDictionaryOperation() {
        var dict = [
            "apple" : 24
        ]
        let updatedValue = ("apple", 45)
        
        let expectedValue: Dictionary<String, Int> = [
            "apple": 45
        ]
        
        let result = instance.updateElementInDictionary(&dict, updatedValue)
        
        XCTAssertEqual(result, expectedValue, "Dictionary should contain final values after operations")
    }
    
    func testRemoveDictionaryOperation() {
        var dict = [
            "apple" : 24,
            "hat" : 14,
            "mango" : 5
        ]
        let removedValue = "hat"
        
        let expectedValue: Dictionary<String, Int> = [
            "apple" : 24,
            "mango" : 5
        ]
        
        let result = instance.removeElementFromDictionary(&dict, removedValue)
        
        XCTAssertEqual(result, expectedValue, "Dictionary should contain final values after operations")
    }
    
    func testGetValuesIfContains() {
        let dictionarySet: Dictionary<String, Int> = [
            "apple": 1,
            "pear": 3,
            "grapes": 8,
            "coconut": 10,
            "watermelon": 9
        ]
        let keys: Set<String> = ["grapes", "coconut"]
        
        let expectedValue: Dictionary<String, Int> = [
            "grapes": 8,
            "coconut": 10
        ]
        
        let result = self.instance.getValuesIfContains(from: dictionarySet, with: keys)
        
        XCTAssertEqual(result, expectedValue, "Dictionary should contain selected keys")
    }
    
    func testFilterStudents() {
        let testScores: [String: Int] = ["Alice": 80, "Bob": 65, "Charlie": 90, "David": 72]
        
        let expectedValue = ["Alice", "Charlie", "David"]
        
        let result = instance.filterStudents(from: testScores, score: 70)
        
        XCTAssertEqual(result.sorted(), expectedValue.sorted(), "Array must contain names of students' whose score is higher than 70")
    }
    
    func testUniqueEvenIntArray() {
        let size = 100
        let array = self.instance.generateUniqueEvenIntArray(size: size)
        
        XCTAssertEqual(array.count, size, "Array size should be equal \(size)")
        
        let allEven = array.allSatisfy { value in
            value % 2 == 0
        }
        
        XCTAssertTrue(allEven, "All numbers should be even")
        
        let allUnique = Set(array).count == array.count
        
        XCTAssertTrue(allUnique, "All numbers should be unique")
    }
    
    
    func testLongNumberText() {
        let number = 530
        let text = self.instance.longNumberText(number: number)
        let expectedValue = "0123456789101112131415161718192021222324252627282930313233343536373839404142434445464748495051525354555657585960616263646566676869707172737475767778798081828384858687888990919293949596979899100101102103104105106107108109110111112113114115116117118119120121122123124125126127128129130131132133134135136137138139140141142143144145146147148149150151152153154155156157158159160161162163164165166167168169170171172173174175176177178179180181182183184185186187188189190191192193194195196197198199200201202203204205206207208209210211212213214215216217218219220221222223224225226227228229230231232233234235236237238239240241242243244245246247248249250251252253254255256257258259260261262263264265266267268269270271272273274275276277278279280281282283284285286287288289290291292293294295296297298299300301302303304305306307308309310311312313314315316317318319320321322323324325326327328329330331332333334335336337338339340341342343344345346347348349350351352353354355356357358359360361362363364365366367368369370371372373374375376377378379380381382383384385386387388389390391392393394395396397398399400401402403404405406407408409410411412413414415416417418419420421422423424425426427428429430431432433434435436437438439440441442443444445446447448449450451452453454455456457458459460461462463464465466467468469470471472473474475476477478479480481482483484485486487488489490491492493494495496497498499500501502503504505506507508509510511512513514515516517518519520521522523524525526527528529530"
        
        XCTAssertEqual(text, expectedValue, "Number sequence should be appended into a string")
    }
    
    func testCallbackFunction() {
        let numbers = [23, 44, 63, 62, 1, 29, 50]
        var isEvenResult = [Bool]()
        let expectedValue = [false, true, false, true, false, false, true]
        
        numbers.map { number in
            self.instance.isNumberEven(number: number) { isEven in
                isEvenResult.append(isEven)
            }
        }
        
        XCTAssertEqual(isEvenResult, expectedValue, "Callback method should be called correctly")
    }
}

BootcampTest.defaultTestSuite.run()
