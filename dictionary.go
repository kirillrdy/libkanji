package main
import "regexp"
import "io/ioutil"
import "fmt"
import "strings"
import "./zfsdb"

func main() {
	dictionary_entry_regex, err := regexp.Compile(`(.*?) \[(.*?)\] (.*?)\n`)
	if err != nil { panic(err) }

	// TODO dont load all at once
	text, err := ioutil.ReadFile("edict2_utf8")
	if err != nil { panic(err) }

	dictionary_entries := dictionary_entry_regex.FindAllStringSubmatch(string(text),-1)
	for _, dictionary_entry := range dictionary_entries {
		fmt.Println("************ Start of word ****************")

		words := dictionary_entry[1]
		for _, word  := range strings.Split(words, ";") {

			dictionary_word := zfsdb.CreateObject()
			dictionary_word.WriteFact("type","dictionary_word")
			dictionary_word.WriteFact("word",word)

			//pronunciations := dictionary_entry[2]
			//fmt.Printf("'%s' \n", pronunciations)

			//meanings := dictionary_entry[3]
			//fmt.Printf("'%s' \n", meanings)

		}
	}
}
