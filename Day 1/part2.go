package main

import (
	"bufio"
	"fmt"
	"os"
	"reflect"
	"regexp"
	"strings"
)

func reverse(str string) (result string) {
	// reverses the input string; inefficient no doubt
	for _, v := range str {
		result = string(v) + result
	}
	return result
}

func convert(mapping map[string]int, value string) (result int) {
	// convert a digit (spelled out or otherwise) to an int value
	v, ok := mapping[value]
	if !ok {
		// not a spelled digit so must be a regular '0'-'9' type digit
		v = int(value[0] - '0')
	}
	return v
}

func getkeys(mapping map[string]int) (result []string) {
	// return the keys of a map as an array of strings
	keys := reflect.ValueOf(mapping).MapKeys()
	strkeys := make([]string, len(keys))
	for i := 0; i < len(keys); i++ {
		strkeys[i] = keys[i].String()
	}
	return strkeys
}

func main() {

	// make a mapping of text to numbers
	mapping := map[string]int{
		"one":   1,
		"two":   2,
		"three": 3,
		"four":  4,
		"five":  5,
		"six":   6,
		"seven": 7,
		"eight": 8,
		"nine":  9,
	}

	// initialize variables
	keys := getkeys(mapping)
	scanner := bufio.NewScanner(os.Stdin)
	// build regular expression to account for spelled out numbers
	// as defined in the keys of the mapping var above
	exp := strings.Join(keys, "|")
	re1 := regexp.MustCompile("[0-9]|" + exp)
	re2 := regexp.MustCompile("[0-9]|" + reverse(exp))
	total := 0

	for scanner.Scan() {
		line := scanner.Text()
		// convert first digit or spelled number to int
		d1 := convert(mapping, re1.FindString(line))
		// Convert last digit or spelled number in input line to int.
		// Reverse everything to counter for overlapping spelled numbers,
		// e.g., twone, in the last position of the input line.
		// Scanning from left to right would match 'two' and since the 'o' would be
		// consumed, the 'one' would not be found by the regular expression parser.
		// By reversing the input string and all the spelled digit words, it works.
		// The input line '4one93threetwoned' becomes 'denowteerht39eno4'
		// and the regular expression you look for is
		// '[0-9]|enin|thgie|neves|xis|evif|ruof|eerht|owt|eno'
		d2 := convert(mapping, reverse(re2.FindString(reverse(line))))
		total += d1*10 + d2
	}
	fmt.Println(total)
}
