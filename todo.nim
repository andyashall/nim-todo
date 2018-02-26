import os, strutils, times, streams, sequtils

# let f = readFile("todos.txt")

if existsFile("todos.txt") == false:
  writeFile("todos.txt", "")

# let f = open("todos.txt")

# # f.writeLine("hello")

# for i in f.lines:
#   echo i
  
# f.close()
let file = readFile("todos.txt")

# echo "\n"

if paramCount() != 0:
  if toLowerAscii(paramStr(1)) == "add":
    var item = getDateStr() & " " & paramStr(2)
    for i in 3..paramCount():
      item = item & " " & paramStr(i)
    let content = file & item & "\n"
    writeFile("todos.txt", content) # change this to a write line

  elif toLowerAscii(paramStr(1)) == "complete":
    let f = open("todos.txt")
    var
      cnt = 1
      oldLine = ""
      newLine = ""
    for ln in f.lines:
      if ln[0] != "x"[0]:
        if intToStr(cnt) == paramStr(2):
          oldLine = ln
          newLine = "x " & getDateStr() & ln
        cnt+=1
    let newCont = replace(file, oldLine, newLine)
    writeFile("todos.txt", newCont)

  elif toLowerAscii(paramStr(1)) == "delete":
    echo "delete"

  elif toLowerAscii(paramStr(1)) == "projects":
    let words = deduplicate(splitWhitespace(file))
    for w in words:
      if contains(w, "@"): echo w

  elif toLowerAscii(paramStr(1)) == "completed":
    var cnt = 1
    if paramCount() == 2:
      if contains(paramStr(2), "@"):
        let f = open("todos.txt")
        for ln in f.lines:
          if ln[0] == "x"[0] and contains(ln, paramStr(2)):
            echo intToStr(cnt) & ": " & ln
            cnt+=1
    else:
      let f = open("todos.txt")
      var cnt = 1
      for ln in f.lines:
        if ln[0] == "x"[0]:
          echo intToStr(cnt) & ": " & ln
          cnt+=1

  elif contains(paramStr(1), "@"):
    let f = open("todos.txt")
    for ln in f.lines:
      if contains(ln, paramStr(1)):
        echo ln
  else:
    var cnt = 1
    let f = open("todos.txt")
    for ln in f.lines:
      if ln[0] != "x"[0]:
        echo intToStr(cnt) & ": " & ln
        cnt+=1
else:
  var cnt = 1
  let f = open("todos.txt")
  for ln in f.lines:
    if ln[0] != "x"[0]:
      echo intToStr(cnt) & ": " & ln
      cnt+=1

# echo "\n"