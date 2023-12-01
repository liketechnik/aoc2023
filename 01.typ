// vim: ft=typst

#set text(
    size: 12pt,
    font: "STIX Two Text",
    lang: "de",
    region: "DE",
)
#show raw: set text(font: "Recursive Mn Lnr St")
#show math.equation: set text(font: "STIX Two Math")
#set page(
    paper: "a4",
)

#set document(title: "Advent of Code - Day 01, Part 1", author: "liketechnik")

#let exercise = read("./input01").trim()
#let lines = exercise.split("\n")
#let regNumber = regex("[0-9]")
#let first_numbers = lines.map(line => line.find(regNumber))
#let second_numbers = lines.map(line => line.rev().find(regNumber))
#let numbers = first_numbers.zip(second_numbers).map(digits => digits.fold("", (a, i) => a + i)).map(s => int(s))
#let result = numbers.fold(0, (sum, v) => sum + v)

#result

#let regNumber = regex("[0-9]|one|two|three|four|five|six|seven|eight|nine")
#let firstNumbers = lines.map(line => line.find(regNumber))
#let regNumber = regex("[0-9]|eno|owt|eerht|ruof|evif|xis|neves|thgie|enin")
#let secondNumbers = lines.map(line => line.rev().find(regNumber).rev())
#let numbers = firstNumbers.zip(secondNumbers)
#let toNumber(string) = {
    let map = (
        one: 1,
        two: 2,
        three: 3,
        four: 4,
        five: 5,
        six: 6,
        seven: 7,
        eight: 8,
        nine: 9,
    )
    let val = map.pairs().find(p => p.at(0) == string)
    if val != none {
        val.at(1)
    } else {
        int(string)
    }
}
#let asNums  = numbers.map(v => (toNumber(v.at(0)), toNumber(v.at(1)))).map(v => (v.at(0) * 10) + v.at(1))
#let result = asNums.fold(0, (sum, v) => sum + v)

#result
