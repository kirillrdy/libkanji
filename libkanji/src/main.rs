use std::io::BufReader;
use std::io::BufRead;
use std::fs::File;
use std::collections::HashMap;

extern crate regex;

use regex::Regex;

fn main() {
}
struct DictionaryEntry {
	  kanji_words:     Vec<String>,
	  types:  Vec<String>,
	  pronunciations: Vec<String>,
	  meanings:       Vec<String>,
	  original_string: String
}
type Dictionary = HashMap<String, Vec<DictionaryEntry>>;

fn parse_dictionary() -> Dictionary {
    let mut dictionary: Dictionary;

    let file = File::open("../edict2_utf8").unwrap();
    let file = BufReader::new(&file);
    for line in file.lines() {
        let l = line.unwrap();
        println!("{}", l);
        let word = ParseDictionaryLine(edictFileScanner.Text())

		        if len(word.KanjiWords) != 0 {
			          conjugations := word.Conjugations()
			              for i := range conjugations {
				                dictionary.bigHash[conjugations[i]] = append(dictionary.bigHash[conjugations[i]], word)
			              }
		        }
    }

	  dictionary
}
fn parse_dictionary_line(original String) ->  Result<DictionaryEntry, Box<Error>>{

    let mut word = DictionaryEntry{};
	//TODO maybe remove in the future to save memory
	word.originalString = original;

  //TODO might have to fix regexes
	dictionary_entry_regex = Regex::new(r"(.*?) \[(.*?)\] /\((.*?)\) (.*?)$")?;
	furigana_entry_regex, err := Regex::new(r"(.*?) /\((.*?)\) (.*?)$")?;

	let dictionary_entries = dictionary_entry_regex.captures(original)?;
  //TODO fix
	//if len(dictionary_entries) == 0 {
	//	dictionary_entries = furigana_entry_regex.FindStringSubmatch(original)
	//	if len(dictionary_entries) == 0 {
	//		return
	//		log.Printf("gave up on %q \n", original)
	//	}
	//}

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
