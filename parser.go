package libkanji

import (
	"fmt"
	//"strings"
	//"code.google.com/p/go.exp/utf8string"
)

type parsedSentenceItem struct {
	OriginalPart string
	DictionaryWords []*DictionaryWord
}

type ParsedSentence []parsedSentenceItem

func ParseSentence(sentence string) ParsedSentence {
	var parsed ParsedSentence

	fmt.Printf("parsing: %q\n", sentence)
	start_index := 0
	end_index := 0

	var unparsed_buffer string
	for ; start_index < len(sentence); {
		var last_longest_key string = ""

		end_index = start_index + 1
		for end_index = start_index + 1; end_index <= len(sentence) ; end_index++ {

			if _, ok := LookupDictionary[sentence[start_index:end_index]]; ok {
				last_longest_key = sentence[start_index:end_index]
			}
		}
		if last_longest_key == "" {
			unparsed_buffer = unparsed_buffer + sentence[start_index:start_index+1]
			start_index = start_index + 1
		} else {
			if len(unparsed_buffer) != 0 {
				parsed = append(parsed, parsedSentenceItem{unparsed_buffer, nil})
				unparsed_buffer = ""
			}
			parsed = append(parsed, parsedSentenceItem{last_longest_key, LookupDictionary[last_longest_key]})
			start_index = start_index + len(last_longest_key)
		}
	}
	if len(unparsed_buffer) != 0 {
		parsed = append(parsed, parsedSentenceItem{unparsed_buffer, nil})
	}
	return parsed
}
