package libkanji

import "regexp"

func conjugationsForWord(word, wordType string) []string {
	var conjugations []string

	switch {
	case wordType == "v1":
		conjugations = append(conjugations, collectionSubber(word,
			[]string{"ない", "ます", "ましょう", "たい", "なさい", "られる", "れば", "よう", "た", "て"},
			"る$")...)

	case wordType == "v5u":
		conjugations = append(conjugations, collectionSubber(word,
			[]string{"わない", "います", "いましょう", "いたい", "いなさい", "える", "え", "えば", "おう", "った", "って"}, "う$")...)
	case wordType == "v5k":
		conjugations = append(conjugations, collectionSubber(word,
			[]string{"かない", "きます", "きましょう", "きたい", "きなさい", "ける", "け", "けば", "こう", "いた", "いて"}, "く$")...)
	case wordType == "v5s":
		conjugations = append(conjugations, collectionSubber(word,
			[]string{"さない", "します", "しましょう", "したい", "しなさい", "せる", "せ", "せば", "そう", "した", "して"}, "す$")...)
	case wordType == "v5t":
		conjugations = append(conjugations, collectionSubber(word,
			[]string{"たない", "ちます", "ちましょう", "ちたい", "ちなさい", "てる", "て", "てば", "とう", "った", "って"}, "つ$")...)
	case wordType == "v5n":
		conjugations = append(conjugations, collectionSubber(word,
			[]string{"なない", "にます", "にましょう", "にたい", "になさい", "ねる", "ね", "ねば", "のう", "んだ", "んで"}, "ぬ$")...)
	case wordType == "v5m":
		conjugations = append(conjugations, collectionSubber(word,
			[]string{"まない", "みます", "みましょう", "みたい", "みなさい", "める", "め", "めば", "もう", "んだ", "んで"}, "む$")...)
	case wordType == "v5r":
		conjugations = append(conjugations, collectionSubber(word,
			[]string{"らない", "ります", "りましょう", "りたい", "りなさい", "れる", "れ", "れば", "ろう", "った", "って"}, "る$")...)
	case wordType == "v5g":
		conjugations = append(conjugations, collectionSubber(word,
			[]string{"がない", "ぎます", "ぎましょう", "ぎたい", "ぎなさい", "げる", "げ", "げば", "ごう", "いだ", "いで"}, "ぐ$")...)
	case wordType == "v5b":
		conjugations = append(conjugations, collectionSubber(word,
			[]string{"ばない", "びます", "びましょう", "びたい", "びなさい", "べる", "べ", "べば", "ぼう", "んだ", "んで"}, "ぶ$")...)
	case wordType == "vk":
		//来る special case
		//TODO: handle くる in hiragana (こない etc.)
		conjugations = append(conjugations, collectionSubber(word,
			[]string{"ない", "ます", "ましょう", "たい", "なさい", "られる", "れば", "よう", "た", "て", "される", "い"}, "る$")...)
	case wordType == "vs-i":
		conjugations = append(conjugations, collectionSubber(word,
			[]string{"しない", "します", "し", "して", "した", "している", "すれば", "しょう", "できる", "される", "させる", "しろ"}, "する$")...)
	case wordType == "v5r-i":
		conjugations = append(conjugations, collectionSubber(word,
			[]string{"いない", "あり", "あります", "あって", "あった", "あれば"}, "ある$")...)

	case wordType == "adj", wordType == "adj-i":
		conjugations = append(conjugations, collectionSubber(word,
			[]string{"く", "くない", "くて", "かった", "ければ", "くなかった"}, "い$")...)

	case wordType == "adj-na":
		conjugations = append(conjugations, word+"な")

	}
	//TODO port the rest of conjugations
	//fmt.Printf("%q - %q\n",word, conjugations)
	return conjugations
}

func collectionSubber(word string, collection []string, ending string) (results []string) {

	for _, endingToReplace := range collection {
		endingRegex := regexp.MustCompile(ending)
		newConjugation := endingRegex.ReplaceAllLiteralString(word, endingToReplace)
		results = append(results, newConjugation)
	}
	return
}
