package main

import (
	"fmt"
)

func work() {
	str := ""
	for i := 0; i < 100; i++ {
		for i := 0; i < 100; i++ {
			for i := 0; i < 10; i++ {
				str += "."
			}
		}
	}
}

func main() {
	fmt.Printf("main\n")
}
