package main

import "./zfsdb"
import "fmt"

func main() {
	kanji := zfsdb.Find("pronunciation", "こうかおん")
	fmt.Println(kanji.ReadFact("word"))
}
