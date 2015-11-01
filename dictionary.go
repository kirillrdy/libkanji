package libkanji

import (
	"bufio"
	"io"
	"os"
	"path"
	"runtime"
	"time"
)

type dictionaryLookupMap map[string][]DictionaryEntry

//Dictionary main type that represents a dictionary
type Dictionary struct {
	bigHash dictionaryLookupMap
}

//Size returns number of entries in the underlying datastructure
func (dictionary Dictionary) Size() int {
	return len(dictionary.bigHash)
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
	return ParseDictionary(edictFile, false)
}

//ParseDictionary takes a reader and parses its input as a Dictionary
// it also takes a second argument which injects a selep inside the loop that
// conjugates all the worlds in the dictionary
// this is done just so that dictionary can be loaded in the browser using gopherjs
// by doing this sleep browser doesn't get UI lock when parsing a dictionary
func ParseDictionary(reader io.Reader, slowParsing bool) Dictionary {
	var dictionary Dictionary
	dictionary.bigHash = make(dictionaryLookupMap)

	edictFileScanner := bufio.NewScanner(reader)

	for edictFileScanner.Scan() {
		word := ParseDictionaryLine(edictFileScanner.Text())

		if slowParsing == true {
			time.Sleep(1) // 1 is enough to trigger context switch
		}

		if len(word.KanjiWords) != 0 {
			conjugations := word.Conjugations()
			for i := range conjugations {
				dictionary.bigHash[conjugations[i]] = append(dictionary.bigHash[conjugations[i]], word)
			}
		}
	}
	return dictionary
}
