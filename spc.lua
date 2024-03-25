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

    --[[
        this.functions = [
      this.nop , this.tcall,this.set1, this.bbs , this.or  , this.or  , this.or  , this.or  , this.or  , this.orm , this.or1 , this.asl , this.asl , this.pushp,this.tset1,this.brk ,
      this.bpl , this.tcall,this.clr1, this.bbc , this.or  , this.or  , this.or  , this.or  , this.orm , this.orm , this.decw, this.asl , this.asla, this.decx, this.cmpx, this.jmp ,
      this.clrp, this.tcall,this.set1, this.bbs , this.and , this.and , this.and , this.and , this.and , this.andm, this.or1n, this.rol , this.rol , this.pusha,this.cbne, this.bra ,
      this.bmi , this.tcall,this.clr1, this.bbc , this.and , this.and , this.and , this.and , this.andm, this.andm, this.incw, this.rol , this.rola, this.incx, this.cmpx, this.call,
      this.setp, this.tcall,this.set1, this.bbs , this.eor , this.eor , this.eor , this.eor , this.eor , this.eorm, this.and1, this.lsr , this.lsr , this.pushx,this.tclr1,this.pcall,
      this.bvc , this.tcall,this.clr1, this.bbc , this.eor , this.eor , this.eor , this.eor , this.eorm, this.eorm, this.cmpw, this.lsr , this.lsra, this.movxa,this.cmpy, this.jmp ,
      this.clrc, this.tcall,this.set1, this.bbs , this.cmp , this.cmp , this.cmp , this.cmp , this.cmp , this.cmpm, this.and1n,this.ror , this.ror , this.pushy,this.dbnz, this.ret ,
      this.bvs , this.tcall,this.clr1, this.bbc , this.cmp , this.cmp , this.cmp , this.cmp , this.cmpm, this.cmpm, this.addw, this.ror , this.rora, this.movax,this.cmpy, this.reti,
      this.setc, this.tcall,this.set1, this.bbs , this.adc , this.adc , this.adc , this.adc , this.adc , this.adcm, this.eor1, this.dec , this.dec , this.movy, this.popp, this.movm,
      this.bcc , this.tcall,this.clr1, this.bbc , this.adc , this.adc , this.adc , this.adc , this.adcm, this.adcm, this.subw, this.dec , this.deca, this.movxp,this.div , this.xcn ,
      this.ei  , this.tcall,this.set1, this.bbs , this.sbc , this.sbc , this.sbc , this.sbc , this.sbc , this.sbcm, this.mov1, this.inc , this.inc , this.cmpy, this.popa, this.movs,
      this.bcs , this.tcall,this.clr1, this.bbc , this.sbc , this.sbc , this.sbc , this.sbc , this.sbcm, this.sbcm, this.movw, this.inc , this.inca, this.movpx,this.das , this.mov ,
      this.di  , this.tcall,this.set1, this.bbs , this.movs, this.movs, this.movs, this.movs, this.cmpx, this.movsx,this.mov1s,this.movsy,this.movsy,this.movx, this.popx, this.mul ,
      this.bne , this.tcall,this.clr1, this.bbc , this.movs, this.movs, this.movs, this.movs, this.movsx,this.movsx,this.movws,this.movsy,this.decy, this.movay,this.cbne, this.daa ,
      this.clrv, this.tcall,this.set1, this.bbs , this.mov , this.mov , this.mov , this.mov , this.mov , this.movx, this.not1, this.movy, this.movy, this.notc, this.popy, this.sleep,
      this.beq , this.tcall,this.clr1, this.bbc , this.mov , this.mov , this.mov , this.mov , this.movx, this.movx, this.movm, this.movy, this.incy, this.movya,this.dbnzy,this.stop
    ];
    ]]

    Spc.functions = {
        Spc.nop, Spc.tcall, Spc.set1, Spc.bbs, Spc._or, Spc._or, Spc._or, Spc._or, Spc._or, Spc.orm, Spc.or1, Spc.asl, Spc.asl, Spc.pushp, Spc.tset1, Spc.brk,
        Spc.bpl, Spc.tcall, Spc.clr1, Spc.bbc, Spc._or, Spc._or, Spc._or, Spc._or, Spc.orm, Spc.orm, Spc.decw, Spc.asl, Spc.asla, Spc.decx, Spc.cmpx, Spc.jmp,
        Spc.clrp, Spc.tcall, Spc.set1, Spc.bbs, Spc._and, Spc._and, Spc._and, Spc._and, Spc._and, Spc.andm, Spc.or1n, Spc.rol, Spc.rol, Spc.pusha, Spc.cbne, Spc.bra,
        Spc.bmi, Spc.tcall, Spc.clr1, Spc.bbc, Spc._and, Spc._and, Spc._and, Spc._and, Spc.andm, Spc.andm, Spc.incw, Spc.rol, Spc.rola, Spc.incx, Spc.cmpx, Spc.call,
        Spc.setp, Spc.tcall, Spc.set1, Spc.bbs, Spc.eor, Spc.eor, Spc.eor, Spc.eor, Spc.eor, Spc.eorm, Spc.and1, Spc.lsr, Spc.lsr, Spc.pushx, Spc.tclr1, Spc.pcall,
        Spc.bvc, Spc.tcall, Spc.clr1, Spc.bbc, Spc.eor, Spc.eor, Spc.eor, Spc.eor, Spc.eorm, Spc.eorm, Spc.cmpw, Spc.lsr, Spc.lsra, Spc.movxa, Spc.cmpy, Spc.jmp,
        Spc.clrc, Spc.tcall, Spc.set1, Spc.bbs, Spc.cmp, Spc.cmp, Spc.cmp, Spc.cmp, Spc.cmp, Spc.cmpm, Spc.and1n, Spc.ror, Spc.ror, Spc.pushy, Spc.dbnz, Spc.ret,
        Spc.bvs, Spc.tcall, Spc.clr1, Spc.bbc, Spc.cmp, Spc.cmp, Spc.cmp, Spc.cmp, Spc.cmpm, Spc.cmpm, Spc.addw, Spc.ror, Spc.rora, Spc.movax, Spc.cmpy, Spc.reti,
        Spc.setc, Spc.tcall, Spc.set1, Spc.bbs, Spc.adc, Spc.adc, Spc.adc, Spc.adc, Spc.adc, Spc.adcm, Spc.eor1, Spc.dec, Spc.dec, Spc.movy, Spc.popp, Spc.movm,
        Spc.bcc, Spc.tcall, Spc.clr1, Spc.bbc, Spc.adc, Spc.adc, Spc.adc, Spc.adc, Spc.adcm, Spc.adcm, Spc.subw, Spc.dec, Spc.deca, Spc.movxp, Spc.div, Spc.xcn,
        Spc.ei, Spc.tcall, Spc.set1, Spc.bbs, Spc.sbc, Spc.sbc, Spc.sbc, Spc.sbc, Spc.sbc, Spc.sbcm, Spc.mov1, Spc.inc, Spc.inc, Spc.cmpy, Spc.popa, Spc.movs,
        Spc.bcs, Spc.tcall, Spc.clr1, Spc.bbc, Spc.sbc, Spc.sbc, Spc.sbc, Spc.sbc, Spc.sbcm, Spc.sbcm, Spc.movw, Spc.inc, Spc.inca, Spc.movpx, Spc.das, Spc.mov,
        Spc.di, Spc.tcall, Spc.set1, Spc.bbs, Spc.movs, Spc.movs, Spc.movs, Spc.movs, Spc.cmpx, Spc.movsx, Spc.mov1s, Spc.movsy, Spc.movsy, Spc.movx, Spc.popx, Spc.mul,
        Spc.bne, Spc.tcall, Spc.clr1, Spc.bbc, Spc.movs, Spc.movs, Spc.movs, Spc.movs, Spc.movsx, Spc.movsx, Spc.movws, Spc.movsy, Spc.decy, Spc.movay, Spc.cbne, Spc.daa,
        Spc.clrv, Spc.tcall, Spc.set1, Spc.bbs, Spc.mov, Spc.mov, Spc.mov, Spc.mov, Spc.mov, Spc.movx, Spc.not1, Spc.movy, Spc.movy, Spc.notc, Spc.popy, Spc.sleep,
        Spc.beq, Spc.tcall, Spc.clr1, Spc.bbc, Spc.mov, Spc.mov, Spc.mov, Spc.mov, Spc.movx, Spc.movx, Spc.movm, Spc.movy, Spc.incy, Spc.movya, Spc.dbnzy, Spc.stop
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

    function Spc.getAdr(mode)
        local eff = {}
        if mode == Spc.IMP then
            eff[0] = 0
            eff[1] = 0
        elseif mode == Spc.REL then
            eff[0] = Spc.mem.read(Spc.br[Spc.PC])
            Spc.br[Spc.PC] = Spc.br[Spc.PC] + 1
            if eff[0] < 0x80 then
                eff[1] = Spc.br[Spc.PC] + eff[0]
            else
                eff[1] = Spc.br[Spc.PC] - (0xff - eff[0])
            end
        elseif mode == Spc.DP then
            eff[0] = Spc.mem.read(Spc.br[Spc.PC])
            Spc.br[Spc.PC] = Spc.br[Spc.PC] + 1
            eff[1] = eff[0]
        elseif mode == Spc.DPR then
            eff[0] = Spc.mem.read(Spc.br[Spc.PC])
            Spc.br[Spc.PC] = Spc.br[Spc.PC] + 1
            eff[1] = Spc.r[Spc.D] + eff[0]
        elseif mode == Spc.DP then
            eff[0] = Spc.mem.read(Spc.br[Spc.PC])
            Spc.br[Spc.PC] = Spc.br[Spc.PC] + 1
            eff[1] = eff[0]
        elseif mode == Spc.ABS then
            eff[0] = Spc.mem.read(Spc.br[Spc.PC])
            Spc.br[Spc.PC] = Spc.br[Spc.PC] + 1
            eff[1] = Spc.mem.read(Spc.br[Spc.PC])
            Spc.br[Spc.PC] = Spc.br[Spc.PC] + 1
            eff[1] = bit.bor(eff[1], bit.lshift(eff[0], 8))
        elseif mode == Spc.IND then
            eff[0] = Spc.mem.read(Spc.br[Spc.PC])
            Spc.br[Spc.PC] = Spc.br[Spc.PC] + 1
            eff[1] = Spc.mem.read(Spc.br[Spc.PC])
            Spc.br[Spc.PC] = Spc.br[Spc.PC] + 1
            eff[1] = bit.bor(eff[1], bit.lshift(eff[0], 8))
            eff[1] = Spc.mem.read(eff[1])
            eff[1] = bit.bor(eff[1], bit.lshift(Spc.mem.read(eff[1] + 1), 8))
        end

        return eff
    end
end
