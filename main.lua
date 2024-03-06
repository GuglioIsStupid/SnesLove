--[[
    let c = el("output");
c.width = 512;
c.height = 480;
let ctx = c.getContext("2d");
let imgData = ctx.getImageData(0, 0, 512, 480);
]] -- for love2d
love.graphics.setDefaultFilter("nearest", "nearest")
local c = love.graphics.newCanvas(512, 480)
local imgData = c:newImageData()

local loopId = 0
local loaded = false
local paused = false
local pausedInBg = false
local logging = false

local filename = "test.sfc"
local file = io.open(filename, "rb")
local data = file:read("*a")
file:close()

local arr = {}
for i = 1, #data do
    arr[i] = string.byte(data:sub(i, i))
end

local function loadSpc(arr)
    --[[ if player.loadSpc(arr) then
        if not loaded and not paused then
            loopId = math.floor(love.timer.getTime() * 1000)
            --audioHandler.start()
        end
        loaded = true
    end ]]
end

local function drawVisual()
--[[
    ctx.fillStyle = "#000000";
  ctx.fillRect(0, 0, c.width, c.height);
  // draw text
  ctx.fillStyle = "#7fff7f";
  ctx.font = "12pt arial";
  ctx.fillText("Title:", 20, 25);
  ctx.fillText("Game:", 20, 45);
  ctx.fillText("Artist:", 20, 65);
  ctx.fillText("Dumper:", 20, 85);
  ctx.fillText("Comment:", 20, 105);
  ctx.fillText(player.tags.title, 100, 25);
  ctx.fillText(player.tags.game, 100, 45);
  ctx.fillText(player.tags.artist, 100, 65);
  ctx.fillText(player.tags.dumper, 100, 85);
  ctx.fillText(player.tags.comment, 100, 105);
  // draw visualisation per channel
  for(let i = 0; i < 8; i++) {
    ctx.fillStyle = "#3f1f1f";
    ctx.fillRect(10 + i * 55 + 5, 470 - 300, 10, 300);
    ctx.fillStyle = "#1f3f1f";
    ctx.fillRect(10 + i * 55 + 15, 470 - 300, 10, 300);
    ctx.fillStyle = "#3f3f1f";
    ctx.fillRect(10 + i * 55 + 25, 470 - 300, 10, 300);
    ctx.fillStyle = "#1f1f3f";
    ctx.fillRect(10 + i * 55 + 40, 470 - 300, 10, 300);
    ctx.fillStyle = "#ff7f7f";
    let scale = Math.abs(player.apu.dsp.channelVolumeL[i]) * 300 / 0x80;
    ctx.fillRect(10 + i * 55 + 5, 470 - scale, 10, scale);
    ctx.fillStyle = "#7fff7f";
    scale = Math.abs(player.apu.dsp.channelVolumeR[i]) * 300 / 0x80;
    ctx.fillRect(10 + i * 55 + 15, 470 - scale, 10, scale);
    ctx.fillStyle = "#ffff7f";
    scale = player.apu.dsp.gain[i] * 300 / 0x7ff;
    ctx.fillRect(10 + i * 55 + 25, 470 - scale, 10, scale);
    ctx.fillStyle = "#7f7fff";
    scale = player.apu.dsp.pitch[i] * 290 / 0x3fff;
    ctx.fillRect(10 + i * 55 + 40, 470 - scale - 10, 10, 10);
  }
]]

  love.graphics.setCanvas(c)
    love.graphics.clear()   
    love.graphics.setColor(0, 0, 0)
    love.graphics.rectangle("fill", 0, 0, 512, 480)
    love.graphics.setColor(0, 1, 0)
    love.graphics.print("Title:", 20, 25)
    love.graphics.print("Game:", 20, 45)
    love.graphics.print("Artist:", 20, 65)
    love.graphics.print("Dumper:", 20, 85)
    love.graphics.print("Comment:", 20, 105)
    --[[ love.graphics.print(player.tags.title, 100, 25)
    love.graphics.print(player.tags.game, 100, 45)
    love.graphics.print(player.tags.artist, 100, 65)
    love.graphics.print(player.tags.dumper, 100, 85)
    love.graphics.print(player.tags.comment, 100, 105) ]]

    for i = 0, 7 do
        love.graphics.setColor(0.25, 0.125, 0.125)
        love.graphics.rectangle("fill", 10 + i * 55 + 5, 470 - 300, 10, 300)
        love.graphics.setColor(0.125, 0.25, 0.125)
        love.graphics.rectangle("fill", 10 + i * 55 + 15, 470 - 300, 10, 300)
        love.graphics.setColor(0.25, 0.25, 0.125)
        love.graphics.rectangle("fill", 10 + i * 55 + 25, 470 - 300, 10, 300)
        love.graphics.setColor(0.125, 0.125, 0.25)
        love.graphics.rectangle("fill", 10 + i * 55 + 40, 470 - 300, 10, 300)
        love.graphics.setColor(1, 0.5, 0.5)
        local scale = --[[ math.abs(player.apu.dsp.channelVolumeL[i]) * 300 / 0x80 ]] 1
        love.graphics.rectangle("fill", 10 + i * 55 + 5, 470 - scale, 10, scale)
        love.graphics.setColor(0.5, 1, 0.5)
        scale = --[[ math.abs(player.apu.dsp.channelVolumeR[i]) * 300 / 0x80 ]] 1
        love.graphics.rectangle("fill", 10 + i * 55 + 15, 470 - scale, 10, scale)
        love.graphics.setColor(1, 1, 0.5)
        scale = --[[ player.apu.dsp.gain[i] * 300 / 0x7ff ]] 1
        love.graphics.rectangle("fill", 10 + i * 55 + 25, 470 - scale, 10, scale)
        love.graphics.setColor(0.5, 0.5, 1)
        scale = --[[ player.apu.dsp.pitch[i] * 290 / 0x3fff ]] 1
        love.graphics.rectangle("fill", 10 + i * 55 + 40, 470 - scale - 10, 10, 10)
    end
    love.graphics.setCanvas()
    love.graphics.draw(c)
end

local function runFrame()
    if logging then
        repeat
            player.cycle()
        until player.apu.spc.cyclesLeft <= 0
        --log(getSpcTrace(player.apu.spc, player.apu.cycles))
    else
        --player.runFrame()
    end
    --player.setSamples(audioHandler.sampleBufferL, audioHandler.sampleBufferR, audioHandler.samplesPerFrame)
    --audioHandler.nextBuffer()
    drawVisual()
end

local function update()
    loopId = math.floor(love.timer.getTime() * 1000)
end

loadSpc(arr)


love.draw = runFrame