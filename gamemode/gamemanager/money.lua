Money = {} 

local TS_CASH = {}
local TS_BANK = {}
local TS_WEAPONS = {}

local function correct(ent)
    if ent.GetName == nil then return ent end
    return ent:GetName()
end

local function getCash(ply)
    return TS_CASH[correct(ply)]
end

local function getBank(ply)
    return TS_BANK[correct(ply)]
end

local function setCash(ply, amount)
    TS_CASH[correct(ply)] = amount
end

local function setBank(ply, amount)
    TS_BANK[correct(ply)] = amount
end

local function addCash(ply, amount)
    setCash(ply, getCash(ply) + amount)
end

local function addBank(ply, amount)
    setBank(ply, getBank(ply) + amount)
end

local function transferBC(ply, amount)
    if amount < 0 and getCash(ply) < (amount * -1) then return false end
    if amount > 0 and getBank(ply) < amount then return false end
    addBank(ply, amount*-1)
    addCash(amount)
    return true
end

local function getWeapon(wp)
    return TS_WEAPONS[correct(wp)]
end

local function setWeapon(wp, amount)
    TS_WEAPONS[correct(wp)] = amount
end

local function addWeapon(wp, amount)
    setWeapon(wp, getWeapon() + amount)
end

local function roundFinish()
    for wp, amount in pairs(TS_WEAPONS) do
        local adding = math.random(CONF.MinWeapon,CONF.MaxWeapon)
        addWeapon(wp, adding)
    end
end

local function sendCash(ply)
    net.Start("money_cash")
    net.WriteInt(getCash(ply), 16)
    net.Send(ply)
end

local function broadcast(ply, amount, etype)
    net.Start("money_"..etype)
    net.WriteString(ply)
    net.WriteInt(amount, 32)
    net.BroadCast()
end

Money.TS_CASH = TS_CASH
Money.TS_BANK = TS_BANK
Money.TS_WEAPONS = TS_WEAPONS
Money.getCash = getCash
Money.getBank = getBank
Money.setCash = setCash
Money.setBank = setBank
Money.addCash = addCash
Money.addBank = addBank
Money.transferBC = transferBC
Money.getWeapon = getWeapon
Money.setWeapon = setWeapon
Money.addWeapon = addWeapon
Money.roundFinish = roundFinish