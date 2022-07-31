local awful = require("awful")

moniter = {}

moniter.cpu_temp = awful.widget.watch('bash -c "sensors | grep Package | cut -d \' \' -f 5 | cut -c 2-"', 1)

return moniter
