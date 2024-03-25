function getTrace(cpu, cycles)
    local str = ""
    str = str .. getByteRep(cpu.r[1]) .. ":"
    str = str .. getWordRep(cpu.br[4]) .. ":"
    str = str .. getDisassembly(cpu)
    str = str .. "A:" .. getWordRep(cpu.br[0]) .. " "
    str = str .. "X:" .. getWordRep(cpu.br[1]) .. " "
    str = str .. "Y:" .. getWordRep(cpu.br[2]) .. " "
    str = str .. "SP:" .. getWordRep(cpu.br[3]) .. " "
    str = str .. "DBR:" .. getByteRep(cpu.r[0]) .. " "
    str = str .. "DPR:" .. getWordRep(cpu.br[5]) .. " "
    str = str .. getFlags(cpu) .. " " .. "e" .. " "
    str = str .. "CYC:" .. cycles

    return str
end

function getFlags(cpu)
    local val = ""
    val = val .. (cpu.n and "N" or "n")
    val = val .. (cpu.v and "V" or "v")
    val = val .. (cpu.m and "M" or "m")
    val = val .. (cpu.x and "X" or "x")
    val = val .. (cpu.d and "D" or "d")
    val = val .. (cpu.i and "I" or "i")
    val = val .. (cpu.z and "Z" or "z")
    val = val .. (cpu.c and "C" or "c")
    return val
end

function getDisassembly(cpu)
    local op = cpu.mem:read(bit.lshift(cpu.r[1], 16) + cpu.br[4], true)
    local p1 = cpu.mem:read(bit.lshift(cpu.r[1], 16) + bit.band(cpu.br[4] + 1, 0xffff), true)
    local p2 = cpu.mem:read(bit.lshift(cpu.r[1], 16) + bit.band(cpu.br[4] + 2, 0xffff), true)
    local p3 = cpu.mem:read(bit.lshift(cpu.r[1], 16) + bit.band(cpu.br[4] + 3, 0xffff), true)
    local wo = bit.lshift(p2, 8) + p1
    local lo = bit.lshift(p3, 16) + wo

    local name = opNames[op]:upper()
    local mode = cpu.modes[op]
    if mode == 0 then
        return name .. "             "
    elseif mode == 1 then
        return name .. " #$" .. getByteRep(p1) .. "        "
    elseif mode == 2 then
        return name .. " #$" .. (cpu.m and getByteRep(p1) .. "        " or getWordRep(wo) .. "      ")
    elseif mode == 3 then
        return name .. " #$" .. (cpu.x and getByteRep(p1) .. "        " or getWordRep(wo) .. "      ")
    elseif mode == 4 then
        return name .. " #$" .. getWordRep(wo) .. "      "
    elseif mode == 5 then
        return name .. " $" .. getByteRep(p1) .. "         "
    elseif mode == 6 then
        return name .. " $" .. getByteRep(p1) .. ",X       "
    elseif mode == 7 then
        return name .. " $" .. getByteRep(p1) .. ",Y       "
    elseif mode == 8 then
        return name .. " ($" .. getByteRep(p1) .. ")       "
    elseif mode == 9 then
        return name .. " ($" .. getByteRep(p1) .. ",X)     "
    elseif mode == 10 or mode == 11 then
        return name .. " ($" .. getByteRep(p1) .. "),Y     "
    elseif mode == 12 then
        return name .. " [$" .. getByteRep(p1) .. "]       "
    elseif mode == 13 then
        return name .. " [$" .. getByteRep(p1) .. "],Y     "
    elseif mode == 14 then
        return name .. " $" .. getByteRep(p1) .. ",S       "
    elseif mode == 15 then
        return name .. " ($" .. getByteRep(p1) .. ",S),Y   "
    elseif mode == 16 then
        return name .. " $" .. getWordRep(wo) .. "       "
    elseif mode == 17 or mode == 18 then
        return name .. " $" .. getWordRep(wo) .. ",X     "
    elseif mode == 19 or mode == 20 then
        return name .. " $" .. getWordRep(wo) .. ",Y     "
    elseif mode == 21 then
        return name .. " $" .. getLongRep(lo) .. "     "
    elseif mode == 22 then
        return name .. " $" .. getLongRep(lo) .. ",X   "
    elseif mode == 23 then
        return name .. " ($" .. getWordRep(wo) .. ")     "
    elseif mode == 24 then
        return name .. " ($" .. getWordRep(wo) .. ",X)   "
    elseif mode == 25 then
        return name .. " [$" .. getWordRep(wo) .. "]     "
    elseif mode == 26 then
        return name .. " $" .. getWordRep(bit.band(cpu.br[4] + 2 + cpu:getSigned(p1, true), 0xffff)) .. "       "
    elseif mode == 27 then
        return name .. " $" .. getWordRep(bit.band(cpu.br[4] + 3 + cpu:getSigned(wo, false), 0xffff)) .. "       "
    elseif mode == 28 then
        return name .. " #$" .. getByteRep(p2) .. ", #$" .. getByteRep(p1) .. "  "
    end
