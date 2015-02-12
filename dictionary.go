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

	edict_file_scanner := bufio.NewScanner(edictFile)

	for edict_file_scanner.Scan() {
		word := ParseDictionaryLine(edict_file_scanner.Text())

		if len(word.KanjiWords) != 0 {
			conjugations := word.Conjugations()
			for i := range conjugations {
				dictionary.bigHash[conjugations[i]] = append(dictionary.bigHash[conjugations[i]], word)
			}
		}

	}

	return dictionary
}
