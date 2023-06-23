
const express = require('express')
const app = express()
const port = 3000

let body = `
<html>
  <head>
    <title>Hello world!</title>
    <!--meta http-equiv="refresh" content="3" /-->
  </head>
  <body>
    Hello from express!
  </body>
</html>
`

app.get('/', (req, res) => {
  res.send(body)
})

app.listen(port, () => {
  console.log(`Example app listening on port ${port}`)
})
