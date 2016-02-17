package main

import (
	"github.com/kirillrdy/gopherjs/js"
	"github.com/kirillrdy/libkanji"
	"github.com/kirillrdy/nadeshiko/html"
	"github.com/sparkymat/webdsl/css"
	"honnef.co/go/js/dom"
	"log"
	"net/http"
	"time"
)

const clock css.Id = "clock"
const memoryUsage css.Id = "memory_usage"
const lookupSize css.Id = "lookup_size"
const processButton css.Id = "lookup_size"

const textInput css.Id = "text_input"
const results css.Id = "results"
const exampleButton css.Id = "example_button"
const lead css.Class = "lead"

func mainView() html.Node {
	return html.Div().Children(
		html.Div().Children(
			html.Div().Id(clock),
			html.Div().Id(memoryUsage),
			html.Div().Id(lookupSize),
			html.Button().Id(exampleButton).Text("Example"),
			html.Textarea().Id(textInput),
			html.Button().Id(processButton).Text("Process"),
			html.P().Id(results).Class(lead),
		),
	)
}

func getValue(selector css.Selector) string {
	return dom.GetWindow().Document().QuerySelector(selector.Selector()).Underlying().Get("value").String()
}

func setValue(selector css.Selector, value string) {
	dom.GetWindow().Document().QuerySelector(selector.Selector()).Underlying().Set("value", value)
}

func addClick(selector css.Selector, handler func(dom.Event)) {
	document := dom.GetWindow().Document()
	document.QuerySelector(selector.Selector()).AddEventListener("click", true, handler)
}

// func processText(document dom.Document) {
// 	document.JQuery(textInput).GetVal(func(value string) {
// 		parsed := dictionary.ParseMultiLine(value)

// 		for _, item := range parsed {
// 			var tooltipText string
// 			for _, dictionaryWord := range item.DictionaryWords {
// 				tooltipText += fmt.Sprintf("%s ", dictionaryWord.Pronunciations[0])
// 				tooltipText += fmt.Sprintf("%s\n", dictionaryWord.Meanings[0])
// 			}
// 			link := html.A().Href("#").Attribute("data-toggle", "tooltip").Title(tooltipText).Text(item.OriginalPart)
// 			document.JQuery(results).Append(link)

// 		}
// 		document.JQuery(css.Body).Tooltip()
// 	})
// }

func mainPage(document dom.Document) {
	js.SetBody(mainView())

	//TODO fix this
	//document.IncludeBootstrapCdn()
	//document.IncludeBootstrapJsCdn()

	addClick(exampleButton, func(dom.Event) {
		sentence := "私がこの世でいちばん好きな場所は台所だと思う。"
		log.Println("Setting")
		setValue(textInput, sentence)
		// processText(document)
	})

	// document.JQuery(processButton).Click(func() {
	// 	processText(document)
	// })

	// setupUpdater(document)
}

func main() {
	js.AddRoute("/", mainPage)
	js.RouterRun()

	response, err := http.Get("/edict")
	if err != nil {
		log.Panic(err)
	}

	var dictionary libkanji.Dictionary

	go func() {
		now := time.Now()
		log.Println("Started parsing dictionary this will take a while ...")
		dictionary = libkanji.ParseDictionary(response.Body, true)
		defer response.Body.Close()
		log.Printf("len %d", dictionary.Size())
		log.Printf("Taken %v", time.Since(now))
	}()

}
