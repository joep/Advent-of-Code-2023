package main

import (
	"bufio"
	"fmt"
	"os"
	"regexp"
)

func main() {
	scanner := bufio.NewScanner(os.Stdin)
	re := regexp.MustCompile("[0-9]")
	total := 0
	for scanner.Scan() {
		digits := re.FindAllString(scanner.Text(), -1)
		total += int(digits[0][0]-'0')*10 + int(digits[len(digits)-1][0]-'0')
	}
	fmt.Println(total)
}
