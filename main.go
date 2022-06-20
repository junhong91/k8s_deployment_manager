package main

import "fmt"

var v int32

func main() {
	fmt.Println(v)
}

// init() function called when package loaded at first
func init() {
	v = 1
}