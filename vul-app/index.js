const express = require("express");
const path = require("path")
const parseurl = require('parseurl')
const nunjucks = require("nunjucks")

const app = express();

app.use(express.static("public"))

app.get("/", (req, res) => {
  const staticDir = path.resolve(__dirname, "static")
  res.sendFile("index.html", {root: staticDir}, (err) => {
    res.end();
    if (err) throw(err);
  })
});


app.get('/page', (req, res) => {
  const errorMessage = "<h2> Unable to find " + req.query.name + "</h2>"
  rendered = nunjucks.renderString(str=errorMessage);
  res.status(404).send(rendered);
})

app.listen(5000, () => {
  console.log("App is listening on port 5000");
});