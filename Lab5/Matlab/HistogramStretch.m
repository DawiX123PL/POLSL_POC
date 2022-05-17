function I1 = HistogramStretch(I1, mode)

a = 0;
b = 1;
A = 0;
B = 1;

if mode == "NoCut"
    a = min(I1, [], "all");
    b = max(I1, [], "all");
elseif mode == "Auto"

    

end


I1 = (B-A) / (b-a) * (I1 - a) + A;
end