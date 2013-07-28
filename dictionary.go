package main
import "regexp"
import "io/ioutil"
import "fmt"



func main() {
	dictionary_entry_regex, err := regexp.Compile(`(.*?) \[(.*?)\] (.*?)\n`)
	if err != nil { panic(err) }

	text, err := ioutil.ReadFile("edict2_utf8")
	if err != nil { panic(err) }

	dictionary_entries := dictionary_entry_regex.FindAllStringSubmatch(string(text),-1)
	for _, dictionary_entry := range dictionary_entries {
		fmt.Println("************ Start of word ****************")

		words := dictionary_entry[1]
		fmt.Printf("'%s' \n", words)

		pronunciations := dictionary_entry[2]
		fmt.Printf("'%s' \n", pronunciations)

		meanings := dictionary_entry[3]
		fmt.Printf("'%s' \n", meanings)

		fmt.Println("End of word \n")
	}
}
