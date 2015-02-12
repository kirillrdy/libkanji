package libkanji

import (
	"bufio"
	"os"
	"path"
	"runtime"
)

type DictionaryLookupMap map[string][]DictionaryEntry

type Dictionary struct {
	bigHash DictionaryLookupMap
}

type updateMessage struct {
	dictionaryEntry DictionaryEntry
	key             string
}

func LoadDictionary() Dictionary {

	var dictionary Dictionary
	dictionary.bigHash = make(DictionaryLookupMap)

	_, currentSourceFile, _, _ := runtime.Caller(0)
	path := path.Join(path.Dir(currentSourceFile), "edict2_utf8")
	edictFile, err := os.Open(path)
	defer edictFile.Close()

	if err != nil {
		panic(err)
	}

	edictFileScanner := bufio.NewScanner(edictFile)

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
