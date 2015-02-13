package libkanji

import "testing"

func BenchmarkDictionaryLoad(b *testing.B) {
	for i := 0; i < b.N; i++ {
		LoadDictionary()
	}
}

func TestNumberOfConjugations(t *testing.T) {
	dictionary := LoadDictionary()
	expectedSize := 407205
	if len(dictionary.bigHash) != expectedSize {
		t.Errorf("Parsed dictionary not correct size, %v expected, got %v", expectedSize, len(dictionary.bigHash))
	}
}
