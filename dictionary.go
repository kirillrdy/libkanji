package libkanji
import "regexp"
import "io/ioutil"
//import "fmt"
import "strings"

type DictionaryWord struct {
	Word string
	Pronunciation string
	Meanings []string
}

type Dictionary []DictionaryWord

var lookupDictionary map[string][]*DictionaryWord

func LoadDictionary() Dictionary {

	var dictionary Dictionary

	dictionary_entry_regex, err := regexp.Compile(`(.*?) \[(.*?)\] (.*?)\n`)
	if err != nil { panic(err) }

	// TODO dont load all at once
	text, err := ioutil.ReadFile("libkanji/edict2_utf8")
	if err != nil { panic(err) }

	dictionary_entries := dictionary_entry_regex.FindAllStringSubmatch(string(text),-1)

	//TODO remove slicing
	for _, dictionary_entry := range dictionary_entries {

		words := dictionary_entry[1]
		for _, word  := range strings.Split(words, ";") {

			//TODO strip '()' from words
			//TODO split pronunciations by ';'
			//Get type of meaning in brakets  eg (n)
			// Pronunciations also have '()'

			dictionary_word := DictionaryWord{Word: word, Pronunciation: dictionary_entry[1], Meanings: strings.Split(dictionary_entry[3],",")}
			//dictionary = append(dictionary, dictionary_word)

			lookupDictionary[dictionary_word.Word] = append(lookupDictionary[dictionary_word.Word], &dictionary_word)

		}
	}
	return dictionary
}

func init() {
	lookupDictionary = make(map[string][]*DictionaryWord)
}
