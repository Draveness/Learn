package main

import "fmt"

func main() {
	for pos, char := range "aΦx" {
		fmt.Printf("character '%c' starts at byte position %d\n", char, pos)
	}
}
