import Base: length, size, show

# length(b::BSM) = size(b.bsm, 2)
size(b::BSM) = size(b.bsm)

function Base.show(io::IO, bsm::BSM)
    println(io, " $(size(bsm.bsm, 1))×$(size(bsm.bsm, 2)) BinarySequenceMatrix of $(bsm.alphabet):")
    # msize = size(bsm.bsm)

    for row in 1:size(bsm.bsm, 1)
        print(io, " ")
        max_cols = size(bsm.bsm, 2)
        cols_to_show = min(15 , max_cols)
        
        for col in 1:cols_to_show
            print(io, " ", rpad(bsm.bsm[row, col] == 1 ? '1' : '0', 2))
        end
        
        if max_cols > 6
            print(io, "   ", rpad("…", 5))
            
            for col in (max_cols - 15):max_cols
                print(io, " ", rpad(bsm.bsm[row, col] == 1 ? '1' : '0', 2))
            end
        end
        
        println(io)
    end
end