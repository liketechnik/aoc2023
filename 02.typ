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

#set document(title: "Advent of Code - Day 02", author: "liketechnik")

#let exercise = read("./input02").trim()
#let lines = exercise.split("\n")
#let revelationRegex = regex("[0-9]+ (blue|red|green)")
#let setRegex = regex("([0-9]+ (blue|red|green)(, )?)+")
#let games = lines.map(line => {
    let gameId = line.match(regex("[0-9]+:")).text.find(regex("[0-9]+"))
    let sets = line.matches(setRegex).map(rawSet => {
        let revelations = rawSet.text.matches(revelationRegex).map(rawRevelation => {
            let color = rawRevelation.text.find(regex("blue|red|green"))
            let count = int(rawRevelation.text.find(regex("[0-9]+")))
            (
                color: color,
                count: count,
            )
        })
        revelations
    })
    (
        id: int(gameId),
        sets: sets,
    )
})

#let availableCubes = (
    "red": 12,
    "green": 13,
    "blue": 14,
)
#let possibleGames = games.filter(game => game.sets.fold(true, (valid, s) => if valid {
    s.fold(valid, (valid, s) => if valid {
        if availableCubes.at(s.color) >= s.count {
            true
        } else {
            false
        }
    } else {
        false
    })
} else {
    false
}))
#let result1 = possibleGames.map(game => game.id).sum()

#let minimalSets = games.map(game => game.sets.fold((red: 0, green: 0, blue: 0), (minimal, cur) => {
    let updateFn(color, minimal) = {
        let val = cur.find(cube => cube.color == color)
        if val != none and val.count > minimal.at(color) {
            minimal.insert(color, val.count)
        }
        minimal
    }
    minimal = updateFn("red", minimal)
    minimal = updateFn("green", minimal)
    minimal = updateFn("blue", minimal)

    minimal
}))
#let powers = minimalSets.map(s => s.values().product())
#let result2 = powers.sum()

#figure(caption: "Advent of Code Day 02")[
    #table(
        columns: (auto, auto),
        [Part 1], [Part 2],
        [#result1], [#result2],
    )
]
