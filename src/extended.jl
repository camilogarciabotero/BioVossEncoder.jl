import Base: size, show

size(b::VossEncoder) = size(b.bitmatrix)

function Base.show(io::IO, ve::VossEncoder)
    println(io, " $(size(ve.bitmatrix, 1))×$(size(ve.bitmatrix, 2)) Voss Matrix of $(ve.alphabet):")

    for row in 1:size(ve.bitmatrix, 1)
        print(io, " ")
        max_cols = size(ve.bitmatrix, 2)
        cols_to_show = min(15 , max_cols)
        
        for col in 1:cols_to_show
            col = max(col, 1)  # Ensure col is within valid range
            print(io, " ", rpad(ve.bitmatrix[row, col] == 1 ? '1' : '0', 2))
        end
        
        if max_cols > 6
            print(io, "   ", rpad("…", 5))
            
            for col in (max_cols - 15):max_cols
                col = max(col, 1)  # Ensure col is within valid range
                print(io, " ", rpad(ve.bitmatrix[row, col] == 1 ? '1' : '0', 2))
            end
        end
        
        println(io)
    end
end