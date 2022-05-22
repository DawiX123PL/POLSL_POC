function img = cropImage(image, crop)

    w = size(image,2);
    h = size(image,1);

    top   = round(crop(1) * h);
    bot   = round(crop(2) * h);
    left  = round(crop(3) * w);
    right = round(crop(4) * w);

    if top <= 0
        top = 1;
    end

    if left <= 0
        left = 1;
    end

    if bot < 0
        bot = 0;
    end
    
    if right < 0
        right = 0;
    end



    img = image( top:end-bot, left:end-right,  : );

end

