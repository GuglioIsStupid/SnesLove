local utf8 = require("utf8")

local function bytetoascii(byte)
    if byte < 0x20 or byte > 0x7e then
        return "."
    end
    return string.upper(string.char(byte))
end

player = {
    apu = Apu,
    loadedFile = nil,
    reset = function()
        player.apu.reset()
        player.tags = {
            title = "",
            game = "",
            dumper = "",
            comment = "",
            artist = ""
        }
        if player.loadedFile then
            print("File loaded")
            return player.parseSpc(player.loadedFile)
        else
            print("No file loaded")
            return false
        end
    end,
    cycle = function()
        print("Cycling")
        player.apu.cycle()
    end,
    runFrame = function()
        for i = 0, 17088 do
            player:cycle()
        end
    end,
    setSamples = function(left, right, samples)
        player.apu.setSamples(left, right, samples)
    end,
    loadSpc = function(file)
        player.loadedFile = file
        return player.reset()
    end,
    parseSpc = function(file)
        if #file < 0x10200 then
            return false
        end
        player.apu.spc.br[0] = bit.bor(file[0x25], bit.lshift(file[0x26], 8))
        player.apu.spc.r[0] = file[0x27]
        player.apu.spc.r[1] = file[0x28]
        player.apu.spc.r[2] = file[0x29]
        player.apu.spc.r[3] = file[0x2b]
        player.apu.spc.setP(file[0x2a])
        player.tags.title = ""
        --Title found at 0007FC0 for 21 bytes
        for i = 1, 21 do
            if file[0x7fc0 + i] == 0 then
                break
            end
            player.tags.title = player.tags.title .. string.char(file[0x7fc0 + i])
        end
        print("Title: " .. player.tags.title)
        player.tags.game = ""
        for i = 1, 32 do
            if file[0x4e + i] == 0 then
                break
            end
            player.tags.game = player.tags.game .. string.char(file[0x4e + i])
        end
        print("Game: " .. player.tags.game)
        player.tags.dumper = ""
        for i = 1, 16 do
            if file[0x6e + i] == 0 then
                break
            end
            player.tags.dumper = player.tags.dumper .. string.char(file[0x6e + i])
        end
        print("Dumper: " .. player.tags.dumper)
        player.tags.comment = ""
        for i = 1, 32 do
            if file[0x7e + i] == 0 then
                break
            end
            player.tags.comment = player.tags.comment .. string.char(file[0x7e + i])
        end
        print("Comment: " .. player.tags.comment)
        player.tags.artist = ""
        for i = 1, 32 do
            if file[0xFFDA + i] == 0 then
                break
            end
            player.tags.artist = player.tags.artist .. string.char(file[0xFFDA + i])
        end
        print("Artist: " .. player.tags.artist)
        for i = 1, 0x10000 do
            player.apu.ram[i] = file[0x100 + i]
        end
        for i = 1, 16 do
            if i ~= 3 then
                player.apu.write(0xf0 + i, file[0x1f0 + i])
            end
        end
        for i = 1, 0x80 do
            if i ~= 0x4c then
                player.apu.dsp.write(i, file[0x10100 + i])
            end
        end
        player.apu.dsp.write(0x4c, file[0x1014c])
        for i = 1, 0x40 do
            player.apu.ram[0xffc0 + i] = file[0x101c0 + i]
        end
        player.apu.spcReadPorts[0] = player.apu.spcWritePorts[0]
        player.apu.spcReadPorts[1] = player.apu.spcWritePorts[1]
        player.apu.spcReadPorts[2] = player.apu.spcWritePorts[2]
        player.apu.spcReadPorts[3] = player.apu.spcWritePorts[3]
        return true
    end
}

player:reset()