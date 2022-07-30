




-- source: https://stackoverflow.com/questions/43518465/overall-cpu-usage-and-memoryram-usage-in-percentage-in-linux-ubuntu

local mem_cmd = "free -t | awk \'FNR == 2 {printf(\"%.0f%\"), $3/$2*100}\'"

