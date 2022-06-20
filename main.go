package main

import (
	"fmt"

	starlingxv1 "github.com/junhong91/k8s_deployment_manager/api/v1"
)

var v int32

func main() {
	fmt.Println(v)

	d := starlingxv1.DataNetwork{}
	fmt.Println(d)
}

// init() function called when package loaded at first
func init() {
	v = 1
}