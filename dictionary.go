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

	_, current_file, _, _ := runtime.Caller(0)
	path := path.Join(path.Dir(current_file), "edict2_utf8")
	edict_file, err := os.Open(path)
	defer edict_file.Close()

	if err != nil {
		panic(err)
	}

	edict_file_scanner := bufio.NewScanner(edict_file)

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
