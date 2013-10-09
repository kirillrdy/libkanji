package libkanji
//import "regexp"
//import "fmt"
//import "strings"
import "os"
import "bufio"



type Dictionary []DictionaryWord

var lookupDictionary map[string][]*DictionaryWord

func LoadDictionary() Dictionary {

	var dictionary Dictionary

	edict_file, err := os.Open("libkanji/edict2_utf8")
	if err != nil { panic(err) }

	edict_file_scanner := bufio.NewScanner(edict_file)


	for edict_file_scanner.Scan() {
		word  := CreateWord(edict_file_scanner.Text())

		if len(word.KanjiWords) != 0 {
			dictionary = append(dictionary, word)
			for _, conjugatedWord := range word.Conjugations() {
				lookupDictionary[conjugatedWord] = append(lookupDictionary[conjugatedWord], &word)
			}
		}

	}

	return dictionary
}

func init() {
	lookupDictionary = make(map[string][]*DictionaryWord)
}
