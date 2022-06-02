function fileContentImages = CreateLatexImages(imagesPath, descriptions, label, ID)

        

        begining = join([ ...
            "\newcommand{\ww}{" + (1 / size(imagesPath,2) - 0.01) + "} ";
            "\begin{figure}[H] ";
            "    \captionsetup[subfloat]{justification=raggedright,singlelinecheck=false, position=bottom,labelformat=empty} % ";
             ],newline );

        ending = join([ ...
            "\caption{" + label + "}  ";
            "\label{fig:" + ID + "} ";
            "\end{figure} ";
            "\let\ww\undefined "...
            ],newline );

        body = ...
            "    \subfloat[" + descriptions + "]{" + newline + ...
            "       \includegraphics[width=\ww\linewidth]{" + imagesPath + "}}";

        body = join(body, "  \hfill% " + newline);
        body = join(body, "  \\ " + newline);

        fileContentImages = join([begining, body, ending],newline );


end