end

opNames = {
    "brk", "ora", "cop", "ora", "tsb", "ora", "asl", "ora", "php", "ora", "asl", "phd", "tsb", "ora", "asl", "ora",
  "bpl", "ora", "ora", "ora", "trb", "ora", "asl", "ora", "clc", "ora", "inc", "tcs", "trb", "ora", "asl", "ora",
  "jsr", "and", "jsl", "and", "bit", "and", "rol", "and", "plp", "and", "rol", "pld", "bit", "and", "rol", "and",
  "bmi", "and", "and", "and", "bit", "and", "rol", "and", "sec", "and", "dec", "tsc", "bit", "and", "rol", "and",
  "rti", "eor", "wdm", "eor", "mvp", "eor", "lsr", "eor", "pha", "eor", "lsr", "phk", "jmp", "eor", "lsr", "eor",
  "bvc", "eor", "eor", "eor", "mvn", "eor", "lsr", "eor", "cli", "eor", "phy", "tcd", "jml", "eor", "lsr", "eor",
  "rts", "adc", "per", "adc", "stz", "adc", "ror", "adc", "pla", "adc", "ror", "rtl", "jmp", "adc", "ror", "adc",
  "bvs", "adc", "adc", "adc", "stz", "adc", "ror", "adc", "sei", "adc", "ply", "tdc", "jmp", "adc", "ror", "adc",
  "bra", "sta", "brl", "sta", "sty", "sta", "stx", "sta", "dey", "bit", "txa", "phb", "sty", "sta", "stx", "sta",
  "bcc", "sta", "sta", "sta", "sty", "sta", "stx", "sta", "tya", "sta", "txs", "txy", "stz", "sta", "stz", "sta",
  "ldy", "lda", "ldx", "lda", "ldy", "lda", "ldx", "lda", "tay", "lda", "tax", "plb", "ldy", "lda", "ldx", "lda",
  "bcs", "lda", "lda", "lda", "ldy", "lda", "ldx", "lda", "clv", "lda", "tsx", "tyx", "ldy", "lda", "ldx", "lda",
  "cpy", "cmp", "rep", "cmp", "cpy", "cmp", "dec", "cmp", "iny", "cmp", "dex", "wai", "cpy", "cmp", "dec", "cmp",
  "bne", "cmp", "cmp", "cmp", "pei", "cmp", "dec", "cmp", "cld", "cmp", "phx", "stp", "jml", "cmp", "dec", "cmp",
  "cpx", "sbc", "sep", "sbc", "cpx", "sbc", "inc", "sbc", "inx", "sbc", "nop", "xba", "cpx", "sbc", "inc", "sbc",
  "beq", "sbc", "sbc", "sbc", "pea", "sbc", "inc", "sbc", "sed", "sbc", "plx", "xce", "jsr", "sbc", "inc", "sbc"
}

