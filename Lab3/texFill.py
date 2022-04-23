# przykład uzycia 
# python texFill.py 'sprawko\sprawko.tex' 'sprawko\sprawko_final.tex'


import re
# [m.start() for m in re.finditer('test', 'test test test test')]
# #[0, 5, 10, 15]
import sys




with open(sys.argv[1], encoding = 'utf-8') as f:
    texfile = f.read()
    startPos = [m.start() for m in re.finditer('----!', texfile)]
    endPos   = [m.start() for m in re.finditer('!----', texfile)]

    textToReplaceList = []
    newTextList = []

    for [s, e] in zip(startPos,endPos):
        
        textToReplace = texfile[s:(e+5)]
        textToReplaceList.append(textToReplace)


        [_,text,_] = textToReplace.split('!')
        textList = text.split(':')
        textList.append(None)

        srcName = textList[0]
        lineNr = textList[1]

        print("s:" + str(s) + "\te:" + str(e) + " \t " + "srcName: " + str(srcName) + " \tlineNr: " + str(lineNr) )

        with open(srcName, encoding = 'utf-8') as sourceFile:
            newTextAll = sourceFile.read()
            if lineNr is not None:
                newText = newTextAll.splitlines()[int(lineNr)-1]
            else:
                newText = newTextAll

            print("old:_" + textToReplace + "_\tnew: _" + newText + "_")

            newTextList.append(newText);


    for [old, new] in zip(textToReplaceList,newTextList):
        texfile = texfile.replace(old,new)
    
    with open(sys.argv[2], 'w' ,encoding = 'utf-8') as targetFile:
        targetFile.write(texfile)




    




