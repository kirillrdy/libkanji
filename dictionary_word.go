package libkanji

//import "errors"
import "regexp"
import "strings"
//import "fmt"

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

	//fmt.Printf("%q \n", word.KanjiWords)

	//TODO strip '()' from words
	//TODO split pronunciations by ';'
	//Get type of meaning in brakets  eg (n)
	// Pronunciations also have '()'
	return
}

func (dictionaryWord DictionaryWord) Conjugations() []string {
	var conjugations []string
	for _, word := range dictionaryWord.KanjiWords {
		for _, wordType := range dictionaryWord.Types {
			conjugations = append(conjugations, conjugationsForWord(word, wordType)...)
		}
	}
	return conjugations
}

func collectionSubber(word string, collection []string, ending string) (results []string) {
	for _, ending := range collection {
		ending_regex := regexp.MustCompile(ending)
		new_conjugation := ending_regex.ReplaceAllLiteralString(word, ending)
		results = append(results, new_conjugation)
	}
	return
}

func  conjugationsForWord(word, wordType string) []string {
	var conjugations []string

	//Itself is also a thing
	conjugations = append(conjugations, word)
	switch {
	case wordType == "v1" :
		conjugations = append(conjugations, collectionSubber(word,
			[]string{"ない", "ます", "ましょう", "たい", "なさい", "られる", "れば", "よう", "た", "て"},
			"る$")...)

	case wordType == "v5u":
		conjugations = append(conjugations, collectionSubber(word,
			[]string{"わない","います","いましょう","いたい","いなさい","える","え","えば","おう","った","って"},"う$")...)
	case wordType == "v5k":
		conjugations = append(conjugations, collectionSubber(word,
			[]string{"かない","きます","きましょう","きたい","きなさい","ける","け","けば","こう","いた","いて"},"く$")...)
	case wordType == "v5s":
		conjugations = append(conjugations, collectionSubber(word,
			[]string{"さない","します","しましょう","したい","しなさい","せる","せ","せば","そう","した","して"},"す$")...)
	case wordType == "v5t":
		conjugations = append(conjugations, collectionSubber(word,
			[]string{"たない","ちます","ちましょう","ちたい","ちなさい","てる","て","てば","とう","った","って"},"つ$")...)
	case wordType == "v5n":
		conjugations = append(conjugations, collectionSubber(word,
			[]string{"なない","にます","にましょう","にたい","になさい","ねる","ね","ねば","のう","んだ","んで"},"ぬ$")...)
	case wordType == "v5m":
		conjugations = append(conjugations, collectionSubber(word,
			[]string{"まない","みます","みましょう","みたい","みなさい","める","め","めば","もう","んだ","んで"},"む$")...)
	case wordType == "v5r":
		conjugations = append(conjugations, collectionSubber(word,
			[]string{"らない","ります","りましょう","りたい","りなさい","れる","れ","れば","ろう","った","って"},"る$")...)
	case wordType == "v5g":
		conjugations = append(conjugations, collectionSubber(word,
			[]string{"がない","ぎます","ぎましょう","ぎたい","ぎなさい","げる","げ","げば","ごう","いだ","いで"},"ぐ$")...)
	case wordType == "v5b":
		conjugations = append(conjugations, collectionSubber(word,
			[]string{"ばない","びます","びましょう","びたい","びなさい","べる","べ","べば","ぼう","んだ","んで"},"ぶ$")...)
	case wordType == "vk":
        //来る special case
        //TODO: handle くる in hiragana (こない etc.)
		conjugations = append(conjugations, collectionSubber(word,
			[]string{"ない","ます","ましょう","たい","なさい","られる","れば","よう","た","て","される","い"},"る$")...)
	case wordType == "vs-i":
		conjugations = append(conjugations, collectionSubber(word,
			[]string{"しない","します","し","して","した","している","すれば","しょう","できる","される","させる","しろ"},"する$")...)
	}
	//TODO port the rest of conjugations
	return conjugations
}
