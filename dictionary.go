package libkanji

import (
	"bufio"
	"log"
	"os"
	"path"
	"runtime"
	"time"
)

type Dictionary []DictionaryEntry

type DistionaryLookupMap map[string][]DictionaryEntry

var LookupDictionary = make(DistionaryLookupMap)

func LoadDictionary() Dictionary {

	var dictionary Dictionary

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
			//dictionary = append(dictionary, word)
			for _, conjugatedWord := range word.Conjugations() {
				//fmt.Printf("%q\n",conjugatedWord)
				LookupDictionary[conjugatedWord] = append(LookupDictionary[conjugatedWord], word)
			}
		}

	}

	return dictionary
}

func init() {
	go func() {
		now := time.Now()
		LoadDictionary()
		log.Printf("Time taken to load dictionary: %v \n", time.Since(now))
	}()
}
