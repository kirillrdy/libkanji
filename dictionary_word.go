package libkanji

import (
	"log"
	"regexp"
)
import "strings"

type DictionaryEntry struct {
	KanjiWords     []string
	Types          []string
	Pronunciations []string
	Meanings       []string
	originalString string
}

func ParseDictionaryLine(original string) (word DictionaryEntry) {
	dictionary_entry_regex, err := regexp.Compile(`(.*?) \[(.*?)\] /\((.*?)\) (.*?)$`)
	if err != nil {
		panic(err)
	}

	furigana_entry_regex, err := regexp.Compile(`(.*?) /\((.*?)\) (.*?)$`)
	if err != nil {
		panic(err)
	}

	dictionary_entries := dictionary_entry_regex.FindStringSubmatch(original)
	if len(dictionary_entries) == 0 {
		dictionary_entries = furigana_entry_regex.FindStringSubmatch(original)
		if len(dictionary_entries) == 0 {
			return
			log.Printf("gave up on %q \n", original)
		}
	}

	strip_ending_regex := regexp.MustCompile(`\(.*?\)$`)

	for _, kanjiWord := range strings.Split(dictionary_entries[1], ";") {
		stripped_word := strip_ending_regex.ReplaceAllLiteralString(kanjiWord, "")
		word.KanjiWords = append(word.KanjiWords, stripped_word)
	}
	if len(dictionary_entries) == 5 {
		word.Pronunciations = strings.Split(dictionary_entries[2], ";")
		word.Types = strings.Split(dictionary_entries[3], ",")
		word.Meanings = strings.Split(dictionary_entries[4], "/")
	} else if len(dictionary_entries) == 4 {
		word.Pronunciations = strings.Split(dictionary_entries[1], ";")
		word.Types = strings.Split(dictionary_entries[2], ",")
		word.Meanings = strings.Split(dictionary_entries[3], "/")
	} else {
		panic("Could not parse word correctly")
	}
	//fmt.Printf("%q \n", word.KanjiWords)

	//TODO strip '()' from words
	//TODO split pronunciations by ';'
	//Get type of meaning in brakets  eg (n)
	// Pronunciations also have '()'
	return
}

func (dictionaryWord DictionaryEntry) Conjugations() []string {
	var conjugations []string

	for _, word := range dictionaryWord.KanjiWords {
		conjugations = append(conjugations, word)
		for _, wordType := range dictionaryWord.Types {
			conjugations = append(conjugations, conjugationsForWord(word, wordType)...)
		}
	}
	return conjugations
}
