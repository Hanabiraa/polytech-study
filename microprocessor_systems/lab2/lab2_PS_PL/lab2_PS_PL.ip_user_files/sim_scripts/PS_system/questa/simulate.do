onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib PS_system_opt

do {wave.do}

view wave
view structure
view signals

do {PS_system.udo}

run -all

quit -force
