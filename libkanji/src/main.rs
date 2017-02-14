use std::io::BufReader;
use std::io::BufRead;
use std::fs::File;
use std::collections::HashMap;
use std::error::Error;
use std::fmt;


extern crate regex;

use regex::Regex;

fn main() {
    parse_dictionary();
}
#[derive(Default, Debug)]
struct DictionaryEntry {
    kanji_words: Vec<String>,
    types: Vec<String>,
    pronunciations: Vec<String>,
    meanings: Vec<String>,
    original_string: String,
}
type Dictionary = HashMap<String, Vec<DictionaryEntry>>;

type Edict = Vec<DictionaryEntry>;

fn parse_dictionary() -> Dictionary {
    let dictionary: Dictionary = HashMap::new();

    let mut edict: Edict = Vec::new();

    let file = File::open("../edict2_utf8").unwrap();
    let buffer = BufReader::new(&file);
    for line in buffer.lines() {
        let line = line.unwrap();
        let word = parse_dictionary_line(line);
        edict.push(word.unwrap()); //TODO get rid of unwrap

        //println!("{:?}", word);

        //     if len(word.KanjiWords) != 0 {
        //         conjugations := word.Conjugations()
        //             for i := range conjugations {
        //dictionary.bigHash[conjugations[i]] = append(dictionary.bigHash[conjugations[i]], word)
        //             }
        //     }
    }

    dictionary
}


#[derive(Debug)]
struct ParseError {
    description: String,
}

impl fmt::Display for ParseError {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        write!(f, "{}", self.description)
    }
}

impl Error for ParseError {
    fn description(&self) -> &str {
        self.description.as_str()
    }

    fn cause(&self) -> Option<&Error> {
        None
    }
}

fn parse_dictionary_line(original: String) -> Result<DictionaryEntry, Box<Error>> {

    //TODO is this slow ?
    let mut dictionary_entry: DictionaryEntry = Default::default();


    //TODO might have to fix regexes
    //TODO lazy static
    let dictionary_entry_regex = Regex::new(r"(.*?) \[(.*?)\] /\((.*?)\) (.*?)$")?;
    let furigana_entry_regex = Regex::new(r"(.*?) /\((.*?)\) (.*?)$")?;

    let mut dictionary_entries = dictionary_entry_regex.captures(original.as_str());
    //TODO fix
    if dictionary_entries.is_none() {
        //TODO do re letting inside if statement changes value
        dictionary_entries = furigana_entry_regex.captures(original.as_str());
        if dictionary_entries.is_none() {
            let error_message = format!("gave up on {} \n", original);
            let error = ParseError { description: error_message };
            return Err(Box::new(error));
        }
    }

    let dictionary_entries = dictionary_entries.unwrap();

    // strip_ending_regex := regexp.MustCompile(`\(.*?\)$`)
    for word in dictionary_entries.get(1).unwrap().as_str().split(';') {
        //TODO strip ending of kanji
        // 	stripped_word := strip_ending_regex.ReplaceAllLiteralString(kanjiWord, "")
        dictionary_entry.kanji_words.push(word.to_string());
    }

    if dictionary_entries.len() == 5 {
        dictionary_entry.pronunciations =
            clone_vector_of_str(dictionary_entries.get(2).unwrap().as_str().split(';').collect());
        dictionary_entry.types =
            clone_vector_of_str(dictionary_entries.get(3).unwrap().as_str().split(',').collect());
        dictionary_entry.meanings =
            clone_vector_of_str(dictionary_entries.get(4).unwrap().as_str().split('/').collect());
    } else if dictionary_entries.len() == 4 {
        dictionary_entry.pronunciations =
            clone_vector_of_str(dictionary_entries.get(1).unwrap().as_str().split(';').collect());
        dictionary_entry.types =
            clone_vector_of_str(dictionary_entries.get(2).unwrap().as_str().split(',').collect());
        dictionary_entry.meanings =
            clone_vector_of_str(dictionary_entries.get(3).unwrap().as_str().split('/').collect());
    } else {
        panic!("Could not parse word correctly")
    }

    //fmt.Printf("%q \n", word.KanjiWords)

    //TODO strip '()' from words
    //TODO split pronunciations by ';'
    //Get type of meaning in brakets  eg (n)
    // Pronunciations also have '()'

    //TODO maybe remove in the future to save memory
    //TODO Dont do cloning somehow? move this to be last
    dictionary_entry.original_string = original.clone();
    Ok(dictionary_entry)
}

fn clone_vector_of_str(original: Vec<&str>) -> Vec<String> {
    let mut new: Vec<String> = Vec::new();
    for item in original {
        new.push(item.to_string())
    }
    new
}
