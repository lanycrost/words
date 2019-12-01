# Words

Generate a 10MiB file full of words using /dev/urandom.

Write a script which will
1. Count the number of words
2. count the number of distinct words
3. count the ten most common words

## SYNOPSIS

./words.sh command

COMMANDS

help
    prints this menu.

generate <size by MB>
    generate a file full of words using
    /dev/urandom in current directory
    named words, default size is 10MB.

count
    print the number of words, number of
    distinct words and ten most common words
    appeared in the 'words' file.
