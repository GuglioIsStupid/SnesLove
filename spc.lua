Spc = {}
Spc.A = 0
Spc.X = 1
Spc.Y = 2
Spc.SP = 3 
Spc.PC = 0

Spc.IMP = 0
Spc.REL = 1
Spc.DP = 2
Spc.DPR = 3
Spc.ABS = 4
Spc.IND = 5
Spc.IDX = 6
Spc.IMM = 7
Spc.DPX = 8
Spc.ABX = 9
Spc.ABY = 10
Spc.IDY = 11
Spc.DD = 12
Spc.II = 13
Spc.DI = 14
Spc.DPY = 15
Spc.ABB = 16
Spc.DXR = 17
Spc.IAX = 18
Spc.IPI = 19

function Spc.set(mem)
    Spc.mem = mem
    Spc.r = {}
    Spc.br = {}

    Spc.Modes = {
        Spc.IMP, Spc.IMP, Spc.DP , Spc.DPR, Spc.DP , Spc.ABS, Spc.IND, Spc.IDX, Spc.IMM, Spc.DD , Spc.ABB, Spc.DP , Spc.ABS, Spc.IMP, Spc.ABS, Spc.IMP,
        Spc.REL, Spc.IMP, Spc.DP , Spc.DPR, Spc.DPX, Spc.ABX, Spc.ABY, Spc.IDY, Spc.DI , Spc.II , Spc.DP , Spc.DPX, Spc.IMP, Spc.IMP, Spc.ABS, Spc.IAX,
        Spc.IMP, Spc.IMP, Spc.DP , Spc.DPR, Spc.DP , Spc.ABS, Spc.IND, Spc.IDX, Spc.IMM, Spc.DD , Spc.ABB, Spc.DP , Spc.ABS, Spc.IMP, Spc.DPR, Spc.REL,
        Spc.REL, Spc.IMP, Spc.DP , Spc.DPR, Spc.DPX, Spc.ABX, Spc.ABY, Spc.IDY, Spc.DI , Spc.II , Spc.DP , Spc.DPX, Spc.IMP, Spc.IMP, Spc.DP , Spc.ABS,
        Spc.IMP, Spc.IMP, Spc.DP , Spc.DPR, Spc.DP , Spc.ABS, Spc.IND, Spc.IDX, Spc.IMM, Spc.DD , Spc.ABB, Spc.DP , Spc.ABS, Spc.IMP, Spc.ABS, Spc.DP ,
        Spc.REL, Spc.IMP, Spc.DP , Spc.DPR, Spc.DPX, Spc.ABX, Spc.ABY, Spc.IDY, Spc.DI , Spc.II , Spc.DP , Spc.DPX, Spc.IMP, Spc.IMP, Spc.ABS, Spc.ABS,
        Spc.IMP, Spc.IMP, Spc.DP , Spc.DPR, Spc.DP , Spc.ABS, Spc.IND, Spc.IDX, Spc.IMM, Spc.DD , Spc.ABB, Spc.DP , Spc.ABS, Spc.IMM, Spc.IMP, Spc.DI ,
        Spc.REL, Spc.IMP, Spc.DP , Spc.DPR, Spc.DPX, Spc.ABX, Spc.ABY, Spc.IDY, Spc.DI , Spc.II , Spc.DP , Spc.DPX, Spc.IMP, Spc.IMP, Spc.DP , Spc.IMP,
        Spc.IMP, Spc.IMP, Spc.DP , Spc.DPR, Spc.DP , Spc.ABS, Spc.IND, Spc.IDX, Spc.IMM, Spc.DD , Spc.ABB, Spc.DP , Spc.ABS, Spc.IMM, Spc.IMP, Spc.DI ,
        Spc.REL, Spc.IMP, Spc.DP , Spc.DPR, Spc.DPX, Spc.ABX, Spc.ABY, Spc.IDY, Spc.DI , Spc.II , Spc.DP , Spc.DPX, Spc.IMP, Spc.IMP, Spc.IMP, Spc.IMP,
        Spc.IMP, Spc.IMP, Spc.DP , Spc.DPR, Spc.DP , Spc.ABS, Spc.IND, Spc.IDX, Spc.IMM, Spc.DD , Spc.ABB, Spc.DP , Spc.ABS, Spc.IMM, Spc.IMP, Spc.IPI,
        Spc.REL, Spc.IMP, Spc.DP , Spc.DPR, Spc.DPX, Spc.ABX, Spc.ABY, Spc.IDY, Spc.DI , Spc.II , Spc.DP , Spc.DPX, Spc.IMP, Spc.IMP, Spc.IMP, Spc.IPI,
        Spc.IMP, Spc.IMP, Spc.DP , Spc.DPR, Spc.DP , Spc.ABS, Spc.IND, Spc.IDX, Spc.IMM, Spc.DD , Spc.ABB, Spc.DP , Spc.ABS, Spc.IMM, Spc.IMP, Spc.IMP,
        Spc.REL, Spc.IMP, Spc.DP , Spc.DPR, Spc.DPX, Spc.ABX, Spc.ABY, Spc.IDY, Spc.DP , Spc.DPY, Spc.DP , Spc.DPX, Spc.IMP, Spc.IMP, Spc.DD , Spc.IMP,
        Spc.IMP, Spc.IMP, Spc.DP , Spc.DPR, Spc.DP , Spc.ABS, Spc.IND, Spc.IDX, Spc.IMM, Spc.DD , Spc.ABB, Spc.DP , Spc.ABS, Spc.IMP, Spc.IMP, Spc.IMP,
        Spc.REL, Spc.IMP, Spc.DP , Spc.DPR, Spc.DPX, Spc.ABX, Spc.ABY, Spc.IDY, Spc.DP , Spc.DPY, Spc.DD , Spc.DPX, Spc.IMP, Spc.IMP, Spc.REL, Spc.IMP
    }

    Spc.cycles = {
        2, 8, 4, 5, 3, 4, 3, 6, 2, 6, 5, 4, 5, 4, 6, 8,
      2, 8, 4, 5, 4, 5, 5, 6, 5, 5, 6, 5, 2, 2, 4, 6,
      2, 8, 4, 5, 3, 4, 3, 6, 2, 6, 5, 4, 5, 4, 5, 4,
      2, 8, 4, 5, 4, 5, 5, 6, 5, 5, 6, 5, 2, 2, 3, 8,
      2, 8, 4, 5, 3, 4, 3, 6, 2, 6, 4, 4, 5, 4, 6, 6,
      2, 8, 4, 5, 4, 5, 5, 6, 5, 5, 4, 5, 2, 2, 4, 3,
      2, 8, 4, 5, 3, 4, 3, 6, 2, 6, 4, 4, 5, 4, 5, 5,
      2, 8, 4, 5, 4, 5, 5, 6, 5, 5, 5, 5, 2, 2, 3, 6,
      2, 8, 4, 5, 3, 4, 3, 6, 2, 6, 5, 4, 5, 2, 4, 5,
      2, 8, 4, 5, 4, 5, 5, 6, 5, 5, 5, 5, 2, 2, 12,5,
      2, 8, 4, 5, 3, 4, 3, 6, 2, 6, 4, 4, 5, 2, 4, 4,
      2, 8, 4, 5, 4, 5, 5, 6, 5, 5, 5, 5, 2, 2, 3, 4,
      2, 8, 4, 5, 4, 5, 4, 7, 2, 5, 6, 4, 5, 2, 4, 9,
      2, 8, 4, 5, 5, 6, 6, 7, 4, 5, 5, 5, 2, 2, 6, 3,
      2, 8, 4, 5, 3, 4, 3, 6, 2, 4, 5, 3, 4, 3, 4, 3,
      2, 8, 4, 5, 4, 5, 5, 6, 3, 4, 5, 4, 2, 2, 4, 3
    }

    function Spc.reset()
        Spc.r[Spc.A] = 0
        Spc.r[Spc.X] = 0
        Spc.r[Spc.Y] = 0
        Spc.r[Spc.SP] = 0

        if Spc.mem.read then
            Spc.br[Spc.PC] = bit.bor(Spc.mem.read(0xfffe), bit.lshift(Spc.mem.read(0xffff), 8))
        else
            Spc.br[Spc.PC] = 0
        end

        Spc.n = false
        Spc.v = false
        Spc.p = false
        Spc.b = false
        Spc.h = false
        Spc.i = false
        Spc.z = false
        Spc.c = false

        Spc.cyclesLeft = 7
    end

    function Spc.cycle()
        --[[
            if(this.cyclesLeft === 0) {
        // the spc in the snes does not have interrupts,
        // so no checking is needed
        let instr = this.mem.read(this.br[PC]++);
        let mode = this.modes[instr];
        this.cyclesLeft = this.cycles[instr];

        try {
          let eff = this.getAdr(mode);
          this.functions[instr].call(this, eff[0], eff[1], instr);
        } catch(e) {
          log("Error with opcode " + getByteRep(instr) + ": " + e);
        }
      }
      this.cyclesLeft--;
        ]]
        if  Spc.cyclesLeft == 0 then
            local instr = Spc.mem.read(Spc.br[Spc.PC])
            Spc.br[Spc.PC] = Spc.br[Spc.PC] + 1
            local mode = Spc.Modes[instr]
            Spc.cyclesLeft = Spc.cycles[instr]
            local eff = Spc.getAdr(mode)
            Spc.functions[instr](eff[0], eff[1], instr)
        end
        Spc.cyclesLeft = Spc.cyclesLeft - 1
    end

    function Spc.setP()

    end
end
