# udev

list tree of device:
`udevadm info --attribute-walk --name=/dev/ttyACM1 |less`

make a rule to let you use a serial port:
```
ATTRS{idVendor}=="0483", ATTRS{idProduct}=="3748", MODE="664", GROUP="plugdev"
```


# configs
to reload config:
`sudo udevadm trigger`

## circuitpython on teensy 4.0
```
echo 'ATTRS{idVendor}=="239a", ATTRS{idProduct}=="8086", MODE="664", GROUP="plugdev"' |sudo tee /etc/udev/rules.d/teensy-4.0-circuitpython.rules
```

