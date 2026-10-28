Colors = {
    black = "#0f1820",

    hush = {
        light = "#202733",
        main = "#1d232e",
        dark = "#121c26",
    },

    bright_black = "#535b68",
    bright_black0_5 = "#45475a",
    bright_black2 = "#393c4d",
    bright_black2_5 = "#2c3341",
    bright_black3 = "#1f2a35",
    bright_black4 = "#0f1820",

    red = "#f77172",
    green = "#65a884",
    orange = "#f5dec4",
    yellow = "#cec999",
    blue = "#74add2",
    magenta = "#a980c4",
    cyan = "#2d949f",

    cyan_dark = "#223442",

    white = "#dde2f3",

    -- Derived: white blended over hush.main
    comment = "#737987", -- 45% white
    subtext = "#9a9fae", -- 65% white

    -- Derived: accent blended over hush.main
    diff = {
        red = { subtle = "#49333c", strong = "#693e46" },     -- 20% / 35%
        green = { subtle = "#2b3e3f", strong = "#36524c" },   -- 20% / 35%
    },
    tint = { -- 35% accent over hush.main
        magenta = "#4e4462",
        blue = "#3b5367",
        cyan = "#234b56",
        yellow = "#5b5d53",
    },
}


LspAlias = {
    -- Javascript and Typescript
    javascript = { "javascriptreact" },
    typescript = { "typescriptreact" },

    -- Protobuf
    protobuf = { "proto" },
}
