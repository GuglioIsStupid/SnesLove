Apu = {
    snes = snes,
    spc = Spc,
    dsp = Dsp,

    bootRom = {
        0xcd, 0xef, 0xbd, 0xe8, 0x00, 0xc6, 0x1d, 0xd0, 0xfc, 0x8f, 0xaa, 0xf4, 0x8f, 0xbb, 0xf5, 0x78,
        0xcc, 0xf4, 0xd0, 0xfb, 0x2f, 0x19, 0xeb, 0xf4, 0xd0, 0xfc, 0x7e, 0xf4, 0xd0, 0x0b, 0xe4, 0xf5,
        0xcb, 0xf4, 0xd7, 0x00, 0xfc, 0xd0, 0xf3, 0xab, 0x01, 0x10, 0xef, 0x7e, 0xf4, 0x10, 0xeb, 0xba,
        0xf6, 0xda, 0x00, 0xba, 0xf4, 0xc4, 0xf4, 0xdd, 0x5d, 0xd0, 0xdb, 0x1f, 0x00, 0x00, 0xc0, 0xff
    },

    ram = {},

    spcWritePorts = {},
    spcReadPorts = {},

    reset = function()
        Apu.ram = Uint8Array(0x10000)
        Apu.spcWritePorts = Uint8Array(4)
        Apu.spcReadPorts = Uint8Array(6)

        Apu.dspAdr = 0
        Apu.dspRomReadable = true

        Apu.spc.reset()
        Apu.dsp.reset()

        Apu.cycles = 0
        Apu.timer1int = 0
        Apu.timer1div = 0
        Apu.timer1target = 0
        Apu.timer1counter = 0
        Apu.timer1enabled = false
        Apu.timer2int = 0
        Apu.timer2div = 0
        Apu.timer2target = 0
        Apu.timer2counter = 0
        Apu.timer2enabled = false
        Apu.timer3int = 0
        Apu.timer3div = 0
        Apu.timer3target = 0
        Apu.timer3counter = 0
        Apu.timer3enabled = false
    end,

    cycle = function()
        Apu.spc.cycle()

        if bit.band(Apu.cycles, 0x1f) == 0 then
            Apu.dsp.cycle()
        end

        if Apu.timer1int == 0 then
            Apu.timer1int = 128
            if Apu.timer1enabled then
                Apu.timer1div = Apu.timer1div + 1
                Apu.timer1div = bit.band(Apu.timer1div, 0xff)
                if Apu.timer1div == Apu.timer1target then
                    Apu.timer1div = 0
                    Apu.timer1counter = Apu.timer1counter + 1
                    Apu.timer1counter = bit.band(Apu.timer1counter, 0xf)
                end
            end
        end
        Apu.timer1int = Apu.timer1int - 1

        if Apu.timer2int == 0 then
            Apu.timer2int = 128
            if Apu.timer2enabled then
                Apu.timer2div = Apu.timer2div + 1
                Apu.timer2div = bit.band(Apu.timer2div, 0xff)
                if Apu.timer2div == Apu.timer2target then
                    Apu.timer2div = 0
                    Apu.timer2counter = Apu.timer2counter + 1
                    Apu.timer2counter = bit.band(Apu.timer2counter, 0xf)
                end
            end
        end
        Apu.timer2int = Apu.timer2int - 1

        if Apu.timer3int == 0 then
            Apu.timer3int = 16
            if Apu.timer3enabled then
                Apu.timer3div = Apu.timer3div + 1
                Apu.timer3div = bit.band(Apu.timer3div, 0xff)
                if Apu.timer3div == Apu.timer3target then
                    Apu.timer3div = 0
                    Apu.timer3counter = Apu.timer3counter + 1
                    Apu.timer3counter = bit.band(Apu.timer3counter, 0xf)
                end
            end
        end
        Apu.timer3int = Apu.timer3int - 1

        Apu.cycles = Apu.cycles + 1
    end,

    read = function(adr)
        adr = bit.band(adr, 0xffff)
        print(adr, #Apu.ram)

        if adr == 0xf0 or adr == 0xf1 or adr == 0xfa or adr == 0xfb or adr == 0xfc then
            return 0
        elseif adr == 0xf2 then
            return Apu.dspAdr
        elseif adr == 0xf3 then
            return Apu.dsp.read(bit.band(Apu.dspAdr, 0x7f))
        elseif adr == 0xf4 or adr == 0xf5 or adr == 0xf6 or adr == 0xf7 or adr == 0xf8 or adr == 0xf9 then
            return Apu.spcReadPorts[adr - 0xf4]
        elseif adr == 0xfd then
            local val = Apu.timer1counter
            Apu.timer1counter = 0
            return val
        elseif adr == 0xfe then
            local val = Apu.timer2counter
            Apu.timer2counter = 0
            return val
        elseif adr == 0xff then
            local val = Apu.timer3counter
            Apu.timer3counter = 0
            return val
        end

        if (adr >= 0xffc0 and Apu.dspRomReadable) then
            return Apu.bootRom[bit.band(adr, 0x3f)]
        end

        print(Apu.ram[adr])

        return Apu.ram[adr]
    end,

    write = function(adr, value)
        adr = bit.band(adr, 0xffff)

        if adr == 0xf0 then
            -- test register, not emulated
        elseif adr == 0xf1 then
            if not Apu.timer1enabled and bit.band(value, 0x01) > 0 then
                Apu.timer1div = 0
                Apu.timer1counter = 0
            end
            if not Apu.timer2enabled and bit.band(value, 0x02) > 0 then
                Apu.timer2div = 0
                Apu.timer2counter = 0
            end
            if not Apu.timer3enabled and bit.band(value, 0x04) > 0 then
                Apu.timer3div = 0
                Apu.timer3counter = 0
            end
            Apu.timer1enabled = bit.band(value, 0x01) > 0
            Apu.timer2enabled = bit.band(value, 0x02) > 0
            Apu.timer3enabled = bit.band(value, 0x04) > 0
            Apu.dspRomReadable = bit.band(value, 0x80) > 0
            if bit.band(value, 0x10) > 0 then
                Apu.spcReadPorts[0] = 0
                Apu.spcReadPorts[1] = 0
            end
            if bit.band(value, 0x20) > 0 then
                Apu.spcReadPorts[2] = 0
                Apu.spcReadPorts[3] = 0
            end
        elseif adr == 0xf2 then
            Apu.dspAdr = value
        elseif adr == 0xf3 then
            if Apu.dspAdr < 0x80 then
                Apu.dsp.write(Apu.dspAdr, value)
            end
        elseif adr == 0xf4 or adr == 0xf5 or adr == 0xf6 or adr == 0xf7 then
            Apu.spcWritePorts[adr - 0xf4] = value
        elseif adr == 0xf8 or adr == 0xf9 then
            Apu.spcReadPorts[adr - 0xf4] = value
        elseif adr == 0xfa then
            Apu.timer1target = value
        elseif adr == 0xfb then
            Apu.timer2target = value
        elseif adr == 0xfc then
            Apu.timer3target = value
        end

        Apu.ram[adr] = value
    end,

    setSamples = function(left, right, sampleCount)
        local add = 534 / sampleCount
        local total = 0
        for i = 0, sampleCount - 1 do
            left[i] = Apu.dsp.samplesL[bit.band(total, 0xffff)]
            right[i] = Apu.dsp.samplesR[bit.band(total, 0xffff)]
            total = total + add
        end
        Apu.dsp.sampleOffset = 0
    end
}
Spc.set(Apu)
Apu.reset()
Spc.reset()