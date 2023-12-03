// vim: ft=typst

#set text(
    size: 12pt,
    font: "STIX Two Text",
    lang: "en",
    region: "US",
)
#show raw: set text(font: "Recursive Mn Lnr St")
#show math.equation: set text(font: "STIX Two Math")
#set page(
    width: auto,
    height: auto,
)

#set document(title: "Advent of Code - Day 03", author: "liketechnik")

#let exercise = read("./input03").trim()
#let lines = exercise.split("\n")
/**
Idea: build a map with the position of all symbols
and a map with all numbers and all the positions they're at
(i.e. a number with 3 digits has 3 positions),
then filter all numbers by matching position...
**/
#let numbers = lines.enumerate().map(numberedLine => {
    let line = numberedLine.at(1)
    let x = numberedLine.at(0)
    line.matches(regex("[0-9]+")).map(match => {
        let y = (match.start, match.end - 1)
        let adjacent = range(y.at(0), y.at(1) + 1)
            .map(y => {
                range(x - 1, x + 2)
                    .map(x => {
                        range(y - 1, y + 2).map(y => (x: x, y: y))
                    })
            }).flatten()
        (
            value: int(match.text),
            x: x,
            y: y,
            adjacent: adjacent,
        )
    })
}).flatten()

#let symbols = lines.enumerate().map(numberedLine => {
    let line = numberedLine.at(1)
    let x = numberedLine.at(0)
    line.matches(regex("[^\d\.]")).map(match => {
        (
            x: x,
            y: match.start,
        )
    })
}).flatten()
#let partNumbers = numbers.filter(number => {
    number.adjacent.any(pos => symbols.contains(pos))
})
#let result1 = partNumbers.map(number => number.value).sum()

#let gearSymbols = lines.enumerate().map(numberedLine => {
    let line = numberedLine.at(1)
    let x = numberedLine.at(0)
    line.matches(regex("\*")).map(match => {
        (
            x: x,
            y: match.start,
        )
    })
}).flatten()
#let gearRatios = gearSymbols.map(gearPos => {
    let adjacent = numbers.filter(number => {
        number.adjacent.contains(gearPos)
    })

    if adjacent.len() == 2 {
        adjacent.at(0).value * adjacent.at(1).value
    } else {
        0
    }
})
#let result2 = gearRatios.sum()

#figure(caption: "Advent of Code Day 03")[
    #table(
        columns: (auto, auto),
        [Part 1], [Part 2],
        [#result1], [#result2],
    )
]