function getSpcTrace(cpu, cycles)
    local str = ""
    str = str .. getWordRep(cpu.br[0]) .. ": "
    str = str .. getSpcDisassembly(cpu)
    str = str .. "A:" .. getByteRep(cpu.r[0]) .. " "
    str = str .. "X:" .. getByteRep(cpu.r[1]) .. " "
    str = str .. "Y:" .. getByteRep(cpu.r[2]) .. " "
    str = str .. "SP:" .. getByteRep(cpu.r[3]) .. " "
    str = str .. getSpcFlags(cpu) .. " "
    str = str .. "CYC:" .. cycles
    return str
end

function getSpcFlags(cpu)
    local val = ""
    val = val .. (cpu.n and "N" or "n")
    val = val .. (cpu.v and "V" or "v")
    val = val .. (cpu.p and "P" or "p")
    val = val .. (cpu.b and "B" or "b")
    val = val .. (cpu.h and "H" or "h")
    val = val .. (cpu.i and "I" or "i")
    val = val .. (cpu.z and "Z" or "z")
    val = val .. (cpu.c and "C" or "c")
    return val
end

function getSpcDisassembly(cpu)
    local op = cpu.mem:read(cpu.br[0])
    local p1 = cpu.mem:read(bit.band(cpu.br[0] + 1, 0xffff))
    local p2 = cpu.mem:read(bit.band(cpu.br[0] + 2, 0xffff))
    local wo = bit.lshift(p2, 8) + p1
    local wob = bit.band(wo, 0x1fff)
    local wobd = bit.rshift(wo, 13)

    local str = spcOpBegin[op]
    local ends = spcOpEnd[op]

    local mode = cpu.modes[op]
    if mode == 0 then
        str = str .. ends
    elseif mode == 1 then
        str = str .. " $" .. getWordRep(bit.band(cpu.br[0] + 2 + cpu:getSigned(p1), 0xffff)) .. ends
    elseif mode == 2 then
        str = str .. " $" .. getByteRep(p1) .. ends
    elseif mode == 3 then
        if bit.band(op, 0xf) == 3 then
            str = str .. " $" .. getByteRep(p1) .. ends .. ", $" .. getWordRep(bit.band(cpu.br[0] + 3 + cpu:getSigned(p2), 0xffff))
        else
            str = str .. " $" .. getByteRep(p1) .. ", $" .. getWordRep(bit.band(cpu.br[0] + 3 + cpu:getSigned(p2), 0xffff)) .. ends
        end
    elseif mode == 4 then
        str = str .. " $" .. getWordRep(wo) .. ends
    elseif mode == 5 then
        str = str .. " (X)" .. ends
    elseif mode == 6 then
        str = str .. " [$" .. getByteRep(p1) .. "+X]" .. ends
    elseif mode == 7 then
        str = str .. " #$" .. getByteRep(p1) .. ends
    elseif mode == 8 then
        str = str .. " $" .. getByteRep(p1) .. "+X" .. ends
    elseif mode == 9 then
        str = str .. " $" .. getWordRep(wo) .. "+X" .. ends
    elseif mode == 10 then
        str = str .. " $" .. getWordRep(wo) .. "+Y" .. ends
    elseif mode == 11 then
        str = str .. " [$" .. getByteRep(p1) .. "]+Y" .. ends
    elseif mode == 12 then
        str = str .. " $" .. getByteRep(p2) .. ", $" .. getByteRep(p1) .. ends
    elseif mode == 13 then
        str = str .. " (X), (Y)" .. ends
    elseif mode == 14 then
        str = str .. " $" .. getByteRep(p2) .. ", #$" .. getByteRep(p1) .. ends
    elseif mode == 15 then
        str = str .. " $" .. getByteRep(p1) .. "+Y" .. ends
    elseif mode == 16 then
        if op == 0x2a or op == 0x6a then
            str = str .. "$" .. getWordRep(wob) .. "." .. wobd .. ends
        else
            str = str .. " $" .. getWordRep(wob) .. "." .. wobd .. ends
        end
    elseif mode == 17 then
        str = str .. " $" .. getByteRep(p1) .. "+X, $" .. getWordRep(bit.band(cpu.br[0] + 3 + cpu:getSigned(p2), 0xffff)) .. ends
    elseif mode == 18 then
        str = str .. " [$" .. getWordRep(wo) .. "+X]" .. ends
    elseif mode == 19 then
        str = str .. " (X+)" .. ends
    end
    local spaces = 20 - #str
    for i = 0, spaces - 1 do
        str = str .. " "
    end
    return str
