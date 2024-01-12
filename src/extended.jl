import Base: length, size

# length(b::BSM) = size(b.bsm, 2)
size(b::BSM) = size(b.bsm)