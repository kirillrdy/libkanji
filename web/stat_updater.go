package main

// import (
// 	"fmt"
// 	"runtime"
// 	"time"

// 	"github.com/kirillrdy/nadeshiko"
// )

// func memoryAndTimeUpdater(document *nadeshiko.Document) {
// 	document.JQuery(clock).SetText(fmt.Sprintf("%s", time.Now().Format("15:04:05")))

// 	var memory_stat runtime.MemStats
// 	runtime.ReadMemStats(&memory_stat)
// 	in_mb := float32(memory_stat.Alloc) / float32(1024.0*1024)
// 	document.JQuery(memoryUsage).SetText(fmt.Sprintf("%0.2f", in_mb))
// 	//document.JQuery(lookupSize).SetText(fmt.Sprintf("%d", len(dictionary)))
// }
// func setupUpdater(document *nadeshiko.Document) {

// 	memoryAndTimeUpdater(document)
// 	go func() {
// 		updateTicker := time.Tick(500 * time.Millisecond)
// 		for _ = range updateTicker {
// 			memoryAndTimeUpdater(document)
// 		}
// 	}()

// }