end

local spcOpBegin = {
  "NOP  ", "TCALL", "SET1 ", "BBS  ", "OR    A,", "OR    A,", "OR    A,", "OR    A,", "OR    A, ", "OR   ", "OR1   C,", "ASL  ", "ASL  ", "PUSH  PSW", "TSET1", "BRK  ",
  "BPL  ", "TCALL", "CLR1 ", "BBC  ", "OR    A,", "OR    A,", "OR    A,", "OR    A,", "OR   ", "OR   ", "DECW ", "ASL  ", "ASL   A", "DEC   X", "CMP   X,", "JMP  ",
  "CLRP ", "TCALL", "SET1 ", "BBS  ", "AND   A,", "AND   A,", "AND   A,", "AND   A,", "AND   A,", "AND  ", "OR1   C, /", "ROL  ", "ROL  ", "PUSH  A", "CBNE ", "BRA  ",
  "BMI  ", "TCALL", "CLR1 ", "BBC  ", "AND   A,", "AND   A,", "AND   A,", "AND   A,", "AND  ", "AND  ", "INCW ", "ROL  ", "ROL   A", "INC   X", "CMP   X,", "CALL ",
  "SETP ", "TCALL", "SET1 ", "BBS  ", "EOR   A,", "EOR   A,", "EOR   A,", "EOR   A,", "EOR   A,", "EOR  ", "AND1  C,", "LSR  ", "LSR  ", "PUSH  X", "TCLR1", "PCALL",
  "BVC  ", "TCALL", "CLR1 ", "BBC  ", "EOR   A,", "EOR   A,", "EOR   A,", "EOR   A,", "EOR  ", "EOR  ", "CMPW  YA,", "LSR  ", "LSR   A", "MOV   X, A", "CMP   Y,", "JMP  ",
  "CLRC ", "TCALL", "SET1 ", "BBS  ", "CMP   A,", "CMP   A,", "CMP   A,", "CMP   A,", "CMP   A,", "CMP  ", "AND1  C, /", "ROR  ", "ROR  ", "PUSH  Y", "DBNZ ", "RET  ",
  "BVS  ", "TCALL", "CLR1 ", "BBC  ", "CMP   A,", "CMP   A,", "CMP   A,", "CMP   A,", "CMP  ", "CMP  ", "ADDW  YA,", "LSR  ", "LSR   A", "MOV   A, X", "CMP   Y,", "RETI ",
  "SETC ", "TCALL", "SET1 ", "BBS  ", "ADC   A,", "ADC   A,", "ADC   A,", "ADC   A,", "ADC   A,", "ADC  ", "EOR1  C,", "DEC  ", "DEC  ", "MOV   Y,", "POP   PSW", "MOV  ",
  "BCC  ", "TCALL", "CLR1 ", "BBC  ", "ADC   A,", "ADC   A,", "ADC   A,", "ADC   A,", "ADC  ", "ADC  ", "SUBW  YA,", "DEC  ", "DEC   A", "MOV   X, SP", "DIV   YA, X", "XCN   A",
  "EI   ", "TCALL", "SET1 ", "BBS  ", "SBC   A,", "SBC   A,", "SBC   A,", "SBC   A,", "SBC   A,", "SBC  ", "MOV1  C,", "INC  ", "INC  ", "CMP   Y,", "POP   A", "MOV  ",
  "BCS  ", "TCALL", "CLR1 ", "BBC  ", "SBC   A,", "SBC   A,", "SBC   A,", "SBC   A,", "SBC  ", "SBC  ", "MOVW  YA,", "INC  ", "INC   A", "MOV   SP, X", "DAS   A", "MOV   A,",
  "DI   ", "TCALL", "SET1 ", "BBS  ", "MOV  ", "MOV  ", "MOV  ", "MOV  ", "CMP   X,", "MOV  ", "MOV1 ", "MOV  ", "MOV  ", "MOV   X,", "POP   A", "MUL   YA",
  "BNE  ", "TCALL", "CLR1 ", "BBC  ", "MOV  ", "MOV  ", "MOV  ", "MOV  ", "MOV  ", "MOV  ", "MOVW ", "MOV  ", "DEC   Y", "MOV   A, Y", "CBNE ", "DAA   A",
  "CLRV ", "TCALL", "SET1 ", "BBS  ", "MOV   A,", "MOV   A,", "MOV   A,", "MOV   A,", "MOV   A,", "MOV   X,", "NOT1 ", "MOV   Y,", "MOV   Y,", "NOTC ", "POP   Y", "SLEEP",
  "BEQ  ", "TCALL", "CLR1 ", "BBC  ", "MOV   A,", "MOV   A,", "MOV   A,", "MOV   A,", "MOV   X,", "MOV   X,", "MOV  ", "MOV   Y,", "INC   Y", "MOV   Y, A", "DBNZ  Y,", "STOP"
}

