package libkanji

import "testing"

func BenchmarkDictionaryLoad(b *testing.B) {
	for i := 0; i < b.N; i++ {
		LoadDictionary()
	}
}
