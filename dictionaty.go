package main
import "regexp"
import "io/ioutil"
import "fmt"



func main() {
	dictionary_words, err := regexp.Compile(`(.*?) \[(.*?)\] (.*?)\n`)
	if err != nil { panic(err) }

	text, err := ioutil.ReadFile("edict2_utf8")
	list_of_strings := dictionary_words.FindAllStringSubmatch(string(text),-1)
	for _, word := range list_of_strings {
		fmt.Println("************ Start of word ****************")
		for _, sub_march := range word {
			fmt.Printf("'%s' \n", sub_march)
		}
		fmt.Println("End of word \n")
	}
}