local spcOpEnd = {
  "", " 0", ".0", ".0", "", "", "", "", "", "", "", "", "", "", "", "",
  "", " 1", ".0", ".0", "", "", "", "", "", "", "", "", "", "", "", "",
  "", " 2", ".1", ".1", "", "", "", "", "", "", "", "", "", "", "", "",
  "", " 3", ".1", ".1", "", "", "", "", "", "", "", "", "", "", "", "",
  "", " 4", ".2", ".2", "", "", "", "", "", "", "", "", "", "", "", "",
  "", " 5", ".2", ".2", "", "", "", "", "", "", "", "", "", "", "", "",
  "", " 6", ".3", ".3", "", "", "", "", "", "", "", "", "", "", "", "",
  "", " 7", ".3", ".3", "", "", "", "", "", "", "", "", "", "", "", "",
  "", " 8", ".4", ".4", "", "", "", "", "", "", "", "", "", "", "", "",
  "", " 9", ".4", ".4", "", "", "", "", "", "", "", "", "", "", "", "",
  "", " 10", ".5", ".5", "", "", "", "", "", "", "", "", "", "", "", ", A",
  "", " 11", ".5", ".5", "", "", "", "", "", "", "", "", "", "", "", "",
  "", " 12", ".6", ".6", ", A", ", A", ", A", ", A", "", ", X",  ", C", ", Y", ", Y", "", "", "",
  "", " 13", ".6", ".6", ", A", ", A", ", A", ", A", ", X", ", X", ", YA", ", Y", "", "", "", "",
  "", " 14", ".7", ".7", "", "", "", "", "", "", "", "", "", "", "", "",
  "", " 15", ".7", ".7", "", "", "", "", "", "", "", "", "", "", "", ""
}

function Uint8Array(size)
    local t = {}
    for i = 1, size do
        t[i] = 0
    end
    return t
end

function Float64Array(size)
    local t = {}
    for i = 1, size do
        t[i] = 0
    end
    return t
end

function Int64Array(size)
    local t = {}
    for i = 1, size do
        t[i] = 0
    end
    return t
end

function Int16Array(size)
    local t = {}
    for i = 1, size do
        t[i] = 0
    end
    return t
end
