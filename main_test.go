package main

import (
	"testing"
)

func TestWork(t *testing.T) {
	work()
}

func BenchmarkWork(b *testing.B) {
	for i := 0; i < b.N; i++ {
		work()
	}
}
