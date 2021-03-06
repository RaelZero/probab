local http = require("socket.http")

-- checks the RANDOM.ORG quota for the current IP
function checkQuota()
    -- get current IP
    ip , errcode = http.request("http://curlmyip.com/")
    ip = string.sub(ip, 1, -2)
    
    -- if return code is not 200, don't even bother trying
    errcode = tonumber(errcode)
    if (errcode ~= 200) then return -1 end
    
    -- factor URL
    url = "http://www.random.org/quota/?ip=" .. ip .. "&format=plain"
    
    -- get quota from RANDOM.ORG, refactor the string and return
    quota = http.request(url)
    quota = tonumber(quota)
    print(quota)
    
    return quota
end

function pullRandomBits(number, minv, maxv)
    currentQuota = checkQuota()
    
    -- only run if there is enough quota to satisfy the request
    if (currentQuota == -1) then return -1
    elseif (currentQuota >= number*8) then
        -- creates the URL
        url = "http://www.random.org/integers/?num=" .. number .. "&min=" .. minv .. "&max=" .. maxv .. "&col=1&base=10&format=plain&rnd=new"
        
        -- pulls data from RANDOM.ORG servers
        randoms = http.request(url)
        
        -- writes everything to res/randoms.txt files
        io.output("res/randoms.txt")
        io.write(randoms)
        io.close()  
    end
end

function debug()
    pullRandomBits(5,1,6)
    print("It works!")
end