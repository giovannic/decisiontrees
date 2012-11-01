function [ ent ] = ENTROPY( p, n )
    ent = -p * log2(p) - n * log2(n);
end

