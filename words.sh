#!/usr/bin/env bash

# The location of script.
DIR="$( cd -P "$( dirname ${BASH_SOURCE[0]} )" >/dev/null 2>&1 && pwd )"

usage() {
	echo "./words.sh command"
	echo
	echo "COMMANDS"
	echo 
	echo "help"
	echo "    prints this menu."
	echo 
	echo "generate <size by MB>"
	echo "    generate a file full of words using"
	echo "    /dev/urandom in current directory"
	echo "    named words, default size is 10MB."
	echo 
	echo "count"
	echo "    print the number of words, number of"
	echo "    distinct words and ten most common words"
	echo "    appeared in the 'words' file."
	echo 
}

generate() {
	local size=10

	if [[ $# > 0 ]]; then
		size=$1
	fi

	size=$(($size * 1024))

	echo "Generating the file $DIR/words..."
	dd if=/dev/urandom of=$DIR/words bs=1024 count=$size
	echo "Complete!"
}

number_of_words() {
	if [ -e $DIR/words ]; then
		echo "The number of words:"
		echo "===================="
		cat $DIR/words | tr -cs "[:alpha:]" "\n" | wc -l
		echo "===================="
		echo
	else
		echo "Please generate words file first."
	fi
}

number_of_distinct_words() {
	if [ -e $DIR/words ]; then
		echo "The number of distinct words:"
		echo "============================="
		cat $DIR/words | tr -cs "[:alpha:]" "\n" | sort | uniq | wc -l
		echo "============================="
		echo
	else
		echo "Please generate words file first."
	fi
}

10_most_common() {
	if [ -e $DIR/words ]; then
		echo "The 10 most common words:"
		echo "========================="
		cat $DIR/words | tr -cs "[:alpha:]" "\n" | sort | uniq -c | sort -nr | head -10 
		echo "========================="
		echo
	else
		echo "Please generate words file first."
	fi
}

if [[ $# > 0 ]] && [ $1 != "help" ]; then
	case $1 in
		'generate')
			generate $2
			;;
		'count')
			number_of_words
			number_of_distinct_words
			10_most_common
			;;
		*)
			usage
			;;
	esac
else
	usage
fi
