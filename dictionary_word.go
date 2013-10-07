package libkanji

//import "errors"
import "regexp"
import "strings"
import "fmt"

type DictionaryWord struct {
	KanjiWords []string
	Types []string
	Pronunciations []string
	Meanings []string
	originalString string
}

func CreateWord(original string ) (word DictionaryWord) {
	dictionary_entry_regex, err := regexp.Compile(`(.*?) \[(.*?)\] /\((.*?)\) (.*?)$`)
	if err != nil { panic(err) }

	dictionary_entries := dictionary_entry_regex.FindStringSubmatch(original)
	if len(dictionary_entries) == 0 {
		return
	}

	word.KanjiWords = strings.Split(dictionary_entries[1], ";")
	word.Pronunciations = strings.Split(dictionary_entries[2], ";")
	word.Types = strings.Split(dictionary_entries[3], ",")
	word.Meanings = strings.Split(dictionary_entries[4], "/")

	fmt.Printf("%q \n", word.Types)

	//TODO strip '()' from words
	//TODO split pronunciations by ';'
	//Get type of meaning in brakets  eg (n)
	// Pronunciations also have '()'
	return
}

func (word *DictionaryWord) parseOriginalString() {

}
