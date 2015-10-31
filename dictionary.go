package libkanji

import (
	"bufio"
	"io"
	"os"
	"path"
	"runtime"
)

type dictionaryLookupMap map[string][]DictionaryEntry

//Dictionary main type that represents a dictionary
type Dictionary struct {
	bigHash dictionaryLookupMap
}

//Edict2FilePath returns path of edict file bundled with this package
func Edict2FilePath() string {
	_, currentSourceFile, _, _ := runtime.Caller(0)
	path := path.Join(path.Dir(currentSourceFile), "edict2_utf8")
	return path
}

//Edict2File returns ReaderCloser of a bundled edict2 file
func Edict2File() io.ReadCloser {
	edictFile, err := os.Open(Edict2FilePath())
	if err != nil {
		panic(err)
	}
	return edictFile
}

//LoadDictionary parses edict2 file and performs conjugations of all words
func LoadDictionary() Dictionary {
	edictFile := Edict2File()
	defer edictFile.Close()
	return ParseDictionary(edictFile)
}

//ParseDictionary takes a reader and parses its input as a Dictionary
func ParseDictionary(reader io.Reader) Dictionary {
	var dictionary Dictionary
	dictionary.bigHash = make(dictionaryLookupMap)

	edictFileScanner := bufio.NewScanner(reader)

	for edictFileScanner.Scan() {
		word := ParseDictionaryLine(edictFileScanner.Text())

		if len(word.KanjiWords) != 0 {
			conjugations := word.Conjugations()
			for i := range conjugations {
				dictionary.bigHash[conjugations[i]] = append(dictionary.bigHash[conjugations[i]], word)
			}
		}
	}
	return dictionary
}
