-- interact takes a function which accepts a string and returns a string
-- it passes STDIN to the function and prints the return value to STDOUT
main = interact wordCount
-- where binds a symbol to a definition
-- lines splits a string by newline into a list of strings
-- length returns the length of a list
-- show converts a value to a string (Text.Show)
-- n.b. show is evaluated before ++ here
    where wordCount input = show (length (lines input)) ++ "\n"
