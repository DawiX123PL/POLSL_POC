function latexMatrix = mat2Latex(mat, precision)

    if exist("precision")
        exponent=floor(log10(abs(mat)));
        mantisa = mat .* 10.^-exponent;

        str =  compose("%." + (precision-1) + "f", double(sym(mantisa)))...
             + "^{" + string(exponent) + "}";

        str = join(str, " & ");
        str = join(str, " \\ " + newline);


        str = "\begin{bmatrix}" + newline ...
            + str + newline ...
            + "\end{bmatrix}";

        latexMatrix = str;
        return;

    else
        latexMatrix = latex(sym(mat));
        latexMatrix = strrep(latexMatrix, "array", "bmatrix");
        latexMatrix = strrep(latexMatrix, "\left(", " ");
        latexMatrix = strrep(latexMatrix, "\right)", " ");
        ccc = "{" + join(repmat("c", [size(mat,2),1]),"") + "}";
        latexMatrix = strrep(latexMatrix, ccc, " ");
        latexMatrix = strrep(latexMatrix, "\\", "\\[6pt]" + newline);
    end


end