
package main

import "fmt"
import "net/http"

const body string = `
<html>
  <head>
    <title>Hello world!</title>
    <!--meta http-equiv="refresh" content="3" /-->
  </head>
  <body>
    Hello from go!
  </body>
</html>
`

func main() {
  http.HandleFunc("/", HelloWorld)
  http.ListenAndServe(":3002", nil)
}

func HelloWorld(w http.ResponseWriter, r *http.Request) {
  fmt.Fprintf(w, body)
}